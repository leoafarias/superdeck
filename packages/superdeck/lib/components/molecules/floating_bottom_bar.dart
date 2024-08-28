import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../helpers/routes.dart';

class FloatingBottomBar extends StatefulWidget {
  const FloatingBottomBar({
    super.key,
  });

  static double height = 80;

  @override
  State<FloatingBottomBar> createState() => _FloatingBottomBarState();
}

class _FloatingBottomBarState extends State<FloatingBottomBar> {
  @override
  Widget build(BuildContext context) {
    final isDrawerOpen = context.isDrawerOpen;
    return Container(
      height: FloatingBottomBar.height,
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      width: MediaQuery.sizeOf(context).width,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            decoration: BoxDecoration(
              color: const Color.fromARGB(171, 0, 0, 0),
              border: const Border(
                top: BorderSide(
                  color: Colors.white10,
                  width: 1,
                ),
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isDrawerOpen
                        ? Symbols.left_panel_close
                        : Symbols.left_panel_open,
                  ),
                  onPressed: () => context.toggleDrawer(),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.previousSlide(),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => context.nextSlide(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => context.closePresenterMenu(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
