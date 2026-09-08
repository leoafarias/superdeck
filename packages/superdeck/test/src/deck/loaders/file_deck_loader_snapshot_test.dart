import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Status file whose reads follow a script, so the loader can be observed
/// while the build replaces the status between two reads.
class _ScriptedStatusFile implements File {
  _ScriptedStatusFile(this._delegate, this._contents);

  final File _delegate;
  final List<String> _contents;
  var reads = 0;

  @override
  String get path => _delegate.path;

  @override
  Directory get parent => _delegate.parent;

  @override
  Future<bool> exists() => _delegate.exists();

  @override
  Future<String> readAsString({Encoding encoding = utf8}) async {
    final index = reads < _contents.length ? reads : _contents.length - 1;
    reads++;

    return _contents[index];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

String _statusJson(String status, int seq) =>
    '{"status":"$status","timestamp":"2026-03-10T10:00:0$seq.000Z"}';

void main() {
  test('processes the status snapshot it compares against', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'superdeck_loader_snapshot_',
    );
    addTearDown(() async {
      if (await tempDir.exists()) await tempDir.delete(recursive: true);
    });

    final workspace = DeckWorkspace(projectDir: tempDir.path);
    await workspace.superdeckDir.create(recursive: true);
    await workspace.deckJson.writeAsString('[]');
    final realStatusFile = workspace.buildStatusJson;
    await realStatusFile.writeAsString(_statusJson('building', 1));

    // The second read returns the finished build, which is what an
    // unprotected second read inside one cycle would observe.
    final scriptedStatusFile = _ScriptedStatusFile(realStatusFile, [
      _statusJson('building', 1),
      _statusJson('success', 2),
    ]);

    final events = <SlidesEvent>[];
    await IOOverrides.runZoned(
      () async {
        final deckLoader = FileDeckLoader(workspace: workspace);
        final subscription = deckLoader.load().listen(events.add);
        final deadline = DateTime.now().add(const Duration(seconds: 3));
        while (events.length < 3 && DateTime.now().isBefore(deadline)) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
        await subscription.cancel();
        await deckLoader.dispose();
      },
      // `File(path)` inside this callback would consult the same override
      // again, so unrelated paths resolve in the root zone.
      createFile: (path) => path == realStatusFile.path
          ? scriptedStatusFile
          : Zone.root.run(() => File(path)),
    );

    expect(events, hasLength(greaterThanOrEqualTo(3)));
    expect(events[0], isA<SlidesLoadingEvent>());
    // The first cycle must emit the snapshot it read, not a later one.
    expect(events[1], isA<SlidesRebuildingEvent>());
    expect(events[2], isA<SlidesLoadedEvent>());
  });
}
