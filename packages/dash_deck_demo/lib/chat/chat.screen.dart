import 'package:dash_deck_demo/chat/components/bubble.dart';
import 'package:dash_deck_demo/chat/components/typing_indicator.dart';
import 'package:dash_deck_demo/chat/controllers/chat_controller.dart';
import 'package:dash_deck_demo/chat/dto/user_message.dto.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textController = useTextEditingController();
    final ScrollController scrollController = useScrollController();

    final aboutDeck = useState(false);

    final waitingResponse = ref.watch(waitingResponseProvider);
    final messages = ref.watch(messagesProvider);
    final controller = ref.watch(chatControllerProvider.notifier);

    void handleSubmit() async {
      final message = textController.text;

      if (message.isEmpty) {
        return;
      }
      final userMessage = UserChatMessage(
        content: message,
        createdAt: DateTime.now(),
      );

      controller.sendMessage(userMessage);

      textController.clear();
    }

    Widget buildSendButton({
      required bool isTyping,
    }) {
      if (isTyping) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: TypingIndicator(isTyping: true),
            ),
          ],
        );
      }
      return IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.send),
        iconSize: 18,
        onPressed: () {
          handleSubmit();
        },
      );
    }

    final focusNode = FocusNode(
      onKey: (
        FocusNode node,
        RawKeyEvent event,
      ) {
        // Ignore for key up events
        if (event is RawKeyUpEvent) {
          return KeyEventResult.ignored;
        }

        final isEnterKey = event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter;

        if (event.isShiftPressed && isEnterKey) {
          textController.value = TextEditingValue(
            text: '${textController.text}\n',
            selection: TextSelection.collapsed(
              offset: textController.text.length + 1,
            ),
          );
          return KeyEventResult.handled;
        }

        if (isEnterKey) {
          if (event is RawKeyDownEvent) {
            handleSubmit();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Theme.of(context).colorScheme.background,
        titleTextStyle: Theme.of(context).textTheme.titleSmall,
        centerTitle: false,
        title: const Text('Assistant'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(
                  message.content,
                  isMe: message.role == MessageRole.user,
                  isTyping: waitingResponse && index == 0,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              focusNode: focusNode,
              enabled: !waitingResponse,
              minLines: 1,
              maxLines: null,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceVariant
                    .withOpacity(0.4),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: buildSendButton(
                  isTyping: waitingResponse,
                ),
                prefixIcon: Tooltip(
                  message: 'About the deck',
                  child: IconButton(
                    icon: const Icon(Icons.slideshow),
                    color: aboutDeck.value ? Colors.blue : Colors.grey,
                    iconSize: 18,
                    onPressed: () {
                      aboutDeck.value = !aboutDeck.value;
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
