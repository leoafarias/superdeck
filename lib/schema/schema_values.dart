import 'package:flutter/material.dart';

import 'schema_validation.dart';
import 'validators.dart';

class SchemaValue<V> {
  const SchemaValue({
    bool optional = true,
    this.validators = const [],
  }) : optionalValue = optional;

  SchemaValue<V> copyWith({
    bool? optional,
    List<Validator<V>>? validators,
  }) {
    return SchemaValue<V>(
      optional: optional ?? this.optionalValue,
      validators: validators ?? this.validators,
    );
  }

  SchemaValue<V> required() {
    return copyWith(optional: false);
  }

  SchemaValue<V> optional() {
    return copyWith(optional: true);
  }

  @protected
  final bool optionalValue;

  final List<Validator<V>> validators;

  bool get requiredValue => !optionalValue;

  V? tryParse(Object? value) {
    if (value is V) {
      return value;
    }
    if (V is int) {
      return _tryParseInt(value) as V?;
    }

    if (V is double) {
      return _tryParseDouble(value) as V?;
    }

    if (V is bool) {
      return _tryParseBool(value) as V?;
    }

    return null;
  }

  void validateOrThrow(Object value) {
    final result = validate([], value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }

  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return optionalValue
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

double? _tryParseDouble(Object? value) {
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

bool? _tryParseBool(Object? value) {
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

int? _tryParseInt(Object? value) {
  if (value is int) {
    return value;
  }

  if (value is String) {
    return int.tryParse(value);
  }

  return null;
}

class BooleanSchema extends SchemaValue<bool> {
  const BooleanSchema({super.optional = false, super.validators = const []});

  @override
  BooleanSchema copyWith({
    bool? optional,
    List<Validator<bool>>? validators,
  }) {
    return BooleanSchema(
      optional: optional ?? optionalValue,
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

  SchemaValue<String> isArray(List<String> values) {
    return copyWith(validators: [
      ...validators,
      ArrayValidator(values),
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
