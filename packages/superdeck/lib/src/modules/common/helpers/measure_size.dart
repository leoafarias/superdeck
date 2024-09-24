import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size newSize);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;

    if (oldSize != newSize) {
      // Directly invoke the callback with both old and new size during layout
      onChange(newSize);
      oldSize = newSize; // Update the old size to the new size
    }
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
}

class MeasureSizeBuilder extends StatefulWidget {
  final Widget Function(Size size) builder;
  final Duration duration;
  const MeasureSizeBuilder({
    super.key,
    required this.builder,
    required this.duration,
  });

  @override
  State<MeasureSizeBuilder> createState() => _MeasureSizeBuilderState();
}

class _MeasureSizeBuilderState extends State<MeasureSizeBuilder> {
  Size? _size;
  @override
  Widget build(BuildContext context) {
    return MeasureSize(
      onChange: (size) {
        widget.builder(size);
      },
      child: AnimatedSize(
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: LayoutBuilder(
          builder: (context, constraints) {
            Widget current = widget.builder(_size ?? constraints.biggest);

            if (_size != null) {
              current = SizedBox(
                width: _size!.width,
                height: _size!.height,
                child: current,
              );
            }

            return current;
          },
        ),
      ),
    );
  }
}
