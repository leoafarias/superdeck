import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../modules/chat/components/typing_indicator.dart';
import '../../modules/chat/prompt.dart';
import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/extensions.dart';
import '../atoms/markdown_viewer.dart';

const _apiKey = '';

const _geminiFlash = 'gemini-1.5-flash-latest';
const _geminiPro = 'gemini-1.5-pro';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gemini',
          style: context.textTheme.bodySmall,
        ),
      ),
      body: const ChatWidget(apiKey: _apiKey),
    );
  }
}

class ChatWidget extends StatefulHookWidget {
  const ChatWidget({
    required this.apiKey,
    super.key,
  });

  final String apiKey;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

typedef GeneratedContent = ({Image? image, String? text, bool fromUser});

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  final _generatedContent = <GeneratedContent>[];

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
        model: _geminiPro,
        apiKey: widget.apiKey,
        systemInstruction: Content.system(
          presentationAssistantPrompt,
        ));
    if (kCanRunProcess) {
      // ReferenceService.instance.loadMarkdown().then((value) {
      //   final content = '<PRESENTATION>\n$value\n</PRESENTATION>';
      //   _chat = _model.startChat(history: [
      //     // add <PRESENTATION> around value
      //     Content.text(content),
      //   ]);
      // });
    } else {
      _chat = _model.startChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final loading = useState(false);
    final applyChanges = useState(false);

    void scrollDown() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeOutCirc,
        ),
      );
    }

    final sendChatMessage = useCallback((String message) async {
      loading.value = true;

      textController.clear();

      try {
        if (!applyChanges.value) {
          _generatedContent.add((image: null, text: message, fromUser: true));
        }
        final response = await _chat.sendMessage(
          Content.text(message),
        );
        final text = response.text;
        if (!applyChanges.value) {
          _generatedContent.add((image: null, text: text, fromUser: false));
        } else {
          // Replace <PRESENTATION> and </PRESENTATION> with empty string
          final provideMarkdownEdits = text!
              .replaceAll('<PRESENTATION>', '')
              .replaceAll('</PRESENTATION>', '');
          // await ReferenceService.instance.saveMarkdown(provideMarkdownEdits);
          _generatedContent.add((
            image: null,
            text: 'I have applied the changes.',
            fromUser: false
          ));
        }

        if (text == null) {
          _showError('No response from API.');
          return;
        } else {
          loading.value = false;
          scrollDown();
        }
      } catch (e) {
        _showError(e.toString());
      } finally {
        loading.value = false;
      }
    }, []);

    final textFieldFocus = useFocusNode(
      onKeyEvent: (node, event) {
        if (event is KeyUpEvent) {
          return KeyEventResult.ignored;
        }

        final isEnterKey = event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter;

        if (HardwareKeyboard.instance.isShiftPressed && isEnterKey) {
          textController.value = TextEditingValue(
            text: '${textController.text}\n',
            selection:
                TextSelection.collapsed(offset: textController.text.length + 1),
          );
          return KeyEventResult.handled;
        }

        if (isEnterKey) {
          if (event is KeyDownEvent) {
            sendChatMessage(textController.text);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
    );
    useEffect(() {
      if (!loading.value) {
        textFieldFocus.requestFocus();
      }
    }, [loading.value]);

    Widget buildSendButton() {
      if (!loading.value) {
        return IconButton(
          onPressed: () async {
            sendChatMessage(textController.text);
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      return const Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: WaitingIndicator(isTyping: true),
      );
    }

    Widget buildApplyChangesButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () async {
            applyChanges.value = true;
            sendChatMessage(provideMarkdownEdits);
          },
          icon: Icon(
            Icons.bolt,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    final textFieldDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.black45,
      hoverColor: Colors.black45,
      hintText: loading.value ? '' : 'Type a message',
      enabled: !loading.value,
      hintStyle: const TextStyle(color: Colors.white),
      suffixIcon: buildSendButton(),
      prefixIcon: buildApplyChangesButton(),
      suffixIconConstraints: const BoxConstraints(
        minWidth: 20,
        minHeight: 20,
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 20,
        minHeight: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _apiKey.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemBuilder: (context, idx) {
                      final content = _generatedContent[idx];
                      return MessageWidget(
                        text: content.text,
                        image: content.image,
                        isFromUser: content.fromUser,
                      );
                    },
                    itemCount: _generatedContent.length,
                  )
                : ListView(
                    children: const [
                      Text(
                        'No API key found. Please provide an API Key using '
                        "'--dart-define' to set the 'API_KEY' declaration.",
                      ),
                    ],
                  ),
          ),
          Row(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 80),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      enabled: !loading.value,
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      expands: true,
                      style: context.textTheme.bodyMedium,
                      focusNode: textFieldFocus,
                      decoration: textFieldDecoration,
                      maxLines: null,
                      controller: textController,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    this.image,
    this.text,
    required this.isFromUser,
  });

  final Image? image;
  final String? text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                decoration: BoxDecoration(
                  color: isFromUser
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Column(children: [
                  if (text case final text?)
                    MarkdownBody(
                      data: text,
                      builders: {
                        'code': SampleCodeElementBuilder(null),
                      },
                    ),
                  if (image case final image?) image,
                ]))),
      ],
    );
  }
}
