import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/models/deck_reference_model.dart';

void main() {
  group('DeckReference', () {
    /// Create a test for performance parsing of fromJson
    test('parses a json deck reference in less than 100ms', () async {
      final fixture = File('test/fixtures/deck_reference.json');
      final contents = await fixture.readAsString();

      final stopwatch = Stopwatch()..start();
      DeckReference.fromJson(contents);
      stopwatch.stop();

      // Use Isolate.compute to run the parsing in a separate isolate
      // and measure the time it takes to parse the json

      final stopwatch2 = Stopwatch()..start();

      await compute(DeckReference.fromJson, contents);

      stopwatch2.stop();

      // stopwatch 2 should be faster than stopwatch
      expect(stopwatch2.elapsedMilliseconds,
          lessThan(stopwatch.elapsedMilliseconds));
    });

    test('parses a json deck reference', () async {
      final fixture = File('test/fixtures/deck_reference.json');
      final contents = await fixture.readAsString();
      final deckReference = DeckReference.fromJson(contents);

      expect(deckReference, isNotNull);
      expect(deckReference.config, isNotNull);
      expect(deckReference.slides, isNotEmpty);
      expect(deckReference.assets, isNotEmpty);
    });
  });
}
