import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/atoms/slide_view.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}

class SlideConstraintBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Size size) builder;

  const SlideConstraintBuilder({
    super.key,
    required this.builder,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SlideConstraintBuilderState createState() => _SlideConstraintBuilderState();
}

class _SlideConstraintBuilderState extends State<SlideConstraintBuilder> {
  Size? _widgetSize;

  void _onWidgetSizeChange(Size size) {
    setState(() {
      _widgetSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final size = _widgetSize == null ? constraints.biggest : _widgetSize!;
        final constraintSize = BoxConstraints(
          maxHeight: size.height,
          maxWidth: size.width,
        );
        return MeasureSize(
          onChange: _onWidgetSizeChange,
          child: ConstrainedBox(
            constraints: constraintSize,
            child: SlideConstraints(
              constraints: constraintSize,
              child: Builder(
                builder: (BuildContext context) {
                  return widget.builder(context, size);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
