import 'package:flutter/material.dart';

import '../../superdeck.dart';
import 'scaled_app.dart';

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
  final Widget body;
  final double sideWidth;
  final bool isOpen;

  const SplitView({
    super.key,
    required this.side,
    required this.body,
    this.sideWidth = 300,
    this.isOpen = false,
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
        final size = constraints.biggest;

        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final animatedWidth = _animation.value * widget.sideWidth;
            final paddingSize = animatedWidth / 20;

            final rightWidth = size.width - animatedWidth;
            final rightHeight = size.height * (rightWidth / size.width);
            final rightSize = Size(rightWidth - (paddingSize * 2), rightHeight);

            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: animatedWidth),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tight(rightSize),
                        child: Container(
                          margin: EdgeInsets.all(paddingSize),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: ScaledWidget(child: widget.body),
                        ),
                      ),
                    ),
                  ),
                ),
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
