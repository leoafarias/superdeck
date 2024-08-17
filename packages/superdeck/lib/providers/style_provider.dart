import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

import '../styles/style_util.dart';

class StyleProvider extends InheritedWidget {
  StyleProvider({
    super.key,
    Style? baseStyle,
    this.styles = const <String, Style>{},
    required super.child,
  }) : style = defaultStyle.merge(baseStyle);

  final Style style;
  final Map<String, Style> styles;

  static StyleProvider _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleProvider>()!;
  }

  static Style of(BuildContext context, String? styleName) {
    final provider = _of(context);
    if (styleName != null) {
      final style = provider.styles[styleName];
      assert(style != null, 'No Style for $styleName found.');
      return provider.style.merge(style);
    }
    return _of(context).style;
  }

  static StyleProvider inherit({
    required BuildContext context,
    required Widget child,
  }) {
    return StyleProvider(
      baseStyle: _of(context).style,
      styles: _of(context).styles,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(covariant StyleProvider oldWidget) {
    return style != oldWidget.style;
  }
}
