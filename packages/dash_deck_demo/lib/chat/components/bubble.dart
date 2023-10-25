import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck_demo/chat/components/copy_to_clipboard_button.dart';
import 'package:dash_deck_demo/chat/dto/assistant_message.dto.dart';
import 'package:dash_deck_demo/chat/dto/chat_message.dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageBubble extends HookWidget {
  final ChatMessage message;

  const MessageBubble(
    this.message, {
    Key? key,
  }) : super(key: key);

  bool get _isMe => message.isUser;

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);

    return MouseRegion(
      onEnter: (event) => hover.value = true,
      onExit: (event) => hover.value = false,
      child: CommonBubbleStructure(
        message: message,
        hover: hover.value,
      ),
    );
  }
}

class CommonBubbleStructure extends StatelessWidget {
  final bool hover;

  final ChatMessage message;
  const CommonBubbleStructure({
    super.key,
    required this.message,
    required this.hover,
  });

  bool get _isMe => message.isUser;

  Widget buildIcon(BuildContext context) {
    final assistantMessage = message;
    if (assistantMessage is AssistantMessage) {
      if (assistantMessage.status == ResponseStatus.waitingResponse) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        );
      }

      if (assistantMessage.status == ResponseStatus.done) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Icon(
            Icons.check,
            size: 20,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Icon(
        _isMe ? Icons.person : Icons.bolt,
        size: 20,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget buildCopyButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: CopyToClipboardButton(content: message.content),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageRef = message;
    if (messageRef is AssistantMessage) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black26,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildIcon(context),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Text(messageRef.content,
                      style: Theme.of(context).textTheme.bodyMedium)),
            ),
            const SizedBox(width: 20)
          ],
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _isMe ? Colors.black12 : Colors.black26,
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildIcon(context),
              Flexible(child: SlideContent(message.content)),
              const SizedBox(width: 20)
            ],
          ),
          if (hover) buildCopyButton(),
        ],
      ),
    );
  }
}
