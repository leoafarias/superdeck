// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'chat_message.dto.dart';

class ChatMessageMapper extends ClassMapperBase<ChatMessage> {
  ChatMessageMapper._();

  static ChatMessageMapper? _instance;
  static ChatMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatMessageMapper._());
      MapperContainer.globals.useAll([MessageRoleMapper()]);
      UserMessageMapper.ensureInitialized();
      AssistantMessageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatMessage';

  static MessageRole _$role(ChatMessage v) => v.role;
  static const Field<ChatMessage, MessageRole> _f$role = Field('role', _$role);
  static String _$content(ChatMessage v) => v.content;
  static const Field<ChatMessage, String> _f$content =
      Field('content', _$content);
  static DateTime? _$createdAt(ChatMessage v) => v.createdAt;
  static const Field<ChatMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static bool _$hidden(ChatMessage v) => v.hidden;
  static const Field<ChatMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);

  @override
  final Map<Symbol, Field<ChatMessage, dynamic>> fields = const {
    #role: _f$role,
    #content: _f$content,
    #createdAt: _f$createdAt,
    #hidden: _f$hidden,
  };

  static ChatMessage _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'ChatMessage', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatMessage>(map);
  }

  static ChatMessage fromJson(String json) {
    return ensureInitialized().decodeJson<ChatMessage>(json);
  }
}

mixin ChatMessageMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ChatMessageCopyWith<ChatMessage, ChatMessage, ChatMessage> get copyWith;
}

abstract class ChatMessageCopyWith<$R, $In extends ChatMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content, DateTime? createdAt, bool? hidden});
  ChatMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}
