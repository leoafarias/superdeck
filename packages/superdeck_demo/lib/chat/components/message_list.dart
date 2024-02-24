import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:superdeck_demo/chat/components/bubble.dart';
import 'package:superdeck_demo/chat/controllers/chat_controller.dart';

class MessageList extends HookConsumerWidget {
  const MessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = useScrollController();

    final messages = ref.watch(messagesProvider);
    return ListView.builder(
      controller: scrollController,
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        return MessageBubble(message);
      },
    );
  }
}
