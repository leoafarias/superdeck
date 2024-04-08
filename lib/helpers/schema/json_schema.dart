import 'package:dart_mappable/dart_mappable.dart';

import 'validators.dart';

part 'json_schema.mapper.dart';

typedef JSON = Map<String, dynamic>;

class SchemaValidationException implements Exception {
  final SchemaValidationResult result;

  const SchemaValidationException(this.result);
}

class SchemaError {
  const SchemaError._();
  static const unallowedAdditionalProperty = 'unnalowed_additional_property';
  static const enumViolated = 'enum_violated';
  static const requiredPropMissing = 'required_property_missing';
  static const invalidType = 'invalid_type';
  static const constraints = 'constraints';
  static const unknown = 'unknown';
}

@MappableClass()
class SchemaValidationError with SchemaValidationErrorMappable {
  final String type;
  final String message;
  const SchemaValidationError({
    required this.type,
    required this.message,
  });

  const SchemaValidationError.unknown()
      : type = SchemaError.unknown,
        message = 'Unknown error';

  const SchemaValidationError.constraints(this.message)
      : type = SchemaError.constraints;

  const SchemaValidationError.unallowedAdditionalProperty(String property)
      : type = SchemaError.unallowedAdditionalProperty,
        message = 'Unallowed property: $property';

  const SchemaValidationError.enumViolated(String value)
      : type = SchemaError.enumViolated,
        message = 'Wrong value: $value';

  const SchemaValidationError.requiredPropMissing(String property)
      : type = SchemaError.requiredPropMissing,
        message = 'Missing prop: $property';

  const SchemaValidationError.invalidType(String value, String expectedType)
      : type = SchemaError.invalidType,
        message = 'Invalid type: [$expectedType] got [$value]';

  @override
  String toString() {
    return 'SchemaValidationError{type: $type, message: $message}';
  }
}

@MappableClass()
class SchemaValidationResult with SchemaValidationResultMappable {
  final List<String> key;
  final List<SchemaValidationError> errors;

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
        SchemaValidationError.invalidType(
          value.runtimeType.toString(),
          expectedType,
        )
      ],
    );
  }

  factory SchemaValidationResult.unallowedAdditionalProperty(
      List<String> path, String property) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaValidationError.unallowedAdditionalProperty(property)],
    );
  }

  factory SchemaValidationResult.enumViolated(List<String> path, String value) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaValidationError.enumViolated(value)],
    );
  }

  factory SchemaValidationResult.requiredPropMissing(List<String> path) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaValidationError.requiredPropMissing(path.last)],
    );
  }

  factory SchemaValidationResult.constraints(
      List<String> path, String message) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaValidationError.constraints(message)],
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

class SchemaProperty<T extends SchemaValue<V>, V> {
  final T schema;
  final bool optional;
  final List<Validator<V>> validators;

  const SchemaProperty({
    required this.schema,
    required this.optional,
    this.validators = const [],
  });

  SchemaProperty<T, V> constraint(Validator<V> validator) {
    return SchemaProperty(
      schema: this as T,
      optional: optional,
      validators: [...validators, validator],
    );
  }

  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return optional
          ? SchemaValidationResult.valid(path)
          : SchemaValidationResult.requiredPropMissing(path);
    }

    final valueType = schema.tryParse(value);

    if (valueType == null) {
      return SchemaValidationResult.invalidType(
          path, value, schema.valueType.toString());
    }

    if (schema is Schema) {
      return (schema as Schema).validate(path, value);
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

abstract class SchemaValue<V> {
  const SchemaValue();

  Type get valueType => V;

  V? tryParse(Object value) => value as V?;

  SchemaProperty<T, V> optional<T extends SchemaValue<V>>() {
    return SchemaProperty(schema: this as T, optional: true);
  }

  SchemaProperty<T, V> required<T extends SchemaValue<V>>() {
    return SchemaProperty(schema: this as T, optional: false);
  }
}

class DoubleSchema extends SchemaValue<double> {
  const DoubleSchema();

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

class EnumSchema<T, V> extends SchemaValue<T> {
  final List<V> values;
  const EnumSchema({
    required this.values,
  });

  @override
  T? tryParse(Object value) {
    return values.contains(value) ? value as T : null;
  }
}

class StringSchema extends SchemaValue<String> {
  const StringSchema();

  @override
  String? tryParse(Object? value) {
    return value is String ? value : null;
  }
}

class IntegerSchema extends SchemaValue<int> {
  const IntegerSchema();

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
  const BooleanSchema();

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

class SchemaMap extends SchemaValue<Map<String, dynamic>> {
  const SchemaMap();

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }
}

class Schema extends SchemaMap {
  final Map<String, SchemaProperty> properties;
  final bool additionalProperties;
  const Schema(
    this.properties, {
    this.additionalProperties = false,
  });

  static const string = StringSchema();
  static const double = DoubleSchema();
  static const integer = IntegerSchema();
  static const boolean = BooleanSchema();

  static const enumType = EnumSchema.new;

  static const any = Schema({}, additionalProperties: true);

  SchemaValidationResult validate(List<String> path, Object value) {
    if (value is Map<String, dynamic>) {
      final keys = value.keys.toSet();
      final required = properties.entries
          .where((entry) => !entry.value.optional)
          .map((entry) => entry.key);
      final requiredKeys = required.toSet();

      if (!keys.containsAll(requiredKeys)) {
        return SchemaValidationResult(
            key: path,
            errors: requiredKeys
                .difference(keys)
                .map(SchemaValidationError.requiredPropMissing)
                .toList());
      }
      if (additionalProperties == false) {
        final extraKeys = keys.difference(properties.keys.toSet());
        if (extraKeys.isNotEmpty) {
          return SchemaValidationResult(
            key: path,
            errors: extraKeys
                .map(SchemaValidationError.unallowedAdditionalProperty)
                .toList(),
          );
        }
      }
      final errors = value.entries.map((entry) {
        final key = entry.key;
        final prop = properties[key];

        if (prop == null) {
          return additionalProperties == true
              ? SchemaValidationResult.valid(path)
              : SchemaValidationResult.unallowedAdditionalProperty(
                  path,
                  key,
                );
        }

        return prop.validate([...path, key], entry.value);
      }).toList();

      if (errors.any((error) => !error.isValid)) {
        return errors.first;
      }

      return SchemaValidationResult.valid(path);
    } else {
      return SchemaValidationResult.invalidType(
        path,
        value,
        <String, dynamic>{}.toString(),
      );
    }
  }

  void validateOrThrow(String key, Object value) {
    final result = validate([key], value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }

  Schema merge(
    Map<String, SchemaProperty> properties, {
    bool? additionalProperties,
  }) {
    return Schema(
      {...this.properties, ...properties},
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }
}
