import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_schema/json_schema.dart';

import 'deep_merge.dart';

part 'json_schema.mapper.dart';

typedef JSON = Map<String, dynamic>;

class SchemaError implements Exception {
  final SchemaValidationResult result;

  const SchemaError(this.result);

  @override
  String toString() {
    return 'SchemaError: ${result.errors.map((e) => e.errorMessage).join('\n')}';
  }
}

@MappableEnum()
enum ErrorType {
  unallowedAdditionalProperty('Unallowed additional property'),
  enumViolated('Not a valid value'),
  requiredPropMissing('Required property missing'),
  invalidType('Invalid type'),
  unknown('Unknown error');

  const ErrorType(this.message);

  final String message;
}

@MappableClass()
class SchemaValidationError with SchemaValidationErrorMappable {
  final String location;
  final String propertyName;
  final String? value;
  final ErrorType errorType;

  const SchemaValidationError({
    required this.location,
    required this.propertyName,
    this.value,
    required this.errorType,
  });

  const SchemaValidationError.root({
    required String propertyName,
    required ErrorType errorType,
    String? value,
  }) : this(
          location: 'root',
          propertyName: propertyName,
          value: value,
          errorType: errorType,
        );

  String get errorMessage {
    switch (errorType) {
      case ErrorType.unallowedAdditionalProperty:
        return "## $location \n ${errorType.message}: `$value`.";
      case ErrorType.enumViolated:
        return "## $location \n ${errorType.message}: `$value`.";
      case ErrorType.requiredPropMissing:
        return "## $location \n ${errorType.message}: `$value`.";
      case ErrorType.invalidType:
        return "## $location \n ${errorType.message}: `$value`";
      default:
        return 'Unknown error type.';
    }
  }

  static const fromMap = SchemaValidationErrorMapper.fromMap;
  static const fromJson = SchemaValidationErrorMapper.fromJson;
}

@MappableClass()
class SchemaValidationResult with SchemaValidationResultMappable {
  final List<SchemaValidationError> errors;

  const SchemaValidationResult({
    required this.errors,
  });

  @override
  String toString() {
    return '${errors.isEmpty ? 'VALID' : 'INVALID'}${errors.isEmpty ? ', Errors: $errors' : ''}';
  }

  bool get isValid => errors.isEmpty;

  static const fromMap = SchemaValidationResultMapper.fromMap;
  static const fromJson = SchemaValidationResultMapper.fromJson;
}

@immutable
class Schema {
  final JSON _definition;

  static final Map<String, JsonSchema> _schemas = {};

  const Schema(
    JSON definition,
  ) : _definition = definition;

  // JSON get refDefinition => {_key: _definition};

  // JSON get ref => {r"$ref": "#/definitions/$_key"};

  JSON get definition => _definition;

  static SchemaString get string => SchemaString();
  static SchemaNumber get number => SchemaNumber();
  static SchemaInterger get integer => SchemaInterger();
  static SchemaObject get map => SchemaObject(
        optional: const {},
        additionalProperties: true,
      );

  Future<SchemaValidationResult> validate(JSON data) async {
    JsonSchema schema;
    if (_schemas.containsKey(_key)) {
      schema = _schemas[_key]!;
    } else {
      schema = await JsonSchema.createAsync(definition);
      _schemas[_key] = schema;
    }
    final result = schema.validate(data);
    return SchemaValidationResult(
      errors: result.errors.map(_parseErrorObject).toList(),
    );
  }

  Future<void> validateOrThrow(JSON data) async {
    final result = await validate(data);
    if (!result.isValid) {
      throw SchemaError(result);
    }
  }

  String get _key => _definition.hashCode.toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Schema && other._definition == _definition;
  }

  @override
  int get hashCode => _definition.hashCode;
}

class SchemaNumber extends Schema {
  SchemaNumber() : super({"type": "number"});
}

class SchemaString extends Schema {
  SchemaString() : super({"type": "string"});
}

class SchemaInterger extends Schema {
  SchemaInterger() : super({"type": "integer"});
}

class SchemaObject extends Schema {
  SchemaObject._({
    Map<String, dynamic> properties = const {},
    List<String> required = const [],
    bool additionalProperties = false,
  }) : super({
          "type": "object",
          "additionalProperties": additionalProperties,
          "properties": properties,
          "required": required,
        });
  factory SchemaObject({
    Map<String, Schema> optional = const {},
    Map<String, Schema> required = const {},
    bool additionalProperties = false,
  }) {
    return SchemaObject._(
      properties: {...optional, ...required}.map(
        (key, value) => MapEntry(key, value.definition),
      ),
      required: required.keys.toList(),
      additionalProperties: additionalProperties,
    );
  }

  static SchemaObject merge(SchemaObject self, SchemaObject other) {
    return SchemaObject._(
      properties: deepMerge(
        self._definition['properties'],
        other._definition['properties'],
      ),
      required: <String>{
        ...self._definition['required'],
        ...other._definition['required']
      }.toList(),
      additionalProperties: other._definition['additionalProperties'],
    );
  }
}

class SchemaEnum extends Schema {
  SchemaEnum({
    required List<String> values,
  }) : super({
          "type": "string",
          "enum": values,
        });
}

SchemaValidationError _parseErrorObject(ValidationError error) {
  final instancePath = error.instancePath ?? '';
  final message = error.message;

  var location = instancePath.replaceAll('/', '.');
  final propertyName = location.split('.').last;

  if (location.startsWith('.')) {
    location = location.substring(1);
  }

  dynamic value;
  ErrorType errorType = ErrorType.unknown;

  if (message.startsWith('unallowed additional property')) {
    errorType = ErrorType.unallowedAdditionalProperty;
    value = message.replaceAll('unallowed additional property', '').trim();
  } else if (message.startsWith('enum violated')) {
    errorType = ErrorType.enumViolated;
    // "enum violated rightf"
    value = message.split('enum violated').last.trim();
  } else if (message.startsWith('required prop missing:')) {
    errorType = ErrorType.requiredPropMissing;
    // "required prop missing: name from {position: rightf, argfs: {title: Awesome Widget, height: 200.02, width: 500.02}}"
    value = message
        .replaceAll('required prop missing:', '')
        .split('from')
        .first
        .trim();
  } else if (message.startsWith('type:')) {
    errorType = ErrorType.invalidType;
    // extract the type value from the message
    // "type: wanted [string] got 5"

    final type = message.split('[').last.split(']').first;
    value = message.split('got').last.trim();

    value = '$value, expected $type.';
  }

  return SchemaValidationError(
    location: location,
    propertyName: propertyName,
    value: value,
    errorType: errorType,
  );
}
