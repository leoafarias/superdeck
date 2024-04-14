import 'schema.dart';
import 'validators.dart';

abstract class SchemaValue<V> {
  const SchemaValue({
    required this.isOptional,
    required this.validators,
  });

  SchemaValue<V> copyWith({
    bool? isOptional,
  });

  SchemaValue<V> required() {
    return copyWith(isOptional: false);
  }

  SchemaValue<V> optional() {
    return copyWith(isOptional: true);
  }

  final bool isOptional;
  final List<Validator<V>> validators;

  bool get isRequired => !isOptional;

  V? tryParse(Object value) => value as V?;

  void validateOrThrow(String key, Object value) {
    final result = validate([key], value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }

  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return isOptional
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
  const NullSchema({super.isOptional = false, super.validators = const []});

  @override
  NullSchema copyWith({
    bool? isOptional,
    List<Validator<Null>>? validators,
  }) {
    return NullSchema(
      isOptional: isOptional ?? this.isOptional,
      validators: validators ?? this.validators,
    );
  }

  @override
  Null tryParse(Object? value) {
    return value == null ? null : null;
  }
}

class DoubleSchema extends SchemaValue<double> {
  const DoubleSchema({super.isOptional = false, super.validators = const []});

  @override
  DoubleSchema copyWith({
    bool? isOptional,
    List<Validator<double>>? validators,
  }) {
    return DoubleSchema(
      isOptional: isOptional ?? this.isOptional,
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
    super.isOptional = false,
    super.validators = const [],
  });

  @override
  EnumSchema copyWith({
    List<String>? values,
    bool? isOptional,
    List<Validator<String>>? validators,
  }) {
    return EnumSchema(
      values: values ?? this.values,
      isOptional: isOptional ?? this.isOptional,
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
  const StringSchema({super.isOptional = false, super.validators = const []});

  @override
  StringSchema copyWith({
    bool? isOptional,
    List<Validator<String>>? validators,
  }) {
    return StringSchema(
      isOptional: isOptional ?? this.isOptional,
      validators: validators ?? this.validators,
    );
  }

  @override
  String? tryParse(Object? value) {
    return value is String ? value : null;
  }
}

class IntegerSchema extends SchemaValue<int> {
  const IntegerSchema({super.isOptional = false, super.validators = const []});

  @override
  IntegerSchema copyWith({
    bool? isOptional,
    List<Validator<int>>? validators,
  }) {
    return IntegerSchema(
      isOptional: isOptional ?? this.isOptional,
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
  const BooleanSchema({super.isOptional = false, super.validators = const []});

  @override
  BooleanSchema copyWith({
    bool? isOptional,
    List<Validator<bool>>? validators,
  }) {
    return BooleanSchema(
      isOptional: isOptional ?? this.isOptional,
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
