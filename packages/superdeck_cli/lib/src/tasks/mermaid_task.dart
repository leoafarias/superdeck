import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/slides_pipeline.dart';

class MermaidConverterTask extends Task {
  final _mermaidService = const MermaidService();
  const MermaidConverterTask() : super('mermaid');

  @override
  FutureOr<TaskController> run(controller) async {
    final mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');
    final slide = controller.slide;

    final matches = mermaidBlockRegex.allMatches(slide.content);

    if (matches.isEmpty) return controller;
    final replacements = <({int start, int end, String markdown})>[];

    for (final Match match in matches) {
      final mermaidSyntax = match.group(1);

      if (mermaidSyntax == null) continue;

      final mermaidFile = buildAssetFile(buildReferenceName(mermaidSyntax));

      if (!await mermaidFile.exists()) {
        // Process the mermaid syntax to generate an image file
        final imageData = await _mermaidService.generateImage(mermaidSyntax);

        if (imageData != null) {
          await mermaidFile.writeAsBytes(imageData);
        }
      }

      // If file existeed or was create it then replace it
      if (await mermaidFile.exists()) {
        await controller.markFileAsNeeded(mermaidFile);

        replacements.add((
          start: match.start,
          end: match.end,
          markdown: '![Mermaid Diagram](${mermaidFile.path})',
        ));
      }
    }

    var replacedData = slide.content;

    // Apply replacements in reverse order
    for (var replacement in replacements.reversed) {
      final (
        :start,
        :end,
        :markdown,
      ) = replacement;

      replacedData = replacedData.replaceRange(start, end, markdown);
    }

    return controller.copyWith(
      slide: slide.copyWith(content: replacedData),
    );
  }
}

class MermaidService {
  const MermaidService();

  Future<Uint8List?> generateImage(String mermaidSyntax) async {
    final fileName = mermaidSyntax.hashCode;

    final tempDir = Directory('.tmp_superdeck');

    final tempFile = File(p.join(tempDir.path, '$fileName.mmd'));
    final outputFile = File(p.join(tempDir.path, '$fileName.png'));

    if (!await tempDir.exists()) {
      await tempDir.create(recursive: true);
    }

    try {
      mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

      await tempFile.writeAsString(mermaidSyntax);

      // Check if can execute mmdc before executing command
      final mmdcResult = await Process.run('mmdc', ['--version']);

      if (mmdcResult.exitCode != 0) {
        log(
          '"mmdc" not found. You need mermaid cli installed to process mermaid syntax',
        );

        return null;
      }

      final params = [
        '-t dark',
        '-b transparent',
        '-i ${tempFile.path}',
        '-o ${outputFile.path}',
        '--scale 2'
      ];

      final result = await Process.run(
        'mmdc',
        params.expand((e) => e.split(' ')).toList(),
      );

      if (result.exitCode != 0) {
        log('Error while processing mermaid syntax');
        log(result.stderr);
        return null;
      }

      return outputFile.readAsBytes();
    } catch (e) {
      log('Error while processing mermaid syntax: $e');
      return null;
    } finally {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    }
  }
}
