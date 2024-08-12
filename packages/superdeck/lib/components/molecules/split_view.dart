import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hooks.dart';
import '../../helpers/routes.dart';
import '../../helpers/utils.dart';
import '../atoms/sized_transition.dart';
import 'navigation_rail.dart';
import 'presentation_side_bar.dart';

class SplitView extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const SplitView({
    super.key,
    required this.navigationShell,
  });

  final _maxWidth = 400.0;
  final _thumbnailWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    final sideSize = useState(0.0);

    useEffect(() {
      if (context.isMobileLandscape) {
        sideSize.value = 200.0;
      } else {
        sideSize.value = _maxWidth;
      }
    }, [navigationShell.currentIndex]);

    final animationController = useAnimationController(
      duration: Durations.medium1,
    );

    final animation = useAnimation(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    usePostFrameEffect(() {
      if (context.isDrawerOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }, [context.isDrawerOpen]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final sidebar = switch (navigationShell.currentIndex) {
          0 => SizedBox(
              width: _thumbnailWidth,
              child: const PresentationSideBar(),
            ),
          _ => const SizedBox.shrink(),
        };

        return Row(
          children: [
            SizedTransition(
              sizeFactor: animation,
              child: Row(
                children: [
                  CustomNavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    onDestinationSelected: (value) {
                      navigationShell.goBranch(value);
                    },
                    leading: 20,
                    destinations: [
                      CustomNavigationRailDestination(
                        icon: Icons.view_carousel,
                        label: 'Home',
                      ),
                      if (!kIsWeb)
                        CustomNavigationRailDestination(
                          icon: Icons.settings,
                          label: 'Settings',
                        ),
                    ],
                  ),
                  sidebar
                ],
              ),
            ),
            Expanded(child: navigationShell)
          ],
        );
      },
    );
  }
}
