// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_message.dto.dart';

class UserMessageMapper extends SubClassMapperBase<UserMessage> {
  UserMessageMapper._();

  static UserMessageMapper? _instance;
  static UserMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserMessageMapper._());
      ChatMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'UserMessage';

  static String _$content(UserMessage v) => v.content;
  static const Field<UserMessage, String> _f$content =
      Field('content', _$content);
  static DateTime? _$createdAt(UserMessage v) => v.createdAt;
  static const Field<UserMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static bool _$hidden(UserMessage v) => v.hidden;
  static const Field<UserMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);
  static MessageRole _$role(UserMessage v) => v.role;
  static const Field<UserMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<UserMessage, dynamic>> fields = const {
    #content: _f$content,
    #createdAt: _f$createdAt,
    #hidden: _f$hidden,
    #role: _f$role,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'UserMessage';
  @override
  late final ClassMapperBase superMapper =
      ChatMessageMapper.ensureInitialized();

  static UserMessage _instantiate(DecodingData data) {
    return UserMessage(
        content: data.dec(_f$content),
        createdAt: data.dec(_f$createdAt),
        hidden: data.dec(_f$hidden));
  }

  @override
  final Function instantiate = _instantiate;

  static UserMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserMessage>(map);
  }

  static UserMessage fromJson(String json) {
    return ensureInitialized().decodeJson<UserMessage>(json);
  }
}

mixin UserMessageMappable {
  String toJson() {
    return UserMessageMapper.ensureInitialized()
        .encodeJson<UserMessage>(this as UserMessage);
  }

  Map<String, dynamic> toMap() {
    return UserMessageMapper.ensureInitialized()
        .encodeMap<UserMessage>(this as UserMessage);
  }

  UserMessageCopyWith<UserMessage, UserMessage, UserMessage> get copyWith =>
      _UserMessageCopyWithImpl(this as UserMessage, $identity, $identity);
  @override
  String toString() {
    return UserMessageMapper.ensureInitialized()
        .stringifyValue(this as UserMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UserMessageMapper.ensureInitialized()
                .isValueEqual(this as UserMessage, other));
  }

  @override
  int get hashCode {
    return UserMessageMapper.ensureInitialized().hashValue(this as UserMessage);
  }
}

extension UserMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserMessage, $Out> {
  UserMessageCopyWith<$R, UserMessage, $Out> get $asUserMessage =>
      $base.as((v, t, t2) => _UserMessageCopyWithImpl(v, t, t2));
}

abstract class UserMessageCopyWith<$R, $In extends UserMessage, $Out>
    implements ChatMessageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content, DateTime? createdAt, bool? hidden});
  UserMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserMessage, $Out>
    implements UserMessageCopyWith<$R, UserMessage, $Out> {
  _UserMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserMessage> $mapper =
      UserMessageMapper.ensureInitialized();
  @override
  $R call({String? content, Object? createdAt = $none, bool? hidden}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (createdAt != $none) #createdAt: createdAt,
        if (hidden != null) #hidden: hidden
      }));
  @override
  UserMessage $make(CopyWithData data) => UserMessage(
      content: data.get(#content, or: $value.content),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  UserMessageCopyWith<$R2, UserMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserMessageCopyWithImpl($value, $cast, t);
}
