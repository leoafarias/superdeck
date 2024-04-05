import 'package:json_schema/json_schema.dart';

import '../models/schema_error_model.dart';
import 'constants.dart';
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

JSON _baseConfig = {
  "layout": {r"$ref": "#/definitions/LayoutType"},
  "background": {"type": "string"},
  "alignment": {r"$ref": "#/definitions/ContentAlignment"},
  "style": {"type": "string"},
  "transition": {r"$ref": "#/definitions/TransitionOptions"},
};

JSON _slideOptions = {
  "title": {"type": "string"},
  "content": {"type": "string"},
  "widget": {r"$ref": "#/definitions/WidgetOptions"},
  "image": {r"$ref": "#/definitions/ImageOptions"},
};

JSON _defContentAlignment = {
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
};

JSON _defTransitionType = {
  "type": "string",
  "enum": [
    "fade_in",
    "fade_out",
    "slide_in_left",
    "slide_in_right",
    "slide_in_up",
    "slide_in_down",
    "slide_out_left",
    "slide_out_right",
    "slide_out_up",
    "slide_out_down",
    "zoom_in",
    "zoom_out",
    "bounce_in",
    "bounce_out",
    "flip_in_x",
    "flip_in_y",
    "spin",
    "spin_perfect",
    "jello",
    "bounce",
    "flash",
    "pulse",
    "shake_x",
    "shake_y",
    "swing",
    "elastic_in",
    "elastic_out",
    "elastic_in_out",
    "fast_linear_to_slow_ease_in",
    "fast_out_slow_in",
    "linear",
    "decelerate",
    "slow_middle",
    "linear_to_ease_out"
  ]
};

JSON _defCurveType = {
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
};

JSON _defImageFit = {
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
};

JSON _defLayoutType = {
  "type": "string",
  "enum": [
    "image",
    "simple",
    "widget",
    "two_column",
    "two_column_header",
    "invalid"
  ]
};

JSON _defTransitionOptions = {
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "type": {r"$ref": "#/definitions/TransitionType"},
    "duration": {"type": "integer"},
    "delay": {"type": "integer"},
    "curve": {r"$ref": "#/definitions/CurveType"}
  },
  "required": ["type"]
};

JSON _defImageOptions = {
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "src": {"type": "string"},
    "fit": {r"$ref": "#/definitions/ImageFit"},
    "position": {r"$ref": "#/definitions/LayoutPosition"},
    "flex": {"type": "integer"},
  },
  "required": ["src"]
};

JSON _defWidgetOptions = {
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "name": {"type": "string"},
    "args": {"type": "object", "additionalProperties": true},
    "position": {r"$ref": "#/definitions/LayoutPosition"},
    "flex": {"type": "integer"},
  },
  "required": ["name"]
};

JSON _defLayoutPosition = {
  "type": "string",
  "enum": ["left", "right", "top", "bottom"],
};

JSON _jsonSchema(JSON options) => {
      "type": "object",
      "additionalProperties": false,
      "properties": options,
      "required": [],
      "definitions": {
        "LayoutPosition": _defLayoutPosition,
        "ContentAlignment": _defContentAlignment,
        "TransitionType": _defTransitionType,
        "CurveType": _defCurveType,
        "ImageFit": _defImageFit,
        "LayoutType": _defLayoutType,
        "TransitionOptions": _defTransitionOptions,
        "ImageOptions": _defImageOptions,
        "WidgetOptions": _defWidgetOptions,
      },
    };
