import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';

import 'chat_message.dto.dart';

part 'assistant_message.dto.mapper.dart';

@MappableClass()
class AssistantMessage extends ChatMessage with AssistantMessageMappable {
  const AssistantMessage({
    required super.content,
    super.status,
    super.createdAt,
    super.hidden,
  }) : super(role: MessageRole.assistant);

  // Returns a new instance of ChatMessage that
  AssistantMessage copyWithDelta({
    String? deltaContent,
    DateTime? createdAt,
    bool? hidden,
    MessageStatus? status,
  }) {
    return AssistantMessage(
      content: content + (deltaContent ?? ''),
      createdAt: createdAt ?? this.createdAt,
      hidden: hidden ?? this.hidden,
      status: status ?? this.status,
    );
  }

  static const fromMap = AssistantMessageMapper.fromMap;
  static const fromJson = AssistantMessageMapper.fromJson;
}

@MappableClass()
class PromptMessage extends AssistantMessage with PromptMessageMappable {
  final String response;
}
