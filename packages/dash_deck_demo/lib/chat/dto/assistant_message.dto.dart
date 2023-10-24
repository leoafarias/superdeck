import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';

import 'chat_message.dto.dart';

part 'assistant_message.dto.mapper.dart';

enum AssistantMessageStatus {
  thinking,
  typing,
  done,
}

@MappableClass()
class AssistantChatMessage extends ChatMessage
    with AssistantChatMessageMappable {
  final AssistantMessageStatus status;
  const AssistantChatMessage({
    required String content,
    required DateTime createdAt,
    this.status = AssistantMessageStatus.done,
    bool? hidden = false,
  }) : super(
          role: MessageRole.assistant,
          content: content,
          createdAt: createdAt,
          hidden: hidden ?? false,
        );

  // Returns a new instance of ChatMessage that
  AssistantChatMessage copyWithDelta({
    String? deltaContent,
    DateTime? createdAt,
  }) {
    return AssistantChatMessage(
      content: content + (deltaContent ?? ''),
      createdAt: createdAt ?? this.createdAt,
      hidden: hidden,
    );
  }

  static const fromMap = AssistantChatMessageMapper.fromMap;
  static const fromJson = AssistantChatMessageMapper.fromJson;
}
