import 'package:dart_mappable/dart_mappable.dart';

part 'schema_validation.mapper.dart';

typedef JSON = Map<String, dynamic>;

class SchemaValidationException implements Exception {
  final SchemaValidationResult result;

  const SchemaValidationException(this.result);
}

enum SchemaErrorType {
  unallowedAdditionalProperty,
  enumViolated,
  requiredPropMissing,
  invalidType,
  constraints,
  unknown;
}

@MappableClass()
class SchemaError with SchemaErrorMappable {
  final SchemaErrorType type;
  final String message;

  const SchemaError.unknown()
      : type = SchemaErrorType.unknown,
        message = 'Unknown error';

  const SchemaError.constraints(this.message)
      : type = SchemaErrorType.constraints;

  const SchemaError.unallowedAdditionalProperty(String property)
      : type = SchemaErrorType.unallowedAdditionalProperty,
        message = 'Unallowed property: [$property]';

  const SchemaError.enumViolated(String value, List<String> possibleValues)
      : type = SchemaErrorType.enumViolated,
        message = 'Wrong value: [$value] \n\n Possible values: $possibleValues';

  const SchemaError.requiredPropMissing(String property)
      : type = SchemaErrorType.requiredPropMissing,
        message = 'Missing prop: [$property]';

  const SchemaError.invalidType(Type value, String expectedType)
      : type = SchemaErrorType.invalidType,
        message = 'Invalid type: [$expectedType] got [$value]';

  @override
  String toString() {
    return 'SchemaValidationError{type: $type, message: $message}';
  }
}

@MappableClass()
class SchemaValidationResult with SchemaValidationResultMappable {
  final List<String> key;
  final List<SchemaError> errors;

  const SchemaValidationResult({
    required this.key,
    required this.errors,
  });

  const SchemaValidationResult.valid(this.key) : errors = const [];

  factory SchemaValidationResult.invalidType(
    List<String> path,
    Object value,
    String expectedType,
  ) {
    return SchemaValidationResult(
      key: path,
      errors: [
        SchemaError.invalidType(
          value.runtimeType,
          expectedType,
        )
      ],
    );
  }

  factory SchemaValidationResult.unallowedAdditionalProperty(
      List<String> path, String property) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaError.unallowedAdditionalProperty(property)],
    );
  }

  factory SchemaValidationResult.enumViolated(
      List<String> path, String value, List<String> possibleValues) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaError.enumViolated(value, possibleValues)],
    );
  }

  factory SchemaValidationResult.requiredPropMissing(List<String> path) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaError.requiredPropMissing(path.last)],
    );
  }

  factory SchemaValidationResult.constraints(
      List<String> path, String message) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaError.constraints(message)],
    );
  }

  @override
  String toString() {
    return '${errors.isEmpty ? 'VALID' : 'INVALID'}${errors.isEmpty ? ', Errors: $errors' : ''}';
  }

  bool get isValid => errors.isEmpty;

  static const fromMap = SchemaValidationResultMapper.fromMap;
  static const fromJson = SchemaValidationResultMapper.fromJson;
}
