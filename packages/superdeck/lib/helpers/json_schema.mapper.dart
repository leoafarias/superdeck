// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'json_schema.dart';

class ErrorTypeMapper extends EnumMapper<ErrorType> {
  ErrorTypeMapper._();

  static ErrorTypeMapper? _instance;
  static ErrorTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorTypeMapper._());
    }
    return _instance!;
  }

  static ErrorType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ErrorType decode(dynamic value) {
    switch (value) {
      case 'unallowed_additional_property':
        return ErrorType.unallowedAdditionalProperty;
      case 'enum_violated':
        return ErrorType.enumViolated;
      case 'required_prop_missing':
        return ErrorType.requiredPropMissing;
      case 'invalid_type':
        return ErrorType.invalidType;
      case 'unknown':
        return ErrorType.unknown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ErrorType self) {
    switch (self) {
      case ErrorType.unallowedAdditionalProperty:
        return 'unallowed_additional_property';
      case ErrorType.enumViolated:
        return 'enum_violated';
      case ErrorType.requiredPropMissing:
        return 'required_prop_missing';
      case ErrorType.invalidType:
        return 'invalid_type';
      case ErrorType.unknown:
        return 'unknown';
    }
  }
}

extension ErrorTypeMapperExtension on ErrorType {
  String toValue() {
    ErrorTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ErrorType>(this) as String;
  }
}

class SchemaValidationErrorMapper
    extends ClassMapperBase<SchemaValidationError> {
  SchemaValidationErrorMapper._();

  static SchemaValidationErrorMapper? _instance;
  static SchemaValidationErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchemaValidationErrorMapper._());
      ErrorTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SchemaValidationError';

  static String _$location(SchemaValidationError v) => v.location;
  static const Field<SchemaValidationError, String> _f$location =
      Field('location', _$location);
  static String _$propertyName(SchemaValidationError v) => v.propertyName;
  static const Field<SchemaValidationError, String> _f$propertyName =
      Field('propertyName', _$propertyName, key: 'property_name');
  static String? _$value(SchemaValidationError v) => v.value;
  static const Field<SchemaValidationError, String> _f$value =
      Field('value', _$value, opt: true);
  static ErrorType _$errorType(SchemaValidationError v) => v.errorType;
  static const Field<SchemaValidationError, ErrorType> _f$errorType =
      Field('errorType', _$errorType, key: 'error_type');

  @override
  final MappableFields<SchemaValidationError> fields = const {
    #location: _f$location,
    #propertyName: _f$propertyName,
    #value: _f$value,
    #errorType: _f$errorType,
  };
  @override
  final bool ignoreNull = true;

  static SchemaValidationError _instantiate(DecodingData data) {
    return SchemaValidationError(
        location: data.dec(_f$location),
        propertyName: data.dec(_f$propertyName),
        value: data.dec(_f$value),
        errorType: data.dec(_f$errorType));
  }

  @override
  final Function instantiate = _instantiate;

  static SchemaValidationError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SchemaValidationError>(map);
  }

  static SchemaValidationError fromJson(String json) {
    return ensureInitialized().decodeJson<SchemaValidationError>(json);
  }
}

mixin SchemaValidationErrorMappable {
  String toJson() {
    return SchemaValidationErrorMapper.ensureInitialized()
        .encodeJson<SchemaValidationError>(this as SchemaValidationError);
  }

  Map<String, dynamic> toMap() {
    return SchemaValidationErrorMapper.ensureInitialized()
        .encodeMap<SchemaValidationError>(this as SchemaValidationError);
  }

  SchemaValidationErrorCopyWith<SchemaValidationError, SchemaValidationError,
          SchemaValidationError>
      get copyWith => _SchemaValidationErrorCopyWithImpl(
          this as SchemaValidationError, $identity, $identity);
  @override
  String toString() {
    return SchemaValidationErrorMapper.ensureInitialized()
        .stringifyValue(this as SchemaValidationError);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SchemaValidationErrorMapper.ensureInitialized()
                .isValueEqual(this as SchemaValidationError, other));
  }

  @override
  int get hashCode {
    return SchemaValidationErrorMapper.ensureInitialized()
        .hashValue(this as SchemaValidationError);
  }
}

extension SchemaValidationErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SchemaValidationError, $Out> {
  SchemaValidationErrorCopyWith<$R, SchemaValidationError, $Out>
      get $asSchemaValidationError =>
          $base.as((v, t, t2) => _SchemaValidationErrorCopyWithImpl(v, t, t2));
}

abstract class SchemaValidationErrorCopyWith<
    $R,
    $In extends SchemaValidationError,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? location,
      String? propertyName,
      String? value,
      ErrorType? errorType});
  SchemaValidationErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SchemaValidationErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SchemaValidationError, $Out>
    implements SchemaValidationErrorCopyWith<$R, SchemaValidationError, $Out> {
  _SchemaValidationErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SchemaValidationError> $mapper =
      SchemaValidationErrorMapper.ensureInitialized();
  @override
  $R call(
          {String? location,
          String? propertyName,
          Object? value = $none,
          ErrorType? errorType}) =>
      $apply(FieldCopyWithData({
        if (location != null) #location: location,
        if (propertyName != null) #propertyName: propertyName,
        if (value != $none) #value: value,
        if (errorType != null) #errorType: errorType
      }));
  @override
  SchemaValidationError $make(CopyWithData data) => SchemaValidationError(
      location: data.get(#location, or: $value.location),
      propertyName: data.get(#propertyName, or: $value.propertyName),
      value: data.get(#value, or: $value.value),
      errorType: data.get(#errorType, or: $value.errorType));

  @override
  SchemaValidationErrorCopyWith<$R2, SchemaValidationError, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SchemaValidationErrorCopyWithImpl($value, $cast, t);
}

class SchemaValidationResultMapper
    extends ClassMapperBase<SchemaValidationResult> {
  SchemaValidationResultMapper._();

  static SchemaValidationResultMapper? _instance;
  static SchemaValidationResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchemaValidationResultMapper._());
      SchemaValidationErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SchemaValidationResult';

  static List<SchemaValidationError> _$errors(SchemaValidationResult v) =>
      v.errors;
  static const Field<SchemaValidationResult, List<SchemaValidationError>>
      _f$errors = Field('errors', _$errors);

  @override
  final MappableFields<SchemaValidationResult> fields = const {
    #errors: _f$errors,
  };
  @override
  final bool ignoreNull = true;

  static SchemaValidationResult _instantiate(DecodingData data) {
    return SchemaValidationResult(errors: data.dec(_f$errors));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SchemaValidationResultMapper.ensureInitialized()
                .isValueEqual(this as SchemaValidationResult, other));
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
  ListCopyWith<
      $R,
      SchemaValidationError,
      SchemaValidationErrorCopyWith<$R, SchemaValidationError,
          SchemaValidationError>> get errors;
  $R call({List<SchemaValidationError>? errors});
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
  ListCopyWith<
      $R,
      SchemaValidationError,
      SchemaValidationErrorCopyWith<$R, SchemaValidationError,
          SchemaValidationError>> get errors => ListCopyWith(
      $value.errors, (v, t) => v.copyWith.$chain(t), (v) => call(errors: v));
  @override
  $R call({List<SchemaValidationError>? errors}) =>
      $apply(FieldCopyWithData({if (errors != null) #errors: errors}));
  @override
  SchemaValidationResult $make(CopyWithData data) =>
      SchemaValidationResult(errors: data.get(#errors, or: $value.errors));

  @override
  SchemaValidationResultCopyWith<$R2, SchemaValidationResult, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SchemaValidationResultCopyWithImpl($value, $cast, t);
}
