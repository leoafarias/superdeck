import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

class MeasureSingleWidgetSize extends StatefulWidget {
  final Widget child;
  final void Function(Size) onChange;

  const MeasureSingleWidgetSize(
      {super.key, required this.child, required this.onChange});

  @override
  _MeasureSingleWidgetSizeState createState() =>
      _MeasureSingleWidgetSizeState();
}

class _MeasureSingleWidgetSizeState extends State<MeasureSingleWidgetSize> {
  final GlobalKey _childKey = GlobalKey();
  Size? _size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_measureHeight);
  }

  void _measureHeight(Duration _) async {
    if (!_checkIfSizeIsZero(_size)) {
      return;
    }
    print('measuring height');
    final renderBox =
        _childKey.currentContext?.findRenderObject() as RenderBox?;
    final size = renderBox?.size;

    if (_checkIfSizeIsZero(size)) {
      WidgetsBinding.instance.addPostFrameCallback(_measureHeight);
      return;
    }

    _size = size;

    widget.onChange(_size!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _childKey,
      child: widget.child,
    );
  }
}

bool _checkIfSizeIsZero(Size? size) {
  return size == null ||
      size == Size.zero ||
      size.height == 0 ||
      size.width == 0;
}
