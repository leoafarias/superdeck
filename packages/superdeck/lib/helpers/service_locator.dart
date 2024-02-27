// service_locator.dart
import 'package:get_it/get_it.dart';

import '../providers/superdeck_provider.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SuperDeckController>(
    SuperDeckController(),
    dispose: (controller) => controller.dispose(),
  );
}
