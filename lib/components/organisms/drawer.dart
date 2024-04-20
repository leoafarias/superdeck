import 'package:flutter/material.dart';

import '../../providers/sd_provider.dart';

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
    required this.currentIndex,
    this.onTap,
    required this.side,
    this.navigationRailWidth = 80,
  });

  final int currentIndex;
  final Widget side;
  final void Function(int)? onTap;
  final double navigationRailWidth;

  final navigation = NavigationProvider.instance;
  final superdeck = SuperDeckProvider.instance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              scrolledUnderElevation: 10,
              elevation: 4,
              toolbarHeight: 30,
            ),
            body: Row(
              children: [
                NavigationRail(
                  extended: false,
                  selectedIndex: currentIndex,
                  onDestinationSelected: onTap,
                  minWidth: navigationRailWidth - 1,
                  trailing: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Add your leading widget here
                        // For example:
                        Text(
                          'SD',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white.withOpacity(0.2),
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                  labelType: NavigationRailLabelType.none,
                  destinations: SideMenu.values.map(
                    (e) {
                      return NavigationRailDestination(
                        icon: Icon(e.icon, size: 20),
                        label: Text(e.label),
                      );
                    },
                  ).toList(),
                ),
                side,
              ],
            ),
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}
