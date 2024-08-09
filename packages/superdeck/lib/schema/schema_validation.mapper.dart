// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'schema_validation.dart';

class SchemaErrorMapper extends ClassMapperBase<SchemaError> {
  SchemaErrorMapper._();

  static SchemaErrorMapper? _instance;
  static SchemaErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchemaErrorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SchemaError';

  static SchemaErrorType _$type(SchemaError v) => v.type;
  static const Field<SchemaError, SchemaErrorType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$message(SchemaError v) => v.message;
  static const Field<SchemaError, String> _f$message =
      Field('message', _$message, mode: FieldMode.member);

  @override
  final MappableFields<SchemaError> fields = const {
    #type: _f$type,
    #message: _f$message,
  };
  @override
  final bool ignoreNull = true;

  static SchemaError _instantiate(DecodingData data) {
    return SchemaError.unknown();
  }

  @override
  final Function instantiate = _instantiate;

  static SchemaError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SchemaError>(map);
  }

  static SchemaError fromJson(String json) {
    return ensureInitialized().decodeJson<SchemaError>(json);
  }
}

mixin SchemaErrorMappable {
  String toJson() {
    return SchemaErrorMapper.ensureInitialized()
        .encodeJson<SchemaError>(this as SchemaError);
  }

  Map<String, dynamic> toMap() {
    return SchemaErrorMapper.ensureInitialized()
        .encodeMap<SchemaError>(this as SchemaError);
  }

  SchemaErrorCopyWith<SchemaError, SchemaError, SchemaError> get copyWith =>
      _SchemaErrorCopyWithImpl(this as SchemaError, $identity, $identity);
  @override
  String toString() {
    return SchemaErrorMapper.ensureInitialized()
        .stringifyValue(this as SchemaError);
  }

  @override
  bool operator ==(Object other) {
    return SchemaErrorMapper.ensureInitialized()
        .equalsValue(this as SchemaError, other);
  }

  @override
  int get hashCode {
    return SchemaErrorMapper.ensureInitialized().hashValue(this as SchemaError);
  }
}

extension SchemaErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SchemaError, $Out> {
  SchemaErrorCopyWith<$R, SchemaError, $Out> get $asSchemaError =>
      $base.as((v, t, t2) => _SchemaErrorCopyWithImpl(v, t, t2));
}

abstract class SchemaErrorCopyWith<$R, $In extends SchemaError, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  SchemaErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SchemaErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SchemaError, $Out>
    implements SchemaErrorCopyWith<$R, SchemaError, $Out> {
  _SchemaErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SchemaError> $mapper =
      SchemaErrorMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  SchemaError $make(CopyWithData data) => SchemaError.unknown();

  @override
  SchemaErrorCopyWith<$R2, SchemaError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SchemaErrorCopyWithImpl($value, $cast, t);
}

class SchemaValidationResultMapper
    extends ClassMapperBase<SchemaValidationResult> {
  SchemaValidationResultMapper._();

  static SchemaValidationResultMapper? _instance;
  static SchemaValidationResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchemaValidationResultMapper._());
      SchemaErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SchemaValidationResult';

  static List<String> _$key(SchemaValidationResult v) => v.key;
  static const Field<SchemaValidationResult, List<String>> _f$key =
      Field('key', _$key);
  static List<SchemaError> _$errors(SchemaValidationResult v) => v.errors;
  static const Field<SchemaValidationResult, List<SchemaError>> _f$errors =
      Field('errors', _$errors);

  @override
  final MappableFields<SchemaValidationResult> fields = const {
    #key: _f$key,
    #errors: _f$errors,
  };
  @override
  final bool ignoreNull = true;

  static SchemaValidationResult _instantiate(DecodingData data) {
    return SchemaValidationResult(
        key: data.dec(_f$key), errors: data.dec(_f$errors));
  }

  @override
  final Function instantiate = _instantiate;

  static SchemaValidationResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SchemaValidationResult>(map);
  }

  static SchemaValidationResult fromJson(String json) {
    return ensureInitialized().decodeJson<SchemaValidationResult>(json);
  }
}

mixin SchemaValidationResultMappable {
  String toJson() {
    return SchemaValidationResultMapper.ensureInitialized()
        .encodeJson<SchemaValidationResult>(this as SchemaValidationResult);
  }

  Map<String, dynamic> toMap() {
    return SchemaValidationResultMapper.ensureInitialized()
        .encodeMap<SchemaValidationResult>(this as SchemaValidationResult);
  }

  SchemaValidationResultCopyWith<SchemaValidationResult, SchemaValidationResult,
          SchemaValidationResult>
      get copyWith => _SchemaValidationResultCopyWithImpl(
          this as SchemaValidationResult, $identity, $identity);
  @override
  String toString() {
    return SchemaValidationResultMapper.ensureInitialized()
        .stringifyValue(this as SchemaValidationResult);
  }

  @override
  bool operator ==(Object other) {
    return SchemaValidationResultMapper.ensureInitialized()
        .equalsValue(this as SchemaValidationResult, other);
  }

  @override
  int get hashCode {
    return SchemaValidationResultMapper.ensureInitialized()
        .hashValue(this as SchemaValidationResult);
  }
}

extension SchemaValidationResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SchemaValidationResult, $Out> {
  SchemaValidationResultCopyWith<$R, SchemaValidationResult, $Out>
      get $asSchemaValidationResult =>
          $base.as((v, t, t2) => _SchemaValidationResultCopyWithImpl(v, t, t2));
}

abstract class SchemaValidationResultCopyWith<
    $R,
    $In extends SchemaValidationResult,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get key;
  ListCopyWith<$R, SchemaError,
      SchemaErrorCopyWith<$R, SchemaError, SchemaError>> get errors;
  $R call({List<String>? key, List<SchemaError>? errors});
  SchemaValidationResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SchemaValidationResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SchemaValidationResult, $Out>
    implements
        SchemaValidationResultCopyWith<$R, SchemaValidationResult, $Out> {
  _SchemaValidationResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SchemaValidationResult> $mapper =
      SchemaValidationResultMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get key =>
      ListCopyWith($value.key, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(key: v));
  @override
  ListCopyWith<$R, SchemaError,
          SchemaErrorCopyWith<$R, SchemaError, SchemaError>>
      get errors => ListCopyWith($value.errors, (v, t) => v.copyWith.$chain(t),
          (v) => call(errors: v));
  @override
  $R call({List<String>? key, List<SchemaError>? errors}) =>
      $apply(FieldCopyWithData(
          {if (key != null) #key: key, if (errors != null) #errors: errors}));
  @override
  SchemaValidationResult $make(CopyWithData data) => SchemaValidationResult(
      key: data.get(#key, or: $value.key),
      errors: data.get(#errors, or: $value.errors));

  @override
  SchemaValidationResultCopyWith<$R2, SchemaValidationResult, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SchemaValidationResultCopyWithImpl($value, $cast, t);
}
