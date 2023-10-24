import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/dto/assistant_message.dto.dart';
import 'package:dash_deck_demo/chat/dto/user_message.dto.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';

part 'chat_message.dto.mapper.dart';

class MessageRoleMapper extends SimpleMapper<MessageRole> {
  const MessageRoleMapper();

  @override
  MessageRole decode(dynamic value) {
    return MessageRole.values.firstWhere(
      (element) => element.name.toString() == value,
    );
  }

  @override
  dynamic encode(MessageRole self) {
    return self.name.toString();
  }
}

@MappableClass(discriminatorKey: 'type', includeSubClasses: [
  UserChatMessage,
  AssistantChatMessage,
], includeCustomMappers: [
  MessageRoleMapper()
])
class ChatMessage with ChatMessageMappable {
  final MessageRole role;

  /// Hide the message from the UI
  final bool hidden;
  final String content;
  final DateTime createdAt;

  const ChatMessage({
    required this.role,
    required this.content,
    required this.createdAt,
    this.hidden = false,
  });

  static ChatMessage from({
    required MessageRole role,
    required String content,
    required DateTime createAt,
    bool hidden = false,
  }) {
    if (role == MessageRole.assistant) {
      return AssistantChatMessage(
        content: content,
        createdAt: createAt,
        hidden: hidden,
      );
    } else {
      return UserChatMessage(
        content: content,
        createdAt: createAt,
        hidden: hidden,
      );
    }
  }
}
