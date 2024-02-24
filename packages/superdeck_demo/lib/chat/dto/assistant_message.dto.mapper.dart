// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'assistant_message.dto.dart';

class ResponseStatusMapper extends EnumMapper<ResponseStatus> {
  ResponseStatusMapper._();

  static ResponseStatusMapper? _instance;
  static ResponseStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ResponseStatusMapper._());
    }
    return _instance!;
  }

  static ResponseStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ResponseStatus decode(dynamic value) {
    switch (value) {
      case 'none':
        return ResponseStatus.none;
      case 'waitingResponse':
        return ResponseStatus.waitingResponse;
      case 'done':
        return ResponseStatus.done;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ResponseStatus self) {
    switch (self) {
      case ResponseStatus.none:
        return 'none';
      case ResponseStatus.waitingResponse:
        return 'waitingResponse';
      case ResponseStatus.done:
        return 'done';
    }
  }
}

extension ResponseStatusMapperExtension on ResponseStatus {
  String toValue() {
    ResponseStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ResponseStatus>(this) as String;
  }
}

class AssistantMessageMapper extends SubClassMapperBase<AssistantMessage> {
  AssistantMessageMapper._();

  static AssistantMessageMapper? _instance;
  static AssistantMessageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssistantMessageMapper._());
      ChatMessageMapper.ensureInitialized().addSubMapper(_instance!);
      ResponseStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssistantMessage';

  static String _$content(AssistantMessage v) => v.content;
  static const Field<AssistantMessage, String> _f$content =
      Field('content', _$content);
  static DateTime? _$createdAt(AssistantMessage v) => v.createdAt;
  static const Field<AssistantMessage, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt, opt: true);
  static bool _$hidden(AssistantMessage v) => v.hidden;
  static const Field<AssistantMessage, bool> _f$hidden =
      Field('hidden', _$hidden, opt: true, def: false);
  static String? _$response(AssistantMessage v) => v.response;
  static const Field<AssistantMessage, String> _f$response =
      Field('response', _$response, opt: true);
  static ResponseStatus _$_status(AssistantMessage v) => v._status;
  static const Field<AssistantMessage, ResponseStatus> _f$_status =
      Field('_status', _$_status, key: 'status', opt: true);
  static MessageRole _$role(AssistantMessage v) => v.role;
  static const Field<AssistantMessage, MessageRole> _f$role =
      Field('role', _$role, mode: FieldMode.member);

  @override
  final Map<Symbol, Field<AssistantMessage, dynamic>> fields = const {
    #content: _f$content,
    #createdAt: _f$createdAt,
    #hidden: _f$hidden,
    #response: _f$response,
    #_status: _f$_status,
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
        createdAt: data.dec(_f$createdAt),
        hidden: data.dec(_f$hidden),
        response: data.dec(_f$response),
        status: data.dec(_f$_status));
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
  $R call(
      {String? content,
      DateTime? createdAt,
      bool? hidden,
      String? response,
      ResponseStatus? status});
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
  $R call(
          {String? content,
          Object? createdAt = $none,
          bool? hidden,
          Object? response = $none,
          Object? status = $none}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (createdAt != $none) #createdAt: createdAt,
        if (hidden != null) #hidden: hidden,
        if (response != $none) #response: response,
        if (status != $none) #status: status
      }));
  @override
  AssistantMessage $make(CopyWithData data) => AssistantMessage(
      content: data.get(#content, or: $value.content),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      hidden: data.get(#hidden, or: $value.hidden),
      response: data.get(#response, or: $value.response),
      status: data.get(#status, or: $value._status));

  @override
  AssistantMessageCopyWith<$R2, AssistantMessage, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssistantMessageCopyWithImpl($value, $cast, t);
}
