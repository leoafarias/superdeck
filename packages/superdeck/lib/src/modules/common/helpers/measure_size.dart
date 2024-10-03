import 'package:flutter/material.dart';

import '../styles/style_spec.dart';
import 'constants.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    super.key,
    required this.onChange,
    required this.child,
  });

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final GlobalKey _widgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    return Container(
      key: _widgetKey,
      child: widget.child,
    );
  }

  void _afterLayout(Duration timeStamp) {
    final context = _widgetKey.currentContext;
    if (context == null) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      widget.onChange(renderBox.size);
    }
  }
}

class SizeLayoutBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Size size) builder;
  final SlideSpec spec;

  const SizeLayoutBuilder({
    super.key,
    required this.builder,
    this.spec = const SlideSpec(),
  });

  @override
  State<SizeLayoutBuilder> createState() => _SizeLayoutBuilderState();
}

class _SizeLayoutBuilderState extends State<SizeLayoutBuilder> {
  Size? _size;
  late final Key _key;

  static final Map<Key, Size> _cacheSizes = {};

  @override
  void initState() {
    super.initState();
    _key = widget.key ?? GlobalKey();
    _size = _cacheSizes[_key];
  }

  void _updateSize(Size size) {
    if (_size != null) return;
    // Ignore invalid sizes
    if (size.width <= 0 ||
        size.height <= 0 ||
        size.width == double.infinity ||
        size.height == double.infinity) {
      return;
    }
    if (_size != null) return;
    if (size != _size) {
      _cacheSizes[_key] = size;

      setState(() {
        _size = size;
        print('SizeLayoutBuilder: $_size');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = _size ?? kResolution;

    return MeasureSize(
      onChange: _updateSize,
      child: widget.builder(context, size),
    );
  }
}
