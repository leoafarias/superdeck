import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../helpers/hooks.dart';
import '../../providers/controller.dart';
import '../atoms/slide_thumbnail.dart';

class SlideThumbnailList extends HookWidget {
  const SlideThumbnailList({
    super.key,
    required this.scrollDirection,
  });

  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();
    final currentSlide = navigation.currentSlide;
    final slides = useSlides();
    final (:visibleItems, :itemScrollController, :itemPositionsListener) =
        useScrollControllerWithVisibleItems();

    useLayoutEffect(() {
      if (visibleItems.isEmpty) return;
      const duration = Duration(milliseconds: 300);
      const curve = Curves.easeInOutCubic;

      final visibleItem =
          visibleItems.firstWhereOrNull((e) => e.index == currentSlide);

      double alignment;

      if (visibleItem == null) {
        final isBeginning = visibleItems.first.index > currentSlide;

        alignment = isBeginning ? 0 : 0.75;
      } else {
        if (visibleItem.itemTrailingEdge > 1) {
          final totalSpace =
              visibleItem.itemTrailingEdge - visibleItem.itemLeadingEdge;
          alignment = 1 - totalSpace;
        } else if (visibleItem.itemLeadingEdge < 0) {
          alignment = 0;
        } else {
          alignment = visibleItem.itemLeadingEdge;
        }
      }
      itemScrollController.scrollTo(
        index: currentSlide,
        alignment: alignment,
        duration: duration,
        curve: curve,
      );

      return;
    }, [currentSlide, slides]);

    return Container(
      color: const Color.fromARGB(108, 0, 0, 0),
      child: ScrollablePositionedList.builder(
          scrollDirection: scrollDirection,
          itemCount: slides.length,
          itemPositionsListener: itemPositionsListener,
          itemScrollController: itemScrollController,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, idx) {
            return SlideThumbnail(
              index: idx,
              onTap: () => navigation.goToSlide(idx),
              slide: slides[idx],
            );
          }),
    );
  }
}
