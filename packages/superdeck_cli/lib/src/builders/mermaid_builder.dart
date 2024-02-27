import 'dart:io';

import 'package:path/path.dart';

import '../context.dart';
import '../helper/extension_io.dart';

String replaceMermaidContent(String content) {
  final mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

  String updatedMarkdownContent = content;

  Iterable<Match> matches = mermaidBlockRegex.allMatches(content);
  for (Match match in matches) {
    var mermaidSyntax = match.group(1);
    if (mermaidSyntax == null) {
      continue;
    }
    // Process the mermaid syntax
    final imageFile = _processMermaidSyntax(mermaidSyntax);

    final syntaxBlock = match.group(0) ?? '';

    final relativePath =
        relative(imageFile.path, from: ctx.slidesJsonFile.parent.path);

    // Assuming all images are saved as 'output.png' for simplicity
    String imagePath = 'resource:$relativePath';
    updatedMarkdownContent = updatedMarkdownContent.replaceFirst(
        syntaxBlock, '![Mermaid Diagram]($imagePath)');
  }

  return updatedMarkdownContent;
}

File _processMermaidSyntax(String mermaidSyntax) {
  String tempFilePath = 'temp.mmd';
  final tempFile = File(tempFilePath);

  try {
    mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

    // has the mermaidSyntax string
    final fileHash = mermaidSyntax.hashCode;

    tempFile.write(mermaidSyntax);

    final outputFile = ctx.getImageFile('$fileHash.png');

    if (!outputFile.parent.existsSync()) {
      outputFile.parent.createSync(recursive: true);
    }

    final imageSizeParams = '--scale 2'.split(' ');
    final params =
        '-t dark -b transparent -i $tempFilePath -o ${outputFile.path} '
            .split(' ');

    final result = Process.runSync('mmdc', [...params, ...imageSizeParams]);

    if (result.exitCode != 0) {
      print('Error while processing mermaid syntax');
      print(result.stderr);
    }

    return outputFile;
  } catch (e) {
    throw Exception('Error while processing mermaid syntax');
  } finally {
    tempFile.deleteIfExists();
  }
}
