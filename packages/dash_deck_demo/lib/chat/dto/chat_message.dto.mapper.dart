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
      UserChatMessageMapper.ensureInitialized();
      AssistantChatMessageMapper.ensureInitialized();
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
  static DateTime _$createdAt(ChatMessage v) => v.createdAt;
  static const Field<ChatMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
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
    return ChatMessage(
        role: data.dec(_f$role),
        content: data.dec(_f$content),
        createdAt: data.dec(_f$createdAt),
        hidden: data.dec(_f$hidden));
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
  String toJson() {
    return ChatMessageMapper.ensureInitialized()
        .encodeJson<ChatMessage>(this as ChatMessage);
  }

  Map<String, dynamic> toMap() {
    return ChatMessageMapper.ensureInitialized()
        .encodeMap<ChatMessage>(this as ChatMessage);
  }

  ChatMessageCopyWith<ChatMessage, ChatMessage, ChatMessage> get copyWith =>
      _ChatMessageCopyWithImpl(this as ChatMessage, $identity, $identity);
  @override
  String toString() {
    return ChatMessageMapper.ensureInitialized()
        .stringifyValue(this as ChatMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ChatMessageMapper.ensureInitialized()
                .isValueEqual(this as ChatMessage, other));
  }

  @override
  int get hashCode {
    return ChatMessageMapper.ensureInitialized().hashValue(this as ChatMessage);
  }
}

extension ChatMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatMessage, $Out> {
  ChatMessageCopyWith<$R, ChatMessage, $Out> get $asChatMessage =>
      $base.as((v, t, t2) => _ChatMessageCopyWithImpl(v, t, t2));
}

abstract class ChatMessageCopyWith<$R, $In extends ChatMessage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content, DateTime? createdAt, bool? hidden});
  ChatMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChatMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatMessage, $Out>
    implements ChatMessageCopyWith<$R, ChatMessage, $Out> {
  _ChatMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatMessage> $mapper =
      ChatMessageMapper.ensureInitialized();
  @override
  $R call({String? content, DateTime? createdAt, bool? hidden}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (createdAt != null) #createdAt: createdAt,
        if (hidden != null) #hidden: hidden
      }));
  @override
  ChatMessage $make(CopyWithData data) => ChatMessage(
      role: data.get(#role, or: $value.role),
      content: data.get(#content, or: $value.content),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  ChatMessageCopyWith<$R2, ChatMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ChatMessageCopyWithImpl($value, $cast, t);
}
