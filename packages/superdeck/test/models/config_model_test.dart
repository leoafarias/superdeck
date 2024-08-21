import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck_core/superdeck_core.dart';

void main() {
  group('Config', () {
    test('fromMap should create Config instance from map', () {
      final map = {
        'background': 'bg.jpg',
        'style': 'dark',
        'transition': {'type': 'fade_in_down_big', 'duration': 500},
        'cache_remote_assets': true,
      };

      final config = Config.fromMap(map);

      expect(config.background, 'bg.jpg');
      expect(config.style, 'dark');
      expect(config.transition?.type, TransitionType.fadeInDownBig);
      expect(config.transition?.duration, const Duration(milliseconds: 500));
      expect(config.cacheRemoteAssets, true);
    });

    test('fromJson should create Config instance from JSON string', () {
      const json =
          '{"background":"bg.jpg","style":"light","transition":{"type":"slide_in_right","duration":1000},"cache_remote_assets":false}';

      final config = Config.fromJson(json);

      expect(config.background, 'bg.jpg');
      expect(config.style, 'light');
      expect(config.transition?.type, TransitionType.slideInRight);
      expect(config.transition?.duration, const Duration(seconds: 1));
      expect(config.cacheRemoteAssets, false);
    });
  });
}
