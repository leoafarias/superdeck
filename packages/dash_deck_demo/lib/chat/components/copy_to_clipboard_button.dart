import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyToClipboardButton extends StatelessWidget {
  final String content;
  final String notificationMessage;

  final Icon? icon;

  const CopyToClipboardButton({
    super.key,
    required this.content,
    this.notificationMessage = 'Copied to clipboard',
    this.icon,
  });

  void _handleOnPress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(notificationMessage),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: IconButton(
        onPressed: () => _handleOnPress(context),
        icon: icon ??
            const Icon(
              Icons.content_copy,
              size: 16.0,
            ),
      ),
    );
  }
}
