// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'schema_error_model.dart';

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

class SchemaErrorMapper extends ClassMapperBase<SchemaError> {
  SchemaErrorMapper._();

  static SchemaErrorMapper? _instance;
  static SchemaErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SchemaErrorMapper._());
      ErrorTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SchemaError';

  static String _$location(SchemaError v) => v.location;
  static const Field<SchemaError, String> _f$location =
      Field('location', _$location);
  static String _$propertyName(SchemaError v) => v.propertyName;
  static const Field<SchemaError, String> _f$propertyName =
      Field('propertyName', _$propertyName, key: 'property_name');
  static String? _$value(SchemaError v) => v.value;
  static const Field<SchemaError, String> _f$value =
      Field('value', _$value, opt: true);
  static ErrorType _$errorType(SchemaError v) => v.errorType;
  static const Field<SchemaError, ErrorType> _f$errorType =
      Field('errorType', _$errorType, key: 'error_type');

  @override
  final MappableFields<SchemaError> fields = const {
    #location: _f$location,
    #propertyName: _f$propertyName,
    #value: _f$value,
    #errorType: _f$errorType,
  };

  static SchemaError _instantiate(DecodingData data) {
    return SchemaError(
        location: data.dec(_f$location),
        propertyName: data.dec(_f$propertyName),
        value: data.dec(_f$value),
        errorType: data.dec(_f$errorType));
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
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SchemaErrorMapper.ensureInitialized()
                .isValueEqual(this as SchemaError, other));
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
  $R call(
      {String? location,
      String? propertyName,
      String? value,
      ErrorType? errorType});
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
  SchemaError $make(CopyWithData data) => SchemaError(
      location: data.get(#location, or: $value.location),
      propertyName: data.get(#propertyName, or: $value.propertyName),
      value: data.get(#value, or: $value.value),
      errorType: data.get(#errorType, or: $value.errorType));

  @override
  SchemaErrorCopyWith<$R2, SchemaError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SchemaErrorCopyWithImpl($value, $cast, t);
}
