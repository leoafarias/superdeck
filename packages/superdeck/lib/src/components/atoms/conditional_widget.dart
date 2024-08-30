import 'package:flutter/widgets.dart';

class ConditionalWidget extends StatefulWidget {
  final bool condition;
  final Widget child;
  final Widget fallback;

  const ConditionalWidget({
    super.key,
    required this.condition,
    required this.child,
    required this.fallback,
  });

  @override
  _ConditionalWidgetState createState() => _ConditionalWidgetState();
}

class _ConditionalWidgetState extends State<ConditionalWidget> {
  late bool _currentCondition;

  @override
  void initState() {
    super.initState();
    _currentCondition = widget.condition;
  }

  @override
  void didUpdateWidget(covariant ConditionalWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.condition != _currentCondition) {
      _currentCondition = widget.condition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentCondition ? widget.child : widget.fallback;
  }
}
