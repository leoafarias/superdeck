import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hooks.dart';
import '../../helpers/routes.dart';
import '../../helpers/utils.dart';
import '../atoms/sized_transition.dart';
import 'navigation_rail.dart';
import 'slide_thumbnail_list.dart';

class SplitView extends HookWidget {
  final StatefulNavigationShell navigationShell;

  const SplitView({
    super.key,
    required this.navigationShell,
  });

  final _maxWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    final sideSize = useState(0.0);

    useEffect(() {
      if (context.isMobileLandscape) {
        sideSize.value = 200.0;
      } else {
        navigationShell.currentIndex == 0
            ? sideSize.value = _maxWidth
            : sideSize.value = _maxWidth - 300;
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

    const sideHeight = 200.0;

    final isSmall = context.isSmall || context.isMobileLandscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        final animatedWidth = animation * sideSize.value;
        final animatedHeight = animation * sideHeight;

        EdgeInsets padding;
        if (isSmall) {
          padding = EdgeInsets.only(bottom: animatedHeight);
        } else {
          padding = EdgeInsets.only(left: animatedWidth);
        }

        final drawer = Align(
          alignment: isSmall ? Alignment.bottomCenter : Alignment.centerLeft,
          child: SizedTransition(
            sizeFactor: animation,
            child: SizedBox(
              width: isSmall ? null : sideSize.value,
              height: isSmall ? sideHeight : null,
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
                      CustomNavigationRailDestination(
                        icon: Icons.save_alt,
                        label: 'Export',
                      ),
                    ],
                  ),
                  navigationShell.currentIndex == 0
                      ? const SizedBox(
                          width: 300,
                          child: SlideThumbnailList(),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );

        final current = Padding(
          padding: padding,
          child: Padding(
            padding: EdgeInsets.all(20 * animation),
            child: navigationShell,
          ),
        );

        return Stack(
          children: [current, drawer],
        );
      },
    );
  }
}
