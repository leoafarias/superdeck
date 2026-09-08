import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Records the mount lifecycle of one widget inside a capture subtree.
class _LifecycleRecord {
  var mounted = false;
  var disposed = false;
}

class _LifecycleWidget extends StatefulWidget {
  final _LifecycleRecord record;
  final bool trackReadiness;
  final bool failBuild;

  const _LifecycleWidget({
    required this.record,
    this.trackReadiness = false,
    this.failBuild = false,
  });

  @override
  State<_LifecycleWidget> createState() => _LifecycleWidgetState();
}

class _LifecycleWidgetState extends State<_LifecycleWidget> {
  SlideCaptureReadinessHandle? _readiness;

  @override
  void initState() {
    super.initState();
    widget.record.mounted = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.trackReadiness) {
      _readiness ??= SlideCaptureReadiness.track(
        context,
        label: 'teardown-test-widget',
      );
    }
  }

  @override
  void dispose() {
    widget.record.disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.failBuild) {
      throw StateError('captured widget failed to build');
    }

    return const SizedBox.expand();
  }
}

SlideConfiguration _lifecycleSlide(
  _LifecycleRecord record, {
  bool trackReadiness = false,
  bool failBuild = false,
}) {
  return SlideConfiguration(
    slideIndex: 0,
    style: SlideStyler(),
    slide: Slide(
      key: 'lifecycle',
      sections: [
        SectionBlock([WidgetBlock(name: 'lifecycle', args: const {})]),
      ],
    ),
    widgets: {
      'lifecycle': (_) => _LifecycleWidget(
        record: record,
        trackReadiness: trackReadiness,
        failBuild: failBuild,
      ),
    },
    thumbnailKey: 'thumbnail_lifecycle.png',
  );
}

Future<BuildContext> _pumpContext(WidgetTester tester) async {
  final key = GlobalKey();
  await tester.pumpWidget(MaterialApp(home: SizedBox(key: key)));

  return key.currentContext!;
}

void main() {
  group('Slide capture teardown', () {
    testWidgets('unmounts the capture subtree after a successful capture', (
      tester,
    ) async {
      final context = await _pumpContext(tester);
      final record = _LifecycleRecord();

      await tester.runAsync(() async {
        final bytes = await SlideCaptureService().capture(
          slide: _lifecycleSlide(record),
          context: context,
        );

        expect(bytes, isNotEmpty);
      });

      expect(record.mounted, isTrue);
      expect(record.disposed, isTrue);
    });

    testWidgets('unmounts the capture subtree after the settle limit', (
      tester,
    ) async {
      final context = await _pumpContext(tester);
      final record = _LifecycleRecord();

      await tester.runAsync(() async {
        final bytes = await SlideCaptureService().capture(
          slide: _lifecycleSlide(record, trackReadiness: true),
          context: context,
        );

        expect(bytes, isNotEmpty);
      });

      expect(record.mounted, isTrue);
      expect(record.disposed, isTrue);
    });

    testWidgets('unmounts the capture subtree when a captured widget fails', (
      tester,
    ) async {
      final context = await _pumpContext(tester);
      final record = _LifecycleRecord();

      await tester.runAsync(() async {
        final bytes = await SlideCaptureService().capture(
          slide: _lifecycleSlide(record, failBuild: true),
          context: context,
        );

        expect(bytes, isNotEmpty);
      });

      expect(tester.takeException(), isStateError);
      expect(record.mounted, isTrue);
      expect(record.disposed, isTrue);
    });

    testWidgets('releases the subtree of every capture in a sequence', (
      tester,
    ) async {
      final context = await _pumpContext(tester);
      final records = List.generate(3, (_) => _LifecycleRecord());
      final service = SlideCaptureService();

      await tester.runAsync(() async {
        for (final record in records) {
          final bytes = await service.capture(
            slide: _lifecycleSlide(record),
            context: context,
          );

          expect(bytes, isNotEmpty);
        }
      });

      expect(records.every((record) => record.mounted), isTrue);
      expect(records.every((record) => record.disposed), isTrue);
    });
  });
}
