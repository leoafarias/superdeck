import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/utils.dart';
import '../../superdeck.dart';
import 'slide_thumbnail_list.dart';

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
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late final navigation = NavigationProvider.instance;
  late final superdeck = SDController.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.medium1,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    if (navigation.sideIsOpen.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = superdeck.slides.watch(context);

    navigation.sideIsOpen.listen(context, () {
      if (navigation.sideIsOpen.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    final sideWidth = context.isMobileLandscape ? 200.0 : 400.0;
    const sideHeight = 200.0;
    final currentSlide = navigation.currentSlide.watch(context);
    final sideIsOpen = navigation.sideIsOpen.watch(context);

    final isSmall = context.isSmall;

    final sidePanel = SlideThumbnailList(
      scrollDirection: isSmall ? Axis.horizontal : Axis.vertical,
      currentSlide: currentSlide,
      onSelect: navigation.goToSlide,
      slides: slides,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final animatedWidth = _animation.value * sideWidth;
            final animatedHeight = _animation.value * sideHeight;

            Offset offset;
            if (isSmall) {
              offset = Offset(0, -(animatedHeight - sideHeight));
            } else {
              offset = Offset(animatedWidth - sideWidth, 0);
            }

            EdgeInsets padding;

            if (isSmall) {
              padding = EdgeInsets.only(bottom: animatedHeight);
            } else {
              padding = EdgeInsets.only(left: animatedWidth);
            }

            final panelSize = isSmall ? animatedHeight : animatedWidth;

            Widget drawer = Transform.translate(
              offset: offset,
              child: SizedBox(
                width: isSmall ? null : sideWidth,
                height: isSmall ? sideHeight : null,
                child: sidePanel,
              ),
            );

            // Align at the bottom if its a small screen
            if (isSmall) {
              drawer = Align(
                alignment: Alignment.bottomCenter,
                child: drawer,
              );
            }

            final child = SplitViewProvider(
              panelSize: panelSize,
              isOpen: sideIsOpen,
              size: constraints.biggest,
              child: Padding(
                padding: padding,
                child: widget.child,
              ),
            );

            return Stack(
              children: [child, drawer],
            );
          },
        );
      },
    );
  }
}

enum SplitViewProviderAspect {
  panelSize,
  isOpen,
  size,
}

class SplitViewProvider extends InheritedModel<SplitViewProviderAspect> {
  final double panelSize;
  final bool isOpen;
  final Size size;

  const SplitViewProvider({
    super.key,
    required this.panelSize,
    required this.isOpen,
    required this.size,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant SplitViewProvider oldWidget) {
    return panelSize != oldWidget.panelSize ||
        isOpen != oldWidget.isOpen ||
        size != oldWidget.size;
  }

  @override
  bool updateShouldNotifyDependent(covariant SplitViewProvider oldWidget,
      Set<SplitViewProviderAspect> dependencies) {
    if (dependencies.contains(SplitViewProviderAspect.panelSize) &&
        panelSize != oldWidget.panelSize) {
      return true;
    }
    if (dependencies.contains(SplitViewProviderAspect.isOpen) &&
        isOpen != oldWidget.isOpen) {
      return true;
    }
    if (dependencies.contains(SplitViewProviderAspect.size) &&
        size != oldWidget.size) {
      return true;
    }
    return false;
  }

  static SplitViewProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SplitViewProvider>()!;
  }

  static Size sizeOf(BuildContext context) {
    return SplitViewProvider.of(context).size;
  }

  static double panelSizeOf(BuildContext context) {
    return SplitViewProvider.of(context).panelSize;
  }

  static bool isOpenOf(BuildContext context) {
    return SplitViewProvider.of(context).isOpen;
  }
}
