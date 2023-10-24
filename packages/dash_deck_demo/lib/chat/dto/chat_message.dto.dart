import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_demo/chat/dto/assistant_message.dto.dart';
import 'package:dash_deck_demo/chat/dto/user_message.dto.dart';
import 'package:dash_deck_demo/chat/enum/chat_roles.enum.dart';

part 'chat_message.dto.mapper.dart';

@MappableEnum()
enum MessageStatus {
  typing,
  done,
}

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
  UserMessage,
  AssistantMessage,
], includeCustomMappers: [
  MessageRoleMapper()
])
abstract class ChatMessage with ChatMessageMappable {
  final MessageRole role;

  /// Hide the message from the UI
  final bool hidden;
  final String content;
  final DateTime? createdAt;

  final MessageStatus status;

  const ChatMessage({
    required this.role,
    required this.content,
    this.createdAt,
    this.hidden = false,
    this.status = MessageStatus.done,
  });

  static ChatMessage from({
    required MessageRole role,
    required String content,
    MessageStatus status = MessageStatus.done,
    DateTime? createAt,
    bool hidden = false,
  }) {
    if (role == MessageRole.assistant) {
      return AssistantMessage(
        content: content,
        createdAt: createAt,
        hidden: hidden,
        status: status,
      );
    } else {
      return UserMessage(
        content: content,
        createdAt: createAt,
        hidden: hidden,
        status: status,
      );
    }
  }
}

extension ChatMessageExt on ChatMessage {
  bool get isUser => role == MessageRole.user;
  bool get isAssistant => role == MessageRole.assistant;
}
