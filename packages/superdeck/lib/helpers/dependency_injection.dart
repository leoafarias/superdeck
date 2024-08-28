import 'package:get_it/get_it.dart';

import '../services/reference_service.dart';
import '../superdeck.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  getIt.registerSingleton(SuperDeckController(
    ReferenceService(),
  ));
}
