import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mix/mix.dart';

import '../remix/button.dart';

class CustomNavigationRail extends HookWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final List<CustomNavigationRailDestination> destinations;
  final bool displayLabel;
  final double? leading;
  final double? trailing;

  CustomNavigationRail({
    required this.selectedIndex,
    this.onDestinationSelected,
    required this.destinations,
    this.displayLabel = false,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final _buildDestination = useCallback((int index) {
      final destination = destinations[index];
      final isSelected = selectedIndex == index;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SDIconButton(
          icon: destination.icon,
          onPressed: () => onDestinationSelected?.call(index),
          selected: isSelected,
        ),
      );
    }, [selectedIndex, destinations]);

    return VBox(
      style: _containerStyle,
      children: [
        if (leading != null) SizedBox(height: leading),
        for (int i = 0; i < destinations.length; i++) _buildDestination(i),
        if (trailing != null) SizedBox(height: trailing),
      ],
    );
  }
}

get _containerStyle => Style(
      $box.color.black(),
      $box.padding(16),
      $box.border.right(
        color: Colors.white10,
        width: 1,
      ),
    );

class CustomNavigationRailDestination {
  final IconData icon;
  final String label;

  CustomNavigationRailDestination({
    required this.icon,
    required this.label,
  });
}
