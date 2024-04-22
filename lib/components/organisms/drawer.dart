import 'package:flutter/material.dart';

import '../../superdeck.dart';

enum SideMenu {
  preview(icon: Icons.play_arrow, label: 'Preview'),
  export(icon: Icons.save, label: 'Export');

  const SideMenu({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class SideDrawer extends StatelessWidget {
  SideDrawer({
    super.key,
    this.onTap,
    required this.side,
  });

  final Widget side;
  final void Function(int)? onTap;

  final navigation = NavigationProvider.instance;
  final superdeck = SuperDeckProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: side),
        VerticalDivider(
          width: 1,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}
