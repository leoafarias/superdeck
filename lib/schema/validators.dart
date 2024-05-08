import 'schema.dart';

abstract class Validator<T> {
  const Validator();

  SchemaValidationError? validate(T value);
}

class EmailValidator extends RegexValidator {
  const EmailValidator()
      : super(
          name: 'email',
          pattern: r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$',
          example: 'example@domain.com',
        );
}

class UrlValidator extends RegexValidator {
  const UrlValidator()
      : super(
          name: 'url',
          pattern:
              r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
          example: 'https://example.com',
        );
}

class PosixPathValidator extends RegexValidator {
  const PosixPathValidator()
      : super(
          name: 'posix path',
          example: '/path/to/file',
          pattern: r'^(/[^/ ]*)+/?$',
        );
}

class HexColorValidator extends RegexValidator {
  const HexColorValidator()
      : super(
          name: 'hex color',
          example: '#ff0000',
          pattern: r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$',
        );
}

class RegexValidator extends Validator<String> {
  final String name;
  final String pattern;
  final String example;
  const RegexValidator({
    required this.name,
    required this.pattern,
    required this.example,
  });

  @override
  SchemaValidationError? validate(String value) {
    if (!RegExp(pattern).hasMatch(value)) {
      return SchemaValidationError.constraints(
        'String does is not $name. Example: $example',
      );
    }

    return null;
  }
}

class IsEmptyValidator extends Validator<String> {
  const IsEmptyValidator();

  @override
  SchemaValidationError? validate(String value) {
    return value.isEmpty
        ? null
        : const SchemaValidationError.constraints('String is not empty');
  }
}

class MinLengthValidator extends Validator<String> {
  final int min;
  const MinLengthValidator(this.min);

  @override
  SchemaValidationError? validate(String value) {
    return value.length >= min
        ? null
        : SchemaValidationError.constraints(
            'String length is less than the minimum required length: $min',
          );
  }
}

class MaxLengthValidator extends Validator<String> {
  final int max;
  const MaxLengthValidator(this.max);

  @override
  SchemaValidationError? validate(String value) {
    return value.length <= max
        ? null
        : SchemaValidationError.constraints(
            'String length is greater than the maximum required length: $max',
          );
  }
}

class MinValueValidator extends Validator<num> {
  final num min;
  const MinValueValidator(this.min);

  @override
  SchemaValidationError? validate(num value) {
    return value >= min
        ? null
        : SchemaValidationError.constraints(
            'Value is less than the minimum required value: $min',
          );
  }
}

class MaxValueValidator extends Validator<num> {
  final num max;
  const MaxValueValidator(this.max);

  @override
  SchemaValidationError? validate(num value) {
    return value <= max
        ? null
        : SchemaValidationError.constraints(
            'Value is greater than the maximum required value: $max',
          );
  }
}

class RangeValidator extends Validator<num> {
  final num min;
  final num max;
  const RangeValidator(this.min, this.max);

  @override
  SchemaValidationError? validate(num value) {
    return value >= min && value <= max
        ? null
        : SchemaValidationError.constraints(
            'Value is not within the required range: $min - $max',
          );
  }
}

class RequiredValidator<T> extends Validator<T> {
  const RequiredValidator();

  @override
  SchemaValidationError? validate(value) {
    return value != null
        ? null
        : const SchemaValidationError.constraints('is required');
  }
}

// unique item list validator
class UniqueItemsValidator<T> extends Validator<List<T>> {
  const UniqueItemsValidator();

  @override
  SchemaValidationError? validate(List<T> value) {
    final unique = value.toSet().toList();
    return unique.length == value.length
        ? null
        : const SchemaValidationError.constraints('List items are not unique');
  }
}

// min length of list validator
class MinItemsValidator<T> extends Validator<List<T>> {
  final int min;
  const MinItemsValidator(this.min);

  @override
  SchemaValidationError? validate(List<T> value) {
    return value.length >= min
        ? null
        : SchemaValidationError.constraints(
            'List length is less than the minimum required length: $min',
          );
  }
}

// max length of list validator
class MaxItemsValidator<T> extends Validator<List<T>> {
  final int max;
  const MaxItemsValidator(this.max);

  @override
  SchemaValidationError? validate(List<T> value) {
    return value.length <= max
        ? null
        : SchemaValidationError.constraints(
            'List length is greater than the maximum required length: $max',
          );
  }
}
