import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/utils.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../atoms/slide_thumbnail.dart';

class SlideThumbnailList extends StatefulWidget {
  const SlideThumbnailList({
    super.key,
    required this.slides,
    required this.currentSlide,
    required this.onSelect,
    required this.scrollDirection,
  });

  final List<Slide> slides;
  final int currentSlide;
  final void Function(int) onSelect;
  final Axis scrollDirection;

  @override
  State<SlideThumbnailList> createState() => _SlideThumbnailListState();
}

class _SlideThumbnailListState extends State<SlideThumbnailList> {
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();

  var _visibleItems = <ItemPosition>[];

  Future<void> goToPage(int page, {bool animate = true}) async {
    if (page < 0 || page >= widget.slides.length) return;

    const duration = Duration(milliseconds: 300);
    const curve = Curves.easeInOutCubic;

    final visibleItem = _visibleItems.firstWhereOrNull((e) => e.index == page);

    double alignment;

    if (visibleItem == null) {
      final isBeginning = _visibleItems.first.index > page;

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
    _itemScrollController.scrollTo(
      index: page,
      alignment: alignment,
      duration: duration,
      curve: curve,
    );

    widget.onSelect(page);
  }

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(() {
      _visibleItems = _itemPositionsListener.itemPositions.value.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = SuperDeckProvider.instance.style.watch(context);
    return Container(
      color: const Color.fromARGB(108, 0, 0, 0),
      child: ScrollablePositionedList.builder(
          scrollDirection: widget.scrollDirection,
          itemCount: widget.slides.length,
          itemPositionsListener: _itemPositionsListener,
          itemScrollController: _itemScrollController,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, idx) {
            final slide = widget.slides[idx];

            final variant = slide.styleVariant;

            final slideStyle = style.applyVariant(variant);
            final key = md5Hash(slideStyle.toString() + slide.hashKey);

            return SlideThumbnail(
              key: Key(key),
              cacheKey: key,
              selected: idx == widget.currentSlide,
              onTap: () => goToPage(idx),
              slide: slide,
            );
          }),
    );
  }
}
