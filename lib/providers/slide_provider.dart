// Create a SlideProvider that extends an Inherited widget
import 'package:flutter/material.dart';

import '../helpers/measure_size.dart';
import '../helpers/template_builder.dart';
import '../models/asset_model.dart';
import '../models/options_model.dart';
import '../models/slide_model.dart';
import '../styles/style_spec.dart';

enum SlideProviderAspect {
  slide,
  spec,
  isSnapshot,
  examples,
  assets,
  constraints,
}

class SlideModel<T extends Slide> extends InheritedModel<SlideProviderAspect> {
  final T config;
  final SlideSpec spec;
  final BoxConstraints constraints;
  // If slide is a snapshot for image generation
  final bool isSnapshot;
  final Map<String, ExampleBuilder> examples;
  final List<SlideAsset> assets;

  const SlideModel({
    super.key,
    required this.config,
    required this.spec,
    required this.constraints,
    required this.isSnapshot,
    required this.examples,
    required this.assets,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant SlideModel oldWidget) {
    return config != oldWidget.config || spec != oldWidget.spec;
  }

  static SlideModel of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SlideModel>()!;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant SlideModel oldWidget,
    Set<SlideProviderAspect> dependencies,
  ) {
    if (dependencies.contains(SlideProviderAspect.slide) &&
        config != oldWidget.config) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.spec) &&
        spec != oldWidget.spec) {
      return true;
    }

    if (dependencies.contains(SlideProviderAspect.isSnapshot) &&
        isSnapshot != oldWidget.isSnapshot) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.examples) &&
        examples != oldWidget.examples) {
      return true;
    }
    if (dependencies.contains(SlideProviderAspect.assets) &&
        assets != oldWidget.assets) {
      return true;
    }
    return false;
  }

  static Slide slideOf(BuildContext context) {
    return SlideModel.of(context).config;
  }

  static SlideSpec specOf(BuildContext context) {
    return SlideModel.of(context).spec;
  }

  static bool isSnapshotOf(BuildContext context) {
    return SlideModel.of(context).isSnapshot;
  }

  static List<SlideAsset> assetsOf(BuildContext context) {
    return SlideModel.of(context).assets;
  }

// TODO: only get notified if the individual example changes
  static Map<String, ExampleBuilder> examplesOf(BuildContext context) {
    return SlideModel.of(context).examples;
  }

  static BoxConstraints constraintsOf(BuildContext context) {
    return SlideModel.of(context).constraints;
  }
}

class SlideBuilder<T extends Slide> extends StatelessWidget {
  final TemplateBuilder<T> Function(SlideModel<T>) builder;
  const SlideBuilder({
    super.key,
    required this.builder,
    required this.config,
    required this.spec,
    required this.isSnapshot,
    required this.examples,
    required this.assets,
  });

  final T config;
  final SlideSpec spec;

  // If slide is a snapshot for image generation
  final bool isSnapshot;
  final Map<String, ExampleBuilder> examples;
  final List<SlideAsset> assets;

  @override
  Widget build(BuildContext context) {
    return SlideConstraints(
      child: Builder(builder: (context) {
        return SlideModel(
          constraints: SlideConstraints.of(context),
          config: config,
          spec: spec,
          isSnapshot: isSnapshot,
          examples: examples,
          assets: assets,
          child: Builder(
            builder: (context) {
              return builder(SlideModel.of<T>(context));
            },
          ),
        );
      }),
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
        BoxConstraints constraints,
      ) {
        final size = _widgetSize == null ? constraints.biggest : _widgetSize!;

        return MeasureSize(
          onChange: _onWidgetSizeChange,
          child: _SlideConstraintsProvider(
            constraints: BoxConstraints(
              maxHeight: size.height,
              maxWidth: size.width,
            ),
            child: widget.child,
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
