import 'package:flutter/material.dart';

import '../../superdeck.dart';

// ignore: non_constant_identifier_names
final SlidePreviewBox = Style(
  box.color.grey.shade900(),
  box.margin.all(8),
  box.maxHeight(140),
  box.shadow(
    color: Colors.black.withOpacity(0.5),
    blurRadius: 4,
    spreadRadius: 1,
  ),
).box;

class SplitView extends StatefulWidget {
  final Widget side;

  final double sideWidth;
  final bool isOpen;
  final Widget Function(({double sideWidth, Size size})) builder;

  const SplitView({
    super.key,
    required this.side,
    this.sideWidth = 300,
    this.isOpen = false,
    required this.builder,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    if (widget.isOpen) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant SplitView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final animatedWidth = _animation.value * widget.sideWidth;

            return Stack(
              children: [
                widget.builder((
                  sideWidth: animatedWidth,
                  size: constraints.biggest,
                )),
                Transform.translate(
                  offset: Offset(animatedWidth - widget.sideWidth, 0),
                  child: SizedBox(
                    width: widget.sideWidth,
                    child: widget.side,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
