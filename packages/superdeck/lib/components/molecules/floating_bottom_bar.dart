import 'package:flutter/material.dart';

import '../../helpers/routes.dart';

class FloatingBottomBar extends StatefulWidget {
  final bool isVisible;
  const FloatingBottomBar({
    super.key,
    required this.isVisible,
  });

  static double height = 60;

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: FloatingBottomBar.height,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.present_to_all),
            onPressed: () => context.toggleDrawer(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.previousSlide(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => context.nextSlide(),
          ),
          Spacer(),
          IconButton(
            onPressed: () => context.closePresenterMenu(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
