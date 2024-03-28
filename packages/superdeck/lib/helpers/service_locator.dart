// service_locator.dart
import 'package:get_it/get_it.dart';

import '../controllers/deck_controller.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SuperDeckController>(
    SuperDeckController(),
    dispose: (controller) => controller.dispose(),
  );
  getIt.registerSingleton<StyleController>(StyleController());
}
