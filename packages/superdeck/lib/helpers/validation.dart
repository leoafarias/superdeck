import 'package:json_schema/json_schema.dart';

import '../models/schema_error_model.dart';
import 'deep_merge.dart';

final projectSchemeValidator = JsonSchema.create(_jsonSchema(_baseConfig));
final schemaValidator = JsonSchema.create(
  _jsonSchema(deepMerge(_baseConfig, _slideOptions)),
);

SchemaError parseErrorObject(ValidationError error) {
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

  return SchemaError(
    location: location,
    propertyName: propertyName,
    value: value,
    errorType: errorType,
  );
}

String getCleanErrorMessage(SchemaError error) {
  switch (error.errorType) {
    case ErrorType.unallowedAdditionalProperty:
      return "Location: ${error.location}. Unallowed additional property: ${error.value}.";
    case ErrorType.enumViolated:
      return "Location: ${error.location}. wrong value: ${error.value}.";
    case ErrorType.requiredPropMissing:
      return "Location: ${error.location}. Required property missing: ${error.value}.";
    case ErrorType.invalidType:
      return "Location: ${error.location}. Invalid type: ${error.value}.";
    default:
      return 'Unknown error type.';
  }
}

String composeErrorMessage(List<SchemaError> errors) {
  return errors.map(getCleanErrorMessage).join('\n');
}

Map<String, dynamic> get _baseConfig => {
      "layout": {r"$ref": "#/definitions/LayoutType"},
      "background": {"type": "string"},
      "alignment": {r"$ref": "#/definitions/ContentAlignment"},
      "style": {"type": "string"},
      "transition": {r"$ref": "#/definitions/TransitionOptions"},
    };

Map<String, dynamic> get _slideOptions => {
      "title": {"type": "string"},
      "content": {"type": "string"},
      "widget": {r"$ref": "#/definitions/WidgetOptions"},
      "image": {r"$ref": "#/definitions/ImageOptions"},
    };

Map<String, dynamic> _jsonSchema(Map<String, dynamic> options) => {
      "type": "object",
      "additionalProperties": false,
      "properties": options,
      "required": [],
      "definitions": {
        "LayoutPosition": {
          "type": "string",
          "enum": ["left", "right", "top", "bottom"],
        },
        "ContentAlignment": {
          "type": "string",
          "enum": [
            "top_left",
            "top_center",
            "top_right",
            "center_left",
            "center",
            "center_right",
            "bottom_left",
            "bottom_center",
            "bottom_right"
          ]
        },
        "TransitionType": {
          "type": "string",
          "enum": [
            "fade_in",
            "fade_in_down",
            "fade_in_down_big",
            "fade_in_up",
            "fade_in_up_big",
            "fade_in_left",
            "fade_in_left_big",
            "fade_in_right",
            "fade_in_right_big",
            "fade_out",
            "fade_out_down",
            "fade_out_down_big",
            "fade_out_up",
            "fade_out_up_big",
            "fade_out_left",
            "fade_out_left_big",
            "fade_out_right",
            "fade_out_right_big",
            "bounce_in_down",
            "bounce_in_up",
            "bounce_in_left",
            "bounce_in_right",
            "elastic_in",
            "elastic_in_down",
            "elastic_in_up",
            "elastic_in_left",
            "elastic_in_right",
            "slide_in_down",
            "slide_in_up",
            "slide_in_left",
            "slide_in_right",
            "flip_in_x",
            "flip_in_y",
            "zoom_in",
            "zoom_out",
            "jello_in",
            "bounce",
            "dance",
            "flash",
            "pulse",
            "roulette",
            "shake_x",
            "shake_y",
            "spin",
            "spin_perfect",
            "swing"
          ]
        },
        "CurveType": {
          "type": "string",
          "enum": [
            "ease",
            "bounce_in",
            "bounce_out",
            "ease_in",
            "ease_in_out",
            "ease_out",
            "elastic_in",
            "elastic_in_out",
            "elastic_out",
            "fast_linear_to_slow_ease_in",
            "fast_out_slow_in",
            "linear",
            "decelerate",
            "slow_middle",
            "linear_to_ease_out"
          ]
        },
        "ImageFit": {
          "type": "string",
          "enum": [
            "fill",
            "contain",
            "cover",
            "fit_width",
            "fit_height",
            "none",
            "scale_down"
          ]
        },
        "LayoutType": {
          "type": "string",
          "enum": [
            "image",
            "simple",
            "widget",
            "two_column",
            "two_column_header",
            "invalid"
          ]
        },
        "TransitionOptions": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "type": {r"$ref": "#/definitions/TransitionType"},
            "duration": {"type": "integer"},
            "delay": {"type": "integer"},
            "curve": {r"$ref": "#/definitions/CurveType"}
          },
          "required": ["type"]
        },
        "ImageOptions": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "src": {"type": "string"},
            "fit": {r"$ref": "#/definitions/ImageFit"},
            "position": {r"$ref": "#/definitions/LayoutPosition"}
          },
          "required": ["src"]
        },
        "WidgetOptions": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "name": {"type": "string"},
            "args": {"type": "object", "additionalProperties": true},
            "position": {r"$ref": "#/definitions/LayoutPosition"}
          },
          "required": ["name"]
        },
      },
    };
