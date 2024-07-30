import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/models/config_model.dart';
import 'package:superdeck/superdeck.dart';

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

    test('fromYaml should create Config instance from YAML string', () {
      const yaml = '''
background: bg.png
style: custom
transition:
  type: zoom_in
  duration: 750
cache_remote_assets: true
''';

      final config = Config.fromYaml(yaml);

      expect(config.background, 'bg.png');
      expect(config.style, 'custom');
      expect(config.transition?.type, TransitionType.zoomIn);
      expect(config.transition?.duration, const Duration(milliseconds: 750));
      expect(config.cacheRemoteAssets, true);
    });

    test('load should create Config instance from file', () async {
      final file = File('test/fixtures/empty_config.yml');
      final config = await Config.load(file);

      expect(config.background, isNull);
      expect(config.style, isNull);
      expect(config.transition?.type, isNull);
      expect(config.transition?.duration, isNull);
      expect(config.cacheRemoteAssets, isNull);
    });

    test('load should create Config instance from file', () async {
      final file = File('test/fixtures/complete_config.yml');
      final config = await Config.load(file);

      expect(config.background, 'background.jpg');
      expect(config.style, 'custom');
      expect(config.transition?.type, TransitionType.fadeIn);
      expect(config.transition?.duration, const Duration(milliseconds: 500));
      expect(config.transition?.curve, CurveType.easeInOut);
      expect(config.transition?.delay, const Duration(milliseconds: 300));
    });
  });
}
