import 'package:flutter_hooks/flutter_hooks.dart';

void useOnMounted(void Function()? Function() effect) {
  useEffect(effect, []);
}
