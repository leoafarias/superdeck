import 'schema_model.dart';
import 'validators.dart';

abstract class SchemaValue<V> {
  const SchemaValue({
    required this.optional,
    required this.validators,
  });

  SchemaValue<V> copyWith({
    bool? optional,
    List<Validator<V>>? validators,
  });

  SchemaValue<V> isRequired() {
    return copyWith(optional: false);
  }

  SchemaValue<V> isOptional() {
    return copyWith(optional: true);
  }

  final bool optional;
  final List<Validator<V>> validators;

  bool get required => !optional;

  V? tryParse(Object value) => value as V?;

  void validateOrThrow(Object value) {
    final result = validate([], value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }

  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return optional
          ? SchemaValidationResult.valid(path)
          : SchemaValidationResult.requiredPropMissing(path);
    }

    final valueType = tryParse(value);

    if (valueType == null) {
      return SchemaValidationResult.invalidType(path, value, V.toString());
    }

    for (final validator in validators) {
      final error = validator.validate(valueType);
      if (error != null) {
        return SchemaValidationResult.constraints(path, error.message);
      }
    }

    return SchemaValidationResult.valid(path);
  }
}

/// Used to remove value from SchemaMap
class NullSchema extends SchemaValue<Null> {
  const NullSchema({super.optional = false, super.validators = const []});

  @override
  NullSchema copyWith({
    bool? optional,
    List<Validator<Null>>? validators,
  }) {
    return NullSchema(
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  Null tryParse(Object? value) {
    return value == null ? null : null;
  }
}

class DoubleSchema extends SchemaValue<double> {
  const DoubleSchema({super.optional = false, super.validators = const []});

  @override
  DoubleSchema copyWith({
    bool? optional,
    List<Validator<double>>? validators,
  }) {
    return DoubleSchema(
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  double? tryParse(Object value) {
    if (value is double) {
      return value;
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value);
    }

    return null;
  }
}

class EnumSchema extends StringSchema {
  final List<String> values;
  const EnumSchema({
    required this.values,
    super.optional = false,
    super.validators = const [],
  });

  @override
  EnumSchema copyWith({
    List<String>? values,
    bool? optional,
    List<Validator<String>>? validators,
  }) {
    return EnumSchema(
      values: values ?? this.values,
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  SchemaValidationResult validate(List<String> path, Object? value) {
    final result = super.validate(path, value);

    if (result.isValid) {
      final parsedValue = tryParse(value);

      if (parsedValue != null && !values.contains(parsedValue)) {
        return SchemaValidationResult.enumViolated(path, parsedValue, values);
      }
    }

    return result;
  }
}

class StringSchema extends SchemaValue<String> {
  const StringSchema({super.optional = false, super.validators = const []});

  @override
  StringSchema copyWith({
    bool? optional,
    List<Validator<String>>? validators,
  }) {
    return StringSchema(
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  String? tryParse(Object? value) {
    return value is String ? value : null;
  }
}

class IntegerSchema extends SchemaValue<int> {
  const IntegerSchema({super.optional = false, super.validators = const []});

  @override
  IntegerSchema copyWith({
    bool? optional,
    List<Validator<int>>? validators,
  }) {
    return IntegerSchema(
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  int? tryParse(Object value) {
    if (value is int) {
      return value;
    }

    if (value is String) {
      return int.tryParse(value);
    }

    return null;
  }
}

class BooleanSchema extends SchemaValue<bool> {
  const BooleanSchema({super.optional = false, super.validators = const []});

  @override
  BooleanSchema copyWith({
    bool? optional,
    List<Validator<bool>>? validators,
  }) {
    return BooleanSchema(
      optional: optional ?? this.optional,
      validators: validators ?? this.validators,
    );
  }

  @override
  bool? tryParse(Object? value) {
    if (value is bool) {
      return value;
    }

    if (value is String) {
      if (value.toLowerCase() == 'true') {
        return true;
      } else if (value.toLowerCase() == 'false') {
        return false;
      }
    }

    return null;
  }
}

extension StringSchemaExt on SchemaValue<String> {
  SchemaValue<String> isPosixPath() {
    return copyWith(validators: [
      ...validators,
      const PosixPathValidator(),
    ]);
  }

  SchemaValue<String> isEmail() {
    return copyWith(validators: [
      ...validators,
      const EmailValidator(),
    ]);
  }

  SchemaValue<String> isHexColor() {
    return copyWith(validators: [
      ...validators,
      const HexColorValidator(),
    ]);
  }

  SchemaValue<String> isEmpty() {
    return copyWith(validators: [
      ...validators,
      const IsEmptyValidator(),
    ]);
  }

  SchemaValue<String> minLength(int min) {
    return copyWith(validators: [
      ...validators,
      MinLengthValidator(min),
    ]);
  }

  SchemaValue<String> maxLength(int max) {
    return copyWith(validators: [
      ...validators,
      MaxLengthValidator(max),
    ]);
  }
}
