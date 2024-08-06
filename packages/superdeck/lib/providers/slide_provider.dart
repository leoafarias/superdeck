// Create a SlideProvider that extends an Inherited widget
import 'package:flutter/material.dart';

import '../helpers/measure_size.dart';
import '../models/slide_model.dart';
import '../templates/templates.dart';

enum SlideProviderAspect {
  slide,
  constraints,
}

class SlideProvider<T extends Slide> extends InheritedWidget {
  const SlideProvider({
    super.key,
    required this.slide,
    required super.child,
  });

  final T slide;

  static T of<T extends Slide>(BuildContext context) {
    final slideProvider =
        context.dependOnInheritedWidgetOfExactType<SlideProvider<T>>();
    if (slideProvider == null) {
      throw Exception('SlideProvider not found in context');
    }
    return slideProvider.slide;
  }

  @override
  bool updateShouldNotify(covariant SlideProvider<T> oldWidget) {
    return oldWidget.slide != slide;
  }
}

class SlideBuilder extends StatelessWidget {
  const SlideBuilder(
    this.config, {
    super.key,
  });

  final Slide config;

  @override
  Widget build(BuildContext context) {
    return SlideProvider(
      slide: config,
      child: SlideConstraints(
        child: TemplateBuilder.buildTemplate(config),
      ),
    );
  }
}

class SlideConstraints extends StatefulWidget {
  final Widget child;
  const SlideConstraints({
    super.key,
    required this.child,
  });

  static BoxConstraints of(BuildContext context) {
    final slideConstraints =
        context.dependOnInheritedWidgetOfExactType<_SlideConstraintsProvider>();
    if (slideConstraints == null) {
      throw Exception('SlideConstraints not found in context');
    }
    return slideConstraints.constraints;
  }

  @override
  State createState() => _SlideConstraintsState();
}

class _SlideConstraintsState extends State<SlideConstraints> {
  Size? _widgetSize;

  void _onWidgetSizeChange(Size size) {
    setState(() {
      _widgetSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints layout,
      ) {
        final size = _widgetSize == null ? layout.biggest : _widgetSize!;
        final constraints = BoxConstraints(
          maxHeight: size.height,
          maxWidth: size.width,
        );
        return MeasureSize(
          onChange: _onWidgetSizeChange,
          child: _SlideConstraintsProvider(
            constraints: constraints,
            child: ConstrainedBox(
              constraints: constraints,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

class _SlideConstraintsProvider extends InheritedWidget {
  const _SlideConstraintsProvider({
    required this.constraints,
    required super.child,
  });

  final BoxConstraints constraints;

  @override
  bool updateShouldNotify(_SlideConstraintsProvider oldWidget) {
    return oldWidget.constraints != constraints;
  }
}
