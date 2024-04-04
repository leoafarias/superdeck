import 'package:dart_mappable/dart_mappable.dart';

part 'schema_error_model.mapper.dart';

@MappableEnum()
enum ErrorType {
  unallowedAdditionalProperty('Unallowed additional property'),
  enumViolated('Not a valid value'),
  requiredPropMissing('Required property missing'),
  invalidType('Invalid type'),
  unknown('Unknown error');

  const ErrorType(this.message);

  final String message;
}

@MappableClass()
class SchemaError with SchemaErrorMappable {
  final String location;
  final String propertyName;
  final String? value;
  final ErrorType errorType;

  SchemaError({
    required this.location,
    required this.propertyName,
    this.value,
    required this.errorType,
  });

  static const fromMap = SchemaErrorMapper.fromMap;
  static const fromJson = SchemaErrorMapper.fromJson;
}
