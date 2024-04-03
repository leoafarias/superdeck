import '../models/config_model.dart';
import '../models/slide_options_model.dart';

Map<String, dynamic> get jsonSchema => {
      "type": "object",
      "additionalProperties": false,
      "properties": {
        "title": {"type": "string"},
        "layout": {r"$ref": "#/definitions/LayoutType"},
        "background": {"type": "string"},
        "alignment": {r"$ref": "#/definitions/ContentAlignment"},
        "content": {"type": "string"},
        "style": {"type": "string"},
        "widget": {r"$ref": "#/definitions/WidgetOptions"},
        "image": {r"$ref": "#/definitions/ImageOptions"},
        "transition": {
          "oneOf": [
            {r"$ref": "#/definitions/TransitionType"},
            {r"$ref": "#/definitions/TransitionOptions"}
          ]
        },
      },
      "definitions": {
        "LayoutPosition": {
          "type": "string",
          "enum": ["left", "right", "top", "bottom"]
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
          "properties": {
            "src": {"type": "string"},
            "fit": {r"$ref": "#/definitions/ImageFit"},
            "position": {r"$ref": "#/definitions/LayoutPosition"}
          },
          "required": ["src"]
        },
        "WidgetOptions": {
          "type": "object",
          "properties": {
            "name": {"type": "string"},
            "args": {"type": "object", "additionalProperties": true},
            "position": {r"$ref": "#/definitions/LayoutPosition"}
          },
          "required": ["name"]
        },
      },
    };

class SlideValidator {
  static const String _errorPrefix = '❌ Error: ';
  static const String _successPrefix = '✅ Valid: ';

  List<String> validate(List<Map<String, dynamic>> slides) {
    List<String> validationMessages = [];
    void errorMessage(String message, int index) {
      validationMessages.add('$_errorPrefix Slide ${index + 1} $message');
    }

    for (int i = 0; i < slides.length; i++) {
      Map<String, dynamic> slide = slides[i];

      // Validate required fields
      if (!slide.containsKey('content')) {
        errorMessage('is missing required field "content".', i);
      }

      // Validate optional fields
      if (slide.containsKey('layout')) {
        final layout = slide['layout'];

        if (LayoutTypes.values.contains(layout)) {
          errorMessage('has an invalid "layout" value: $layout', i);
        }
      }

      if (slide.containsKey('background')) {
        final background = slide['background'];
        if (background is! String) {
          errorMessage('has an invalid "background" value: $background', i);
        }
      }

      if (slide.containsKey('options')) {
        Map<String, dynamic> options = slide['options'];
        if (options.containsKey('position')) {
          final value = options['position'];
          if (!LayoutPosition.values.contains(value)) {
            errorMessage('has an invalid "position" value: $value', i);
          }
        }
        if (options.containsKey('args')) {
          final value = options['args'];
          if (value is! Map<String, dynamic>) {
            errorMessage('has an invalid "args" value: $value', i);
          }
        }
      }

      if (slide.containsKey('alignment')) {
        final value = slide['alignment'];
        if (!ContentAlignment.values.contains(value)) {
          errorMessage('has an invalid "alignment" value: $value', i);
        }
      }

      if (slide.containsKey('style')) {
        final value = slide['style'];
        if (value! is String) {
          errorMessage('has an invalid "style" value: $value', i);
        }
      }

      if (slide.containsKey('transition')) {
        final value = slide['transition'];
        if (value is String) {
          if (!TransitionType.values.contains(value)) {}
        }
      }

      if (slide.containsKey('image')) {
        Map<String, dynamic> image = slide['image'];
        if (!image.containsKey('src') ||
            !image.containsKey('fit') ||
            !image.containsKey('position')) {
          validationMessages.add(
              '$_errorPrefix Slide ${i + 1} is missing required fields in "image".');
        }
      }
    }

    if (validationMessages.isEmpty) {
      validationMessages.add('$_successPrefix All slides are valid.');
    }

    return validationMessages;
  }
}
