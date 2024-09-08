import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck_core/superdeck_core.dart';

void main() {
  group('ContentOptions', () {
    test('merge returns original instance when other is null', () {
      const options = BlockOptions();
      expect(options.merge(null), same(options));
    });

    test('merge returns new instance with merged values', () {
      const options1 = BlockOptions(flex: 2, align: ContentAlignment.topLeft);
      const options2 = BlockOptions(align: ContentAlignment.bottomRight);
      final merged = options1.merge(options2);
      expect(merged.flex, options1.flex);
      expect(merged.align, options2.align);
    });
  });

  group('ImageOptions', () {
    test('constructor sets properties correctly', () {
      const options = ImageOptions(
          src: 'image.png',
          fit: ImageFit.cover,
          flex: 3,
          align: ContentAlignment.center);
      expect(options.src, 'image.png');
      expect(options.fit, ImageFit.cover);
      expect(options.flex, 3);
      expect(options.align, ContentAlignment.center);
    });
  });

  group('WidgetOptions', () {
    test('constructor sets properties correctly', () {
      const options = WidgetOptions(
        name: 'MyWidget',
        args: {'key': 'value'},
        flex: 2,
        align: ContentAlignment.topCenter,
      );
      expect(options.name, 'MyWidget');
      expect(options.args, {'key': 'value'});
      expect(options.flex, 2);
      expect(options.align, ContentAlignment.topCenter);
    });
  });

  group('TransitionOptions', () {
    test('merge returns original instance when other is null', () {
      const options = TransitionOptions(type: TransitionType.fadeIn);
      expect(options.merge(null), same(options));
    });

    test('merge returns new instance with merged values', () {
      const options1 = TransitionOptions(
        type: TransitionType.fadeIn,
        duration: Duration(seconds: 1),
        delay: Duration(milliseconds: 500),
        curve: CurveType.easeIn,
      );
      const options2 = TransitionOptions(
        type: TransitionType.fadeOut,
        duration: Duration(seconds: 2),
      );
      final merged = options1.merge(options2);
      expect(merged.type, options2.type);
      expect(merged.duration, options2.duration);
      expect(merged.delay, options1.delay);
      expect(merged.curve, options1.curve);
    });

    test('totalAnimationDuration returns sum of duration and delay', () {
      const options = TransitionOptions(
        type: TransitionType.fadeIn,
        duration: Duration(seconds: 1),
        delay: Duration(milliseconds: 500),
      );
      expect(
          options.totalAnimationDuration, const Duration(milliseconds: 1500));
    });
  });
}
