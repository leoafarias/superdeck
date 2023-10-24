// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'assistant_message.dto.dart';

class AssistantChatMessageMapper
    extends SubClassMapperBase<AssistantChatMessage> {
  AssistantChatMessageMapper._();

  static AssistantChatMessageMapper? _instance;
  static AssistantChatMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssistantChatMessageMapper._());
      ChatMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'AssistantChatMessage';

  static String _$content(AssistantChatMessage v) => v.content;
  static const Field<AssistantChatMessage, String> _f$content =
      Field('content', _$content);
  static DateTime _$createdAt(AssistantChatMessage v) => v.createdAt;
  static const Field<AssistantChatMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static AssistantMessageStatus _$status(AssistantChatMessage v) => v.status;
  static const Field<AssistantChatMessage, AssistantMessageStatus> _f$status =
      Field('status', _$status, opt: true, def: AssistantMessageStatus.done);
  static bool _$hidden(AssistantChatMessage v) => v.hidden;
  static const Field<AssistantChatMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);
  static MessageRole _$role(AssistantChatMessage v) => v.role;
  static const Field<AssistantChatMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<AssistantChatMessage, dynamic>> fields = const {
    #content: _f$content,
    #createdAt: _f$createdAt,
    #status: _f$status,
    #hidden: _f$hidden,
    #role: _f$role,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AssistantChatMessage';
  @override
  late final ClassMapperBase superMapper =
      ChatMessageMapper.ensureInitialized();

  static AssistantChatMessage _instantiate(DecodingData data) {
    return AssistantChatMessage(
        content: data.dec(_f$content),
        createdAt: data.dec(_f$createdAt),
        status: data.dec(_f$status),
        hidden: data.dec(_f$hidden));
  }

  @override
  final Function instantiate = _instantiate;

  static AssistantChatMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssistantChatMessage>(map);
  }

  static AssistantChatMessage fromJson(String json) {
    return ensureInitialized().decodeJson<AssistantChatMessage>(json);
  }
}

mixin AssistantChatMessageMappable {
  String toJson() {
    return AssistantChatMessageMapper.ensureInitialized()
        .encodeJson<AssistantChatMessage>(this as AssistantChatMessage);
  }

  Map<String, dynamic> toMap() {
    return AssistantChatMessageMapper.ensureInitialized()
        .encodeMap<AssistantChatMessage>(this as AssistantChatMessage);
  }

  AssistantChatMessageCopyWith<AssistantChatMessage, AssistantChatMessage,
          AssistantChatMessage>
      get copyWith => _AssistantChatMessageCopyWithImpl(
          this as AssistantChatMessage, $identity, $identity);
  @override
  String toString() {
    return AssistantChatMessageMapper.ensureInitialized()
        .stringifyValue(this as AssistantChatMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AssistantChatMessageMapper.ensureInitialized()
                .isValueEqual(this as AssistantChatMessage, other));
  }

  @override
  int get hashCode {
    return AssistantChatMessageMapper.ensureInitialized()
        .hashValue(this as AssistantChatMessage);
  }
}

extension AssistantChatMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssistantChatMessage, $Out> {
  AssistantChatMessageCopyWith<$R, AssistantChatMessage, $Out>
      get $asAssistantChatMessage =>
          $base.as((v, t, t2) => _AssistantChatMessageCopyWithImpl(v, t, t2));
}

abstract class AssistantChatMessageCopyWith<
    $R,
    $In extends AssistantChatMessage,
    $Out> implements ChatMessageCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? content,
      DateTime? createdAt,
      AssistantMessageStatus? status,
      bool? hidden});
  AssistantChatMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AssistantChatMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssistantChatMessage, $Out>
    implements AssistantChatMessageCopyWith<$R, AssistantChatMessage, $Out> {
  _AssistantChatMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssistantChatMessage> $mapper =
      AssistantChatMessageMapper.ensureInitialized();
  @override
  $R call(
          {String? content,
          DateTime? createdAt,
          AssistantMessageStatus? status,
          Object? hidden = $none}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (createdAt != null) #createdAt: createdAt,
        if (status != null) #status: status,
        if (hidden != $none) #hidden: hidden
      }));
  @override
  AssistantChatMessage $make(CopyWithData data) => AssistantChatMessage(
      content: data.get(#content, or: $value.content),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      status: data.get(#status, or: $value.status),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  AssistantChatMessageCopyWith<$R2, AssistantChatMessage, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AssistantChatMessageCopyWithImpl($value, $cast, t);
}
