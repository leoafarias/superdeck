import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../chat/components/typing_indicator.dart';
import '../../chat/prompt.dart';
import '../../helpers/constants.dart';
import '../../helpers/extensions.dart';
import '../../services/reference_service.dart';
import '../atoms/markdown_viewer.dart';

const _apiKey = '';

final _geminiFlash = 'gemini-1.5-flash-latest';
final _geminiPro = 'gemini-1.5-pro';

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
      ReferenceService.instance.loadMarkdown().then((value) {
        final content = '<PRESENTATION>\n$value\n</PRESENTATION>';
        _chat = _model.startChat(history: [
          // add <PRESENTATION> around value
          Content.text(content),
        ]);
      });
    } else {
      _chat = _model.startChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _textController = useTextEditingController();
    final _scrollController = useScrollController();
    final _loading = useState(false);
    final _applyChanges = useState(false);

    void _scrollDown() {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeOutCirc,
        ),
      );
    }

    final _sendChatMessage = useCallback((String message) async {
      _loading.value = true;

      _textController.clear();

      try {
        if (!_applyChanges.value) {
          _generatedContent.add((image: null, text: message, fromUser: true));
        }
        final response = await _chat.sendMessage(
          Content.text(message),
        );
        final text = response.text;
        if (!_applyChanges.value) {
          _generatedContent.add((image: null, text: text, fromUser: false));
        } else {
          // Replace <PRESENTATION> and </PRESENTATION> with empty string
          final provideMarkdownEdits = text!
              .replaceAll('<PRESENTATION>', '')
              .replaceAll('</PRESENTATION>', '');
          await ReferenceService.instance.saveMarkdown(provideMarkdownEdits);
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
          _loading.value = false;
          _scrollDown();
        }
      } catch (e) {
        _showError(e.toString());
      } finally {
        _loading.value = false;
      }
    }, []);

    final _textFieldFocus = useFocusNode(
      onKeyEvent: (node, event) {
        if (event is KeyUpEvent) {
          return KeyEventResult.ignored;
        }

        final isEnterKey = event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter;

        if (HardwareKeyboard.instance.isShiftPressed && isEnterKey) {
          _textController.value = TextEditingValue(
            text: _textController.text + '\n',
            selection: TextSelection.collapsed(
                offset: _textController.text.length + 1),
          );
          return KeyEventResult.handled;
        }

        if (isEnterKey) {
          if (event is KeyDownEvent) {
            _sendChatMessage(_textController.text);
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
    );
    useEffect(() {
      if (!_loading.value) {
        _textFieldFocus.requestFocus();
      }
    }, [_loading.value]);

    Widget _buildSendButton() {
      if (!_loading.value) {
        return IconButton(
          onPressed: () async {
            _sendChatMessage(_textController.text);
          },
          icon: Icon(
            Icons.send,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: WaitingIndicator(isTyping: true),
      );
    }

    Widget _buildApplyChangesButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: () async {
            _applyChanges.value = true;
            _sendChatMessage(provideMarkdownEdits);
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
      hintText: _loading.value ? '' : 'Type a message',
      enabled: !_loading.value,
      hintStyle: TextStyle(color: Colors.white),
      suffixIcon: _buildSendButton(),
      prefixIcon: _buildApplyChangesButton(),
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
                    controller: _scrollController,
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextField(
                      enabled: !_loading.value,
                      keyboardType: TextInputType.multiline,
                      autofocus: true,
                      expands: true,
                      style: context.textTheme.bodyMedium,
                      focusNode: _textFieldFocus,
                      decoration: textFieldDecoration,
                      maxLines: null,
                      controller: _textController,
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
