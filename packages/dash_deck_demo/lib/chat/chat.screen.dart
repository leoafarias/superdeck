import 'package:dash_deck_demo/chat/components/message_input.dart';
import 'package:dash_deck_demo/chat/components/message_list.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: MessageList(),
          ),
          MessageInput()
        ],
      ),
    );
  }
}
