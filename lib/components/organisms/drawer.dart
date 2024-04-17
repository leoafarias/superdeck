import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../providers/superdeck_controller.dart';
import '../molecules/slide_thumbnail_list.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    super.key,
    required this.navigation,
  });

  final NavigationProvider navigation;

  @override
  Widget build(BuildContext context) {
    final slides = superDeck.slides.watch(context);
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
                  selectedIndex: navigation.currentScreen.watch(context),
                  onDestinationSelected: navigation.goToScreen,
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
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.play_arrow,
                        size: 20,
                      ),
                      label: Text('Debug'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.code,
                        size: 20,
                      ),
                      label: Text('Save pdf'),
                    ),
                  ],
                ),
                Expanded(
                  child: SlideThumbnailList(
                    currentSlide: navigation.currentSlide.watch(context),
                    onSelect: navigation.goToSlide,
                    slides: slides,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
