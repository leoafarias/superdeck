import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../helpers/hooks.dart';
import '../../helpers/utils.dart';
import '../../providers/controller.dart';
import '../atoms/slide_thumbnail.dart';

class SlideThumbnailList extends HookWidget {
  const SlideThumbnailList({
    super.key,
  });

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();
    final currentPage = navigation.page;
    final slides = useSlides();
    final controller = useScrollVisibleController();
    final visibleItems = controller.visibleItems;

    usePostFrameEffect(() {
      if (visibleItems.isEmpty) return;

      final visibleItem =
          visibleItems.firstWhereOrNull((e) => e.index == currentPage);

      double alignment;

      if (visibleItem == null) {
        final isBeginning = visibleItems.first.index > currentPage;

        alignment = isBeginning ? 0 : 0.7;
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
      controller.itemScrollController.scrollTo(
        index: currentPage,
        alignment: alignment,
        duration: _duration,
        curve: _curve,
      );

      return;
    }, [currentPage, slides]);

    return Container(
      color: Colors.black,
      child: ScrollablePositionedList.builder(
          scrollDirection: context.isSmall ? Axis.horizontal : Axis.vertical,
          itemCount: slides.length,
          itemPositionsListener: controller.itemPositionsListener,
          itemScrollController: controller.itemScrollController,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: SlideThumbnail(
                page: index + 1,
                selected: currentPage == index,
                onTap: () => navigation.goToPage(index),
                slide: slides[index],
              ),
            );
          }),
    );
  }
}
