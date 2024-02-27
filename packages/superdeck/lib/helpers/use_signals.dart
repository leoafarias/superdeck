import 'package:flutter/widgets.dart';
import 'package:signals_flutter/signals_flutter.dart';

Signal<PageController> createPageController() {
  final controller = PageController();
  final value = signal(controller);

  value.onDispose(() {
    print('disposing page controller');
    controller.dispose();
  });

  return value;
}
