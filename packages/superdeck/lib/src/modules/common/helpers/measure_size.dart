import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'constants.dart';

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
      oldSize = newSize;

      onChange(newSize);
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

  @override
  void updateRenderObject(
      BuildContext context, MeasureSizeRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}

class MeasureSizeBuilder extends StatefulWidget {
  final Widget Function(Size? size) builder;

  const MeasureSizeBuilder({
    super.key,
    required this.builder,
  });

  @override
  State<MeasureSizeBuilder> createState() => _MeasureSizeBuilderState();
}

class _MeasureSizeBuilderState extends State<MeasureSizeBuilder> {
  Size? _size;
  late final Key _key;

  static final Map<Key, Size> _cacheSizes = {};

  @override
  void initState() {
    super.initState();
    _key = widget.key ?? UniqueKey();
    _size = _cacheSizes[_key];
  }

  void _onSizeChange(Size size) {
    if (_size != null) return;
    if (size.width <= 0 ||
        size.height <= 0 ||
        size.width == double.infinity ||
        size.height == double.infinity) {
      return;
    }

    if (size == _size) return;
    _cacheSizes[_key] = size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _size = size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.loose(kResolution),
      child: MeasureSize(
        onChange: _onSizeChange,
        child: widget.builder(_size ?? kResolution),
      ),
    );
  }
}
