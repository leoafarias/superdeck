import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hooks.dart';
import '../../helpers/utils.dart';
import '../../superdeck.dart';
import '../atoms/sized_transition.dart';
import 'navigation_rail.dart';
import 'slide_thumbnail_list.dart';

class SplitView extends HookWidget {
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  final _maxWidth = 400.0;

  @override
  Widget build(BuildContext context) {
    final navigation = useNavigation();
    final sideSize = useState(context.isMobileLandscape ? 200.0 : _maxWidth);
    final location = useRouteLocation();

    final locationIndex = switch (location) {
      '/' => 0,
      '/export' => 1,
      '/settings' => 2,
      _ => 0,
    };

    final animationController = useAnimationController(
      duration: Durations.medium1,
    );

    final animation = useAnimation(CurvedAnimation(
      parent: animationController,
      curve: Curves.ease,
    ));

    usePostFrameEffect(() {
      if (navigation.sideIsOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    }, [navigation.sideIsOpen]);

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
                    selectedIndex: locationIndex,
                    onDestinationSelected: (value) {
                      return switch (value) {
                        0 => context.go('/'),
                        1 => context.push('/export'),
                        2 => context.go('/settings'),
                        _ => null,
                      };
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
                      CustomNavigationRailDestination(
                        icon: Icons.settings,
                        label: 'Settings',
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SlideThumbnailList(),
                  ),
                ],
              ),
            ),
          ),
        );

        final current = Padding(
          padding: padding,
          child: Padding(
            padding: EdgeInsets.all(20 * animation),
            child: child,
          ),
        );

        return Stack(
          children: [current, drawer],
        );
      },
    );
  }
}
