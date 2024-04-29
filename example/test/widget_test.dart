import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/superdeck.dart';

void main() {
  testWidgets('Run and wait to save asssets', (widgetTester) async {
    // run main
    await widgetTester.pumpWidget(const SuperDeckApp());

    await widgetTester.pumpAndSettle(const Duration(seconds: 2));
  });
}
