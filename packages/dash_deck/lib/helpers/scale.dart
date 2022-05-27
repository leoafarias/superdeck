import 'package:flutter/material.dart';

/// A class to help you scale your design on bigger or smaller screens to achieve the same design look.
class Scale {
  static Size size = const Size(0, 0);
  static Size _deviceScreenSize = const Size(0, 0);

  static double get _horizontallyScaleFactor {
    return _deviceScreenSize.width / size.width;
  }

  static double get _verticallyScaleFactor {
    return _deviceScreenSize.height / size.height;
  }

  static double get _fontScaleFactor {
    return _deviceScreenSize.width / size.width;
  }

  /// Setup the screen with a [context] and the [size] you will use.
  /// So, if you have a design with 1280 * 720. You will pass first the context
  /// then the design size.
  /// setup(context, Size(1280, 720))
  static void setup(BuildContext context, Size screenSize) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    _deviceScreenSize = mediaQuery.size;
    size = screenSize;
  }

  /// Setup the screen with the device screen [Size] and the [size] you will use.
  /// So, if you have a design with 1280 * 720. You will pass first the device
  /// screen size then the design size.
  /// setup(deviceScreenSize, Size(1280, 720))
  static void setupWith(Size deviceScreenSize, Size screenSize) {
    _deviceScreenSize = deviceScreenSize;
    size = screenSize;
  }

  /// Get the number scaled horizontally.
  static double scaleWidth(double? size) {
    if (size == null) return 12;
    return size * _horizontallyScaleFactor;
  }

  /// Get the number scaled vertically.
  static double scaleHeight(double? size) {
    if (size == null) return 12;
    return size * _verticallyScaleFactor;
  }

  /// Get the font scaled vertically.
  static double scaleFont(double? size) {
    if (size == null) return 12;
    return size * _fontScaleFactor;
  }
}

/// An extension to make it easier to apply scale on number.
extension DoubleExtension on double {
  /// Get the number scaled horizontally.
  double get sh {
    return Scale.scaleWidth(this);
  }

  /// Get the number scaled vertically.
  double get sv {
    return Scale.scaleHeight(this);
  }

  /// Get the font scaled vertically.
  double get sf {
    return Scale.scaleFont(this);
  }
}

ThemeData scaleTheme(BuildContext context) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return theme.copyWith(
    textTheme: textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.displayLarge?.fontSize,
        ),
      ),
      displayMedium: textTheme.displayMedium?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.displayMedium?.fontSize,
        ),
      ),
      displaySmall: textTheme.displaySmall?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.displaySmall?.fontSize,
        ),
      ),
      headlineLarge: textTheme.headlineLarge?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.headlineLarge?.fontSize,
        ),
      ),
      headlineMedium: textTheme.headlineMedium?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.headlineMedium?.fontSize,
        ),
      ),
      headlineSmall: textTheme.headlineSmall?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.headlineSmall?.fontSize,
        ),
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.titleLarge?.fontSize,
        ),
        fontWeight: FontWeight.w100,
      ),
      titleMedium: textTheme.titleMedium?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.titleMedium?.fontSize,
        ),
      ),
      titleSmall: textTheme.titleSmall?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.titleSmall?.fontSize,
        ),
      ),
      bodyLarge: textTheme.bodyLarge?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.bodyLarge?.fontSize,
        ),
      ),
      bodyMedium: textTheme.bodyMedium?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.bodyMedium?.fontSize,
        ),
      ),
      bodySmall: textTheme.bodySmall?.copyWith(
        fontSize: Scale.scaleFont(
          textTheme.bodySmall?.fontSize,
        ),
      ),
    ),
  );
}
