import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'superdeck.dart';

ThemeData darkTheme = _createTheme(Brightness.dark).copyWith(
  // backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
);

ThemeData lightTheme = _createTheme(Brightness.light);

ThemeData _createTheme(Brightness brightness) {
  final baseTheme = brightness == Brightness.dark
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);

  final fontColor = brightness == Brightness.dark ? Colors.white : Colors.black;
  final fadedColor = fontColor.withOpacity(0.8);

  final displayTT = GoogleFonts.robotoTextTheme(baseTheme.textTheme);
  final headlineTT = GoogleFonts.robotoTextTheme(baseTheme.textTheme);
  final bodyTT = GoogleFonts.robotoTextTheme();

  return baseTheme.copyWith(
    textTheme: baseTheme.textTheme.copyWith(
      displayLarge: displayTT.displayLarge?.copyWith(color: fontColor),
      displayMedium: displayTT.displayMedium?.copyWith(color: fontColor),
      displaySmall: displayTT.displaySmall?.copyWith(color: fontColor),
      headlineLarge: headlineTT.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: fontColor,
      ),
      headlineMedium: headlineTT.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: fontColor,
      ),
      headlineSmall: headlineTT.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: fontColor,
      ),
      bodySmall: bodyTT.bodyLarge?.copyWith(
        fontSize: 20,
        color: fadedColor,
      ),
      bodyMedium: bodyTT.bodyMedium?.copyWith(
        fontSize: 22,
        color: fadedColor,
      ),
      bodyLarge: bodyTT.bodyLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w100,
        height: 1.4,
        color: fadedColor,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

class DeckStyle extends InheritedModel<Style> {
  final Style style;

  const DeckStyle({
    required this.style,
    required super.child,
    super.key,
  });

  static Style of(BuildContext context) {
    final DeckStyle? result =
        context.dependOnInheritedWidgetOfExactType<DeckStyle>();
    assert(result != null, 'No DeckTheme found in context');
    return result!.style;
  }

  @override
  bool updateShouldNotify(covariant DeckStyle oldWidget) {
    return style != oldWidget.style;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant DeckStyle oldWidget, Set<Style> dependencies) {
    return style != oldWidget.style;
  }
}
