import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_demo/chat/enum/chat_roles.enum.dart';

import 'chat_message.dto.dart';

part 'assistant_message.dto.mapper.dart';

@MappableEnum()
enum ResponseStatus {
  none,
  waitingResponse,
  done,
}

@MappableClass()
class AssistantMessage extends ChatMessage with AssistantMessageMappable {
  final ResponseStatus _status;
  final String? response;
  const AssistantMessage({
    required super.content,
    super.createdAt,
    super.hidden,
    this.response,
    ResponseStatus? status,
  })  : _status = status ?? ResponseStatus.none,
        super(role: MessageRole.assistant);

  ResponseStatus get status => _status;

  // Returns a new instance of ChatMessage that
  AssistantMessage copyWithDelta({
    String? deltaContent,
    DateTime? createdAt,
    bool? hidden,
    ResponseStatus? status,
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
