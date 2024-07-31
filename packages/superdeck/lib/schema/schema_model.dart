import 'schema_validation.dart';
import 'schema_values.dart';
import 'validators.dart';

typedef JSON = Map<String, dynamic>;

class SchemaMap extends SchemaValue<Map<String, dynamic>> {
  final Map<String, SchemaValue> properties;
  final bool additionalProperties;
  const SchemaMap(
    this.properties, {
    super.optional = true,
    this.additionalProperties = false,
    super.validators = const [],
  });

  @override
  SchemaMap copyWith({
    bool? optional,
    bool? additionalProperties,
    Map<String, SchemaValue>? properties,
    List<Validator<Map<String, dynamic>>>? validators,
  }) {
    return SchemaMap(
      properties ?? this.properties,
      additionalProperties: additionalProperties ?? this.additionalProperties,
      optional: optional ?? optionalValue,
      validators: validators ?? this.validators,
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
    bool? optional,
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
      optional: optional,
      additionalProperties: additionalProperties,
    );
  }

  @override
  SchemaValidationResult validate(List<String> path, Object? value) {
    if (value == null) {
      return optionalValue
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
        .where((entry) => !entry.value.optionalValue)
        .map((entry) => entry.key);

    final requiredKeys = required.toSet();

    if (!keys.containsAll(requiredKeys)) {
      return SchemaValidationResult(
          key: path,
          errors: requiredKeys
              .difference(keys)
              .map(SchemaError.requiredPropMissing)
              .toList());
    }

    if (additionalProperties == false) {
      final extraKeys = keys.difference(properties.keys.toSet());
      if (extraKeys.isNotEmpty) {
        return SchemaValidationResult(
          key: path,
          errors:
              extraKeys.map(SchemaError.unallowedAdditionalProperty).toList(),
        );
      }
    }

    for (final entry in parsedValue.entries) {
      final key = entry.key;
      final prop = properties[key];

      if (prop == null) {
        return additionalProperties == false
            ? SchemaValidationResult(
                key: path,
                errors: [SchemaError.unallowedAdditionalProperty(key)])
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

class SchemaShape extends SchemaMap {
  const SchemaShape(
    super.properties, {
    super.additionalProperties = false,
  });
}

typedef _DoubleType = double;

class Schema {
  const Schema._();

  static const string = SchemaValue<String>();
  static const map = SchemaShape.new;
  static const double = SchemaValue<_DoubleType>();
  static const integer = SchemaValue<int>();
  static const boolean = SchemaValue<bool>();
  static const any = SchemaShape({}, additionalProperties: true);
}
