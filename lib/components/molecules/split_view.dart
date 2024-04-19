import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../superdeck.dart';
import '../organisms/drawer.dart';
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
  final double sideWidth;

  final Widget child;
  final int currentIndex;
  final Function(int) onIndexChange;

  const SplitView({
    super.key,
    this.sideWidth = 400,
    required this.child,
    required this.currentIndex,
    required this.onIndexChange,
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
  late final superdeck = SuperDeckProvider.instance;

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

    final isPreview = widget.currentIndex == SideMenu.preview.index;

    final sideWidth = (isPreview ? widget.sideWidth : 80.0);
    final currentSlide = navigation.currentSlide.watch(context);

    final sidePanel = Expanded(
      child: SlideThumbnailList(
        currentSlide: currentSlide,
        onSelect: navigation.goToSlide,
        slides: slides,
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final animatedWidth = _animation.value * sideWidth;

            return Stack(
              children: [
                SplitViewProvider(
                  sideWidth: animatedWidth,
                  isOpen: navigation.sideIsOpen.watch(context),
                  size: constraints.biggest,
                  child: Padding(
                    padding: EdgeInsets.only(left: animatedWidth),
                    child: widget.child,
                  ),
                ),
                Transform.translate(
                  offset: Offset(animatedWidth - sideWidth, 0),
                  child: SizedBox(
                    width: sideWidth,
                    child: SideDrawer(
                      currentIndex: widget.currentIndex,
                      onTap: widget.onIndexChange,
                      side: isPreview ? sidePanel : const SizedBox.shrink(),
                    ),
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

enum SplitViewProviderAspect {
  sideWidth,
  isOpen,
  size,
}

class SplitViewProvider extends InheritedModel<SplitViewProviderAspect> {
  final double sideWidth;
  final bool isOpen;
  final Size size;

  const SplitViewProvider({
    super.key,
    required this.sideWidth,
    required this.isOpen,
    required this.size,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant SplitViewProvider oldWidget) {
    return sideWidth != oldWidget.sideWidth ||
        isOpen != oldWidget.isOpen ||
        size != oldWidget.size;
  }

  @override
  bool updateShouldNotifyDependent(covariant SplitViewProvider oldWidget,
      Set<SplitViewProviderAspect> dependencies) {
    if (dependencies.contains(SplitViewProviderAspect.sideWidth) &&
        sideWidth != oldWidget.sideWidth) {
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

  static double sideWidthOf(BuildContext context) {
    return SplitViewProvider.of(context).sideWidth;
  }

  static bool isOpenOf(BuildContext context) {
    return SplitViewProvider.of(context).isOpen;
  }
}
