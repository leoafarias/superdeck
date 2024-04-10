import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  final List<Widget> children;
  final PageController controller;

  const CustomPageView({
    super.key,
    required this.children,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: children.length,
      pageSnapping: true,
      physics: const CustomPageViewScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: children[index],
        );
      },
    );
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({super.parent});

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
