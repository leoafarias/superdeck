import 'package:dash_deck/components/atoms/markdown_viewer.dart';
import 'package:dash_deck_demo/chat/components/copy_to_clipboard_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageBubble extends HookWidget {
  final String message;
  final bool isMe;
  final bool isTyping;

  const MessageBubble(
    this.message, {
    required this.isMe,
    this.isTyping = false,
    super.key,
  });

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: Icon(
        isMe ? Icons.person : Icons.bolt,
        size: 20,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  Widget _buildMessageContent() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 16,
        top: 16,
        bottom: 16,
      ),
      child: MarkdownView(message),
    );
  }

  Widget _buildCopyButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        child: CopyToClipboardButton(
          content: message,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hover = useState(false);

    return MouseRegion(
      onEnter: (event) => hover.value = true,
      onExit: (event) => hover.value = false,
      child: Row(
        children: [
          Flexible(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isMe ? Colors.black12 : Colors.black26,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIcon(context),
                      Flexible(child: _buildMessageContent()),
                    ],
                  ),
                ),
                if (hover.value) _buildCopyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonBubbleStructure extends StatelessWidget {
  final List<Widget> children;

  const CommonBubbleStructure({Key? key, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class LoadingBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const LoadingBubble(
    this.message, {
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBubbleStructure(
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        Flexible(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
