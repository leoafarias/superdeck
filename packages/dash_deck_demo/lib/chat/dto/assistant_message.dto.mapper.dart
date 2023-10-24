// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'assistant_message.dto.dart';

class AssistantMessageMapper extends SubClassMapperBase<AssistantMessage> {
  AssistantMessageMapper._();

  static AssistantMessageMapper? _instance;
  static AssistantMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssistantMessageMapper._());
      ChatMessageMapper.ensureInitialized().addSubMapper(_instance!);
      PromptMessageMapper.ensureInitialized();
      MessageStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssistantMessage';

  static String _$content(AssistantMessage v) => v.content;
  static const Field<AssistantMessage, String> _f$content =
      Field('content', _$content);
  static MessageStatus _$status(AssistantMessage v) => v.status;
  static const Field<AssistantMessage, MessageStatus> _f$status =
      Field('status', _$status, opt: true, def: MessageStatus.done);
  static DateTime? _$createdAt(AssistantMessage v) => v.createdAt;
  static const Field<AssistantMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static bool _$hidden(AssistantMessage v) => v.hidden;
  static const Field<AssistantMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);
  static MessageRole _$role(AssistantMessage v) => v.role;
  static const Field<AssistantMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<AssistantMessage, dynamic>> fields = const {
    #content: _f$content,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #hidden: _f$hidden,
    #role: _f$role,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'AssistantMessage';
  @override
  late final ClassMapperBase superMapper =
      ChatMessageMapper.ensureInitialized();

  static AssistantMessage _instantiate(DecodingData data) {
    return AssistantMessage(
        content: data.dec(_f$content),
        status: data.dec(_f$status),
        createdAt: data.dec(_f$createdAt),
        hidden: data.dec(_f$hidden));
  }

  @override
  final Function instantiate = _instantiate;

  static AssistantMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssistantMessage>(map);
  }

  static AssistantMessage fromJson(String json) {
    return ensureInitialized().decodeJson<AssistantMessage>(json);
  }
}

mixin AssistantMessageMappable {
  String toJson() {
    return AssistantMessageMapper.ensureInitialized()
        .encodeJson<AssistantMessage>(this as AssistantMessage);
  }

  Map<String, dynamic> toMap() {
    return AssistantMessageMapper.ensureInitialized()
        .encodeMap<AssistantMessage>(this as AssistantMessage);
  }

  AssistantMessageCopyWith<AssistantMessage, AssistantMessage, AssistantMessage>
      get copyWith => _AssistantMessageCopyWithImpl(
          this as AssistantMessage, $identity, $identity);
  @override
  String toString() {
    return AssistantMessageMapper.ensureInitialized()
        .stringifyValue(this as AssistantMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            AssistantMessageMapper.ensureInitialized()
                .isValueEqual(this as AssistantMessage, other));
  }

  @override
  int get hashCode {
    return AssistantMessageMapper.ensureInitialized()
        .hashValue(this as AssistantMessage);
  }
}

extension AssistantMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssistantMessage, $Out> {
  AssistantMessageCopyWith<$R, AssistantMessage, $Out>
      get $asAssistantMessage =>
          $base.as((v, t, t2) => _AssistantMessageCopyWithImpl(v, t, t2));
}

abstract class AssistantMessageCopyWith<$R, $In extends AssistantMessage, $Out>
    implements ChatMessageCopyWith<$R, $In, $Out> {
  @override
  $R call();
  AssistantMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AssistantMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssistantMessage, $Out>
    implements AssistantMessageCopyWith<$R, AssistantMessage, $Out> {
  _AssistantMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssistantMessage> $mapper =
      AssistantMessageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AssistantMessage $make(CopyWithData data) => AssistantMessage(
      content: data.get(#content, or: $value.content),
      status: data.get(#status, or: $value.status),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      hidden: data.get(#hidden, or: $value.hidden));

  @override
  AssistantMessageCopyWith<$R2, AssistantMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssistantMessageCopyWithImpl($value, $cast, t);
}

class PromptMessageMapper extends SubClassMapperBase<PromptMessage> {
  PromptMessageMapper._();

  static PromptMessageMapper? _instance;
  static PromptMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PromptMessageMapper._());
      AssistantMessageMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'PromptMessage';

  static MessageRole _$role(PromptMessage v) => v.role;
  static const Field<PromptMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);
  static bool _$hidden(PromptMessage v) => v.hidden;
  static const Field<PromptMessage, bool> _f$hidden =
      Field('hidden', _$hidden, mode: FieldMode.member);
  static String _$content(PromptMessage v) => v.content;
  static const Field<PromptMessage, String> _f$content =
      Field('content', _$content, mode: FieldMode.member);
  static DateTime? _$createdAt(PromptMessage v) => v.createdAt;
  static const Field<PromptMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, mode: FieldMode.member);
  static MessageStatus _$status(PromptMessage v) => v.status;
  static const Field<PromptMessage, MessageStatus> _f$status =
      Field('status', _$status, mode: FieldMode.member);
  static String _$response(PromptMessage v) => v.response;
  static const Field<PromptMessage, String> _f$response =
      Field('response', _$response, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<PromptMessage, dynamic>> fields = const {
    #role: _f$role,
    #hidden: _f$hidden,
    #content: _f$content,
    #createdAt: _f$createdAt,
    #status: _f$status,
    #response: _f$response,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'PromptMessage';
  @override
  late final ClassMapperBase superMapper =
      AssistantMessageMapper.ensureInitialized();

  static PromptMessage _instantiate(DecodingData data) {
    return PromptMessage();
  }

  @override
  final Function instantiate = _instantiate;

  static PromptMessage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PromptMessage>(map);
  }

  static PromptMessage fromJson(String json) {
    return ensureInitialized().decodeJson<PromptMessage>(json);
  }
}

mixin PromptMessageMappable {
  String toJson() {
    return PromptMessageMapper.ensureInitialized()
        .encodeJson<PromptMessage>(this as PromptMessage);
  }

  Map<String, dynamic> toMap() {
    return PromptMessageMapper.ensureInitialized()
        .encodeMap<PromptMessage>(this as PromptMessage);
  }

  PromptMessageCopyWith<PromptMessage, PromptMessage, PromptMessage>
      get copyWith => _PromptMessageCopyWithImpl(
          this as PromptMessage, $identity, $identity);
  @override
  String toString() {
    return PromptMessageMapper.ensureInitialized()
        .stringifyValue(this as PromptMessage);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            PromptMessageMapper.ensureInitialized()
                .isValueEqual(this as PromptMessage, other));
  }

  @override
  int get hashCode {
    return PromptMessageMapper.ensureInitialized()
        .hashValue(this as PromptMessage);
  }
}

extension PromptMessageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PromptMessage, $Out> {
  PromptMessageCopyWith<$R, PromptMessage, $Out> get $asPromptMessage =>
      $base.as((v, t, t2) => _PromptMessageCopyWithImpl(v, t, t2));
}

abstract class PromptMessageCopyWith<$R, $In extends PromptMessage, $Out>
    implements AssistantMessageCopyWith<$R, $In, $Out> {
  @override
  $R call();
  PromptMessageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PromptMessageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PromptMessage, $Out>
    implements PromptMessageCopyWith<$R, PromptMessage, $Out> {
  _PromptMessageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PromptMessage> $mapper =
      PromptMessageMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  PromptMessage $make(CopyWithData data) => PromptMessage();

  @override
  PromptMessageCopyWith<$R2, PromptMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PromptMessageCopyWithImpl($value, $cast, t);
}
