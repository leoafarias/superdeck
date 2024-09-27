import 'package:flutter/material.dart';

abstract class SlidePart extends StatefulWidget {
  const SlidePart({
    super.key,
  });

  Widget build(BuildContext context);

  @override
  _SlidePartState<SlidePart> createState() => SlidePartState<SlidePart>();
}

class SlidePartState<T extends SlidePart> extends _SlidePartState<T> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}

class _FixedSlidePartState extends _SlidePartState<FixedSlidePart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Builder(builder: widget.build),
    );
  }
}

abstract class _SlidePartState<T extends SlidePart> extends State<T> {
  @override
  Widget build(BuildContext context);
}

abstract class FixedSlidePart extends SlidePart {
  const FixedSlidePart({super.key});

  double get height;

  @override
  _FixedSlidePartState createState() => _FixedSlidePartState();
}
