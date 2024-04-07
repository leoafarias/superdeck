import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        message = 'Unallowed additional property: $property';

  const SchemaValidationError.enumViolated(String value)
      : type = SchemaError.enumViolated,
        message = 'Enum violated: $value';

  const SchemaValidationError.requiredPropMissing(String property)
      : type = SchemaError.requiredPropMissing,
        message = 'Required prop missing: $property';

  const SchemaValidationError.invalidType(String value, String expectedType)
      : type = SchemaError.invalidType,
        message = 'Type: wanted [$expectedType] got $value';

  @override
  String toString() {
    return 'SchemaValidationError{type: $type, message: $message}';
  }
}

@MappableClass()
class SchemaValidationResult with SchemaValidationResultMappable {
  final List<SchemaValidationError> errors;

  const SchemaValidationResult({
    required this.errors,
  });

  const SchemaValidationResult.valid() : errors = const [];

  static SchemaValidationResult invalidType<T>(
    T value,
    String expectedType,
  ) {
    return SchemaValidationResult(
      errors: [
        SchemaValidationError.invalidType(
          value.runtimeType.toString(),
          expectedType,
        )
      ],
    );
  }

  static SchemaValidationResult unallowedAdditionalProperty(String property) {
    return SchemaValidationResult(
      errors: [SchemaValidationError.unallowedAdditionalProperty(property)],
    );
  }

  static SchemaValidationResult enumViolated(String value) {
    return SchemaValidationResult(
      errors: [SchemaValidationError.enumViolated(value)],
    );
  }

  static SchemaValidationResult requiredPropMissing(String property) {
    return SchemaValidationResult(
      errors: [SchemaValidationError.requiredPropMissing(property)],
    );
  }

  static SchemaValidationResult constraints(String message) {
    return SchemaValidationResult(
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

abstract class SchemaType {
  const SchemaType();

  SchemaValidationResult validate(Object value);

  void validateOrThrow(Object value) {
    final result = validate(value);
    if (!result.isValid) {
      throw SchemaValidationException(result);
    }
  }
}

@immutable
class Schema {
  final SchemaType type;

  const Schema({
    required this.type,
  });

  static const string = SchemaString();
  static const double = SchemaDouble();
  static const integer = SchemaInterger();
  static const boolean = SchemaBoolean();
  static const any = SchemaAny();
}

class SchemaDouble extends SchemaType {
  const SchemaDouble();

  @override
  SchemaValidationResult validate(Object value) {
    if (value is num) {
      return const SchemaValidationResult.valid();
    } else if (value is String) {
      if (double.tryParse(value) != null) {
        return const SchemaValidationResult.valid();
      }
    }
    return SchemaValidationResult.invalidType(value, 'number');
  }
}

class SchemaString extends SchemaType {
  const SchemaString();

  @override
  SchemaValidationResult validate(Object value) {
    if (value is String) {
      return const SchemaValidationResult.valid();
    } else {
      return SchemaValidationResult.invalidType(value, 'string');
    }
  }
}

class SchemaInterger extends SchemaType {
  const SchemaInterger();

  @override
  SchemaValidationResult validate(Object value) {
    if (value is int) {
      return const SchemaValidationResult.valid();
    } else if (value is String) {
      if (int.tryParse(value) != null) {
        return const SchemaValidationResult.valid();
      }
    }
    return SchemaValidationResult.invalidType(value, 'integer');
  }
}

class SchemaBoolean extends SchemaType {
  const SchemaBoolean();

  @override
  SchemaValidationResult validate(Object value) {
    if (value is bool) {
      return const SchemaValidationResult.valid();
    } else if (value is String) {
      if (value.toLowerCase() == 'true' || value.toLowerCase() == 'false') {
        return const SchemaValidationResult.valid();
      }
    }
    return SchemaValidationResult.invalidType(value, 'boolean');
  }
}

class SchemaAny extends SchemaType {
  const SchemaAny();

  @override
  SchemaValidationResult validate(Object value) =>
      const SchemaValidationResult.valid();
}

class SchemaList<T extends SchemaType> extends SchemaType {
  final T items;
  final int? min;
  final int? max;
  final bool? uniqueItems;

  const SchemaList({
    required this.items,
    this.min,
    this.max,
    this.uniqueItems,
  });

  @override
  SchemaValidationResult validate(Object value) {
    if (value is List) {
      if (min != null && value.length < min!) {
        return SchemaValidationResult.constraints(
          'List length is less than the minimum required length: $min',
        );
      }

      if (max != null && value.length > max!) {
        return SchemaValidationResult.constraints(
          'List length is greater than the maximum required length: $max',
        );
      }

      if (uniqueItems == true) {
        final unique = value.toSet();
        if (unique.length != value.length) {
          return SchemaValidationResult.constraints(
            'List items are not unique',
          );
        }
      }

      final errors = value.map((item) => items.validate(item)).toList();

      if (errors.any((error) => !error.isValid)) {
        return SchemaValidationResult(
          errors: errors.expand((e) => e.errors).toList(),
        );
      }

      return const SchemaValidationResult.valid();
    } else {
      return SchemaValidationResult.invalidType(value, 'List');
    }
  }
}

class SchemaMap extends SchemaType {
  final Map<String, SchemaType> properties;
  final bool? additionalProperties;
  final List<String> required;
  const SchemaMap({
    required this.properties,
    this.required = const [],
    this.additionalProperties,
  });

  const SchemaMap.any()
      : properties = const {},
        required = const [],
        additionalProperties = true;

  @override
  SchemaValidationResult validate(Object value) {
    if (value is Map<String, dynamic>) {
      final keys = value.keys.toSet();
      final requiredKeys = required.toSet();

      if (!keys.containsAll(requiredKeys)) {
        return SchemaValidationResult(
            errors: requiredKeys
                .difference(keys)
                .map(SchemaValidationError.requiredPropMissing)
                .toList());
      }
      if (additionalProperties == false) {
        final extraKeys = keys.difference(properties.keys.toSet());
        if (extraKeys.isNotEmpty) {
          return SchemaValidationResult(
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
              ? const SchemaValidationResult.valid()
              : SchemaValidationResult.unallowedAdditionalProperty(key);
        }

        return prop.validate(entry.value);
      }).toList();

      if (errors.any((error) => !error.isValid)) {
        return SchemaValidationResult(
          errors: errors.expand((e) => e.errors).toList(),
        );
      }

      return const SchemaValidationResult.valid();
    } else {
      return SchemaValidationResult.invalidType(value, 'Map<String, dynamic>');
    }
  }

  static SchemaMap merge(SchemaMap self, SchemaMap other) {
    final properties = {...self.properties, ...other.properties};

    return SchemaMap(
      properties: properties,
      additionalProperties:
          other.additionalProperties ?? self.additionalProperties,
      required: <String>{
        ...self.required,
        ...other.required,
      }.toList(),
    );
  }
}

class SchemaEnum extends SchemaString {
  final List<String> values;
  const SchemaEnum({
    required this.values,
  });

  @override
  SchemaValidationResult validate(Object value) {
    final result = super.validate(value);
    if (!result.isValid) {
      return result;
    }

    return values.contains(value)
        ? const SchemaValidationResult.valid()
        : SchemaValidationResult.enumViolated(value as String);
  }
}
