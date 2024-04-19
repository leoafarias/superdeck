import 'package:dart_mappable/dart_mappable.dart';

import 'schema_values.dart';

part 'schema.mapper.dart';

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
        message = 'Unallowed property: [$property]';

  const SchemaValidationError.enumViolated(
      String value, List<String> possibleValues)
      : type = SchemaError.enumViolated,
        message = 'Wrong value: [$value] \n\n Possible values: $possibleValues';

  const SchemaValidationError.requiredPropMissing(String property)
      : type = SchemaError.requiredPropMissing,
        message = 'Missing prop: [$property]';

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

  factory SchemaValidationResult.enumViolated(
      List<String> path, String value, List<String> possibleValues) {
    return SchemaValidationResult(
      key: path,
      errors: [SchemaValidationError.enumViolated(value, possibleValues)],
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

class SchemaMap extends SchemaValue<Map<String, dynamic>> {
  final Map<String, SchemaValue> properties;
  final bool additionalProperties;
  const SchemaMap(
    this.properties, {
    super.isOptional = false,
    this.additionalProperties = false,
  }) : super(validators: const []);

  // optional constructor
  const SchemaMap.optional(
    this.properties, {
    this.additionalProperties = false,
  }) : super(
          validators: const [],
          isOptional: true,
        );

  @override
  SchemaMap copyWith({
    bool? isOptional,
    bool? additionalProperties,
    Map<String, SchemaValue>? properties,
  }) {
    return SchemaMap(
      properties ?? this.properties,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      isOptional: isOptional ?? this.isOptional,
    );
  }

  @override
  Map<String, dynamic>? tryParse(Object? value) {
    return value is Map<String, dynamic> ? value : null;
  }

  SchemaMap mergeSchema(SchemaMap schema) {
    return merge(
      schema.properties,
      additionalProperties: schema.additionalProperties,
    );
  }

  T? getSchemaValue<T extends SchemaValue>(String key) {
    return properties[key] as T?;
  }

  SchemaMap merge(
    Map<String, SchemaValue> properties, {
    bool? additionalProperties,
    bool? isOptional,
  }) {
    // if property SchemaValue is of SchemaMap, we need to merge them
    final mergedProperties = {...this.properties};

    for (final entry in properties.entries) {
      final key = entry.key;
      final prop = entry.value;

      final existingProp = mergedProperties[key];

      if (existingProp is SchemaMap && prop is SchemaMap) {
        mergedProperties[key] = existingProp.merge(prop.properties);
      } else {
        mergedProperties[key] = prop;
      }
    }

    return copyWith(
      properties: mergedProperties,
      isOptional: isOptional,
      additionalProperties: additionalProperties,
    );
  }

  @override
  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return isOptional
          ? SchemaValidationResult.valid(path)
          : SchemaValidationResult.requiredPropMissing(path);
    }

    final parsedValue = tryParse(value);

    if (parsedValue == null) {
      return SchemaValidationResult.invalidType(
        path,
        value,
        <String, dynamic>{}.toString(),
      );
    }

    final keys = parsedValue.keys.toSet();

    final required = properties.entries
        .where((entry) => !entry.value.isOptional)
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

    for (final entry in parsedValue.entries) {
      final key = entry.key;
      final prop = properties[key];

      if (prop == null) {
        return additionalProperties == false
            ? SchemaValidationResult(key: path, errors: [
                SchemaValidationError.unallowedAdditionalProperty(key)
              ])
            : SchemaValidationResult.valid(path);
      }

      final result = prop.validate([...path, key], entry.value);
      if (!result.isValid) {
        return result;
      }
    }

    return SchemaValidationResult.valid(path);
  }
}

class Schema extends SchemaMap {
  const Schema(
    super.properties, {
    super.additionalProperties = false,
  });

  static const string = StringSchema();
  static const double = DoubleSchema();
  static const integer = IntegerSchema();
  static const boolean = BooleanSchema();

  static const enumType = EnumSchema.new;

  static const any = Schema({}, additionalProperties: true);
}
