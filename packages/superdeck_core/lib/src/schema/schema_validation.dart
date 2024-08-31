part of 'schema.dart';

class SchemaValidationException implements Exception {
  final ValidationResult result;

  const SchemaValidationException(this.result);

  @override
  String toString() {
    return 'SchemaValidationException: ${result.errors.map((e) => e.message).join('\n')}';
  }
}

enum SchemaErrorType {
  unallowedAdditionalProperty,
  enumViolated,
  requiredPropMissing,
  invalidType,
  constraints,
  unknown;
}

sealed class ValidationError {
  String get message;

  const ValidationError();
}

class UnalowedAdditionalPropertyValidationError extends ValidationError {
  final String property;

  const UnalowedAdditionalPropertyValidationError({
    required this.property,
  });

  @override
  String get message => 'Unallowed property: [$property]';
}

class EnumViolatedValidationError extends ValidationError {
  final String value;
  final List<String> possibleValues;

  const EnumViolatedValidationError({
    required this.value,
    required this.possibleValues,
  });

  @override
  String get message =>
      'Wrong value: [$value] \n\n Possible values: $possibleValues';
}

class RequiredPropMissingValidationError extends ValidationError {
  final String property;

  const RequiredPropMissingValidationError({
    required this.property,
  });

  @override
  String get message => 'Missing prop: [$property]';
}

class InvalidTypeValidationError extends ValidationError {
  final Type value;
  final Type expectedType;

  const InvalidTypeValidationError({
    required this.value,
    required this.expectedType,
  });

  @override
  String get message => 'Invalid type: expected [$expectedType] got [$value]';
}

class ConstraintsValidationError extends ValidationError {
  final String _message;
  const ConstraintsValidationError(this._message);

  @override
  String get message => 'Constraints: $_message';
}

class UnknownValidationError extends ValidationError {
  const UnknownValidationError();

  @override
  String get message => 'Unknown Validation error';
}

class ValidationResult {
  final List<String> path;
  final List<ValidationError> errors;

  const ValidationResult({
    required this.path,
    required this.errors,
  });

  bool get isValid => errors.isEmpty;

  const ValidationResult.valid(this.path) : errors = const [];
}
