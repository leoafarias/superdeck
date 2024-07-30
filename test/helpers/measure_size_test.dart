import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/measure_size.dart';

void main() {
  group('MeasureSize', () {
    testWidgets('calls onChange with correct size',
        (WidgetTester tester) async {
      Size? size;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MeasureSize(
              onChange: (newSize) {
                size = newSize;
              },
              child: const SizedBox(width: 100, height: 200),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(size, equals(const Size(100, 200)));
    });

    testWidgets('does not call onChange if size does not change',
        (WidgetTester tester) async {
      int onChangeCalls = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: MeasureSize(
            onChange: (newSize) {
              onChangeCalls++;
            },
            child: const SizedBox(width: 100, height: 200),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MeasureSize(
            onChange: (newSize) {
              onChangeCalls++;
            },
            child: const SizedBox(width: 100, height: 200),
          ),
        ),
      );

      expect(onChangeCalls, equals(1));
    });
  });

  group('SlideConstraints', () {
    testWidgets('provides correct constraints to builder',
        (WidgetTester tester) async {
      Size? size;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideConstraints(
              (constraints) {
                size = constraints;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      await tester.pump();

      expect(size, equals(const Size(0, 0)));
    });

    testWidgets('updates constraints when widget size changes', (
      WidgetTester tester,
    ) async {
      Size? size;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideConstraints(
              (constraints) {
                size = constraints;
                return const SizedBox(width: 100, height: 200);
              },
            ),
          ),
        ),
      );

      await tester.pump();
      expect(size, equals(const Size(100, 200)));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SlideConstraints(
              (constraints) {
                size = constraints;
                return const SizedBox(width: 200, height: 300);
              },
            ),
          ),
        ),
      );

      await tester.pump();
      expect(size, equals(const Size(200, 300)));
    });

    testWidgets('throws error when SlideConstraintsProvider not found',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              SlideConstraints.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(tester.takeException(), isFlutterError);
    });
  });
}
