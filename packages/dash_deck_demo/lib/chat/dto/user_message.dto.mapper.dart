// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_message.dto.dart';

class UserChatMessageMapper extends SubClassMapperBase<UserChatMessage> {
  UserChatMessageMapper._();

  static UserChatMessageMapper? _instance;
  static UserChatMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserChatMessageMapper._());
      ChatMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'UserChatMessage';

  static String _$content(UserChatMessage v) => v.content;
  static const Field<UserChatMessage, String> _f$content =
      Field('content', _$content);
  static DateTime _$createdAt(UserChatMessage v) => v.createdAt;
  static const Field<UserChatMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static bool _$hidden(UserChatMessage v) => v.hidden;
  static const Field<UserChatMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);
  static MessageRole _$role(UserChatMessage v) => v.role;
  static const Field<UserChatMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<UserChatMessage, dynamic>> fields = const {
    #content: _f$content,
    #createdAt: _f$createdAt,
    #hidden: _f$hidden,
    #role: _f$role,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'UserChatMessage';
  @override
  late final ClassMapperBase superMapper =
      ChatMessageMapper.ensureInitialized();

  static UserChatMessage _instantiate(DecodingData data) {
    return UserChatMessage(
        content: data.dec(_f$content),
        createdAt: data.dec(_f$createdAt),
        hidden: data.dec(_f$hidden));
  }

  @override
  final Function instantiate = _instantiate;

  static UserChatMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserChatMessage>(map);
  }

  static UserChatMessage fromJson(String json) {
    return ensureInitialized().decodeJson<UserChatMessage>(json);
  }
}

mixin UserChatMessageMappable {
  String toJson() {
    return UserChatMessageMapper.ensureInitialized()
        .encodeJson<UserChatMessage>(this as UserChatMessage);
  }

  Map<String, dynamic> toMap() {
    return UserChatMessageMapper.ensureInitialized()
        .encodeMap<UserChatMessage>(this as UserChatMessage);
  }

  UserChatMessageCopyWith<UserChatMessage, UserChatMessage, UserChatMessage>
      get copyWith => _UserChatMessageCopyWithImpl(
          this as UserChatMessage, $identity, $identity);
  @override
  String toString() {
    return UserChatMessageMapper.ensureInitialized()
        .stringifyValue(this as UserChatMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            UserChatMessageMapper.ensureInitialized()
                .isValueEqual(this as UserChatMessage, other));
  }

  @override
  int get hashCode {
    return UserChatMessageMapper.ensureInitialized()
        .hashValue(this as UserChatMessage);
  }
}

extension UserChatMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserChatMessage, $Out> {
  UserChatMessageCopyWith<$R, UserChatMessage, $Out> get $asUserChatMessage =>
      $base.as((v, t, t2) => _UserChatMessageCopyWithImpl(v, t, t2));
}

abstract class UserChatMessageCopyWith<$R, $In extends UserChatMessage, $Out>
    implements ChatMessageCopyWith<$R, $In, $Out> {
  @override
  $R call({String? content, DateTime? createdAt, bool? hidden});
  UserChatMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _UserChatMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserChatMessage, $Out>
    implements UserChatMessageCopyWith<$R, UserChatMessage, $Out> {
  _UserChatMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserChatMessage> $mapper =
      UserChatMessageMapper.ensureInitialized();
  @override
  $R call({String? content, DateTime? createdAt, bool? hidden}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (createdAt != null) #createdAt: createdAt,
        if (hidden != null) #hidden: hidden
      }));
  @override
  UserChatMessage $make(CopyWithData data) => UserChatMessage(
      content: data.get(#content, or: $value.content),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  UserChatMessageCopyWith<$R2, UserChatMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserChatMessageCopyWithImpl($value, $cast, t);
}
