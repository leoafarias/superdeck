// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'PALM_API_KEY')
  static const String palmApiKey = _Env.palmApiKey;
}
