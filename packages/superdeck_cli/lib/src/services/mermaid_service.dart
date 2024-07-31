import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

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

      final imageSizeParams = '--scale 2'.split(' ');
      final params =
          '-t dark -b transparent -i ${tempFile.path} -o ${outputFile.path} '
              .split(' ');

      // Check if can execute mmdc before executing command
      final mmdcResult = await Process.run('mmdc', ['--version']);

      if (mmdcResult.exitCode != 0) {
        log(
          '"mmdc" not found. You need mermaid cli installed to process mermaid syntax',
        );

        return null;
      }

      final result = await Process.run('mmdc', [...params, ...imageSizeParams]);

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
