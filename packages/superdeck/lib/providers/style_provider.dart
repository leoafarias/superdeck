import 'package:flutter/widgets.dart';

import '../styles/style_util.dart';
import '../superdeck.dart';

class StyleProvider extends InheritedWidget {
  StyleProvider({
    super.key,
    required Style style,
    required super.child,
  }) : style = defaultStyle.merge(style);

  final Style style;

  static Style of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleProvider>()!.style;
  }

  @override
  bool updateShouldNotify(covariant StyleProvider oldWidget) {
    return style != oldWidget.style;
  }
}
