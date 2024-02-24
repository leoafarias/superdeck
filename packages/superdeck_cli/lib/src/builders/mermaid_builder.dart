import 'dart:io';

import '../constants.dart';

Future<String> replaceMermaidContent(String content) async {
  final mermaidBlockRegex = RegExp(r'```mermaid([\s\S]*?)```');

  Iterable<Match> matches = mermaidBlockRegex.allMatches(content);
  for (Match match in matches) {
    var mermaidSyntax = match.group(1);
    if (mermaidSyntax == null) {
      continue;
    }
    // Process the mermaid syntax
    await _processMermaidSyntax(mermaidSyntax);
  }

  String updatedMarkdownContent = content;
  for (Match match in matches) {
    String mermaidSyntaxBlock = match.group(0) ?? '';
    // Assuming all images are saved as 'output.png' for simplicity
    String imagePath = 'resource:assets/dash_deck/images/output.png';
    updatedMarkdownContent = updatedMarkdownContent.replaceFirst(
        mermaidSyntaxBlock, '![Mermaid Diagram]($imagePath)');
  }

  return updatedMarkdownContent;
}

Future<void> _processMermaidSyntax(String mermaidSyntax) async {
  String tempFilePath = 'temp.mmd';

  mermaidSyntax = mermaidSyntax.trim().replaceAll(r'\n', '\n');

  await File(tempFilePath).writeAsString(mermaidSyntax);

  final outputFile = kDashDeckDirectory.imageFileName('output.png');

  if (!outputFile.parent.existsSync()) {
    outputFile.parent.createSync(recursive: true);
  }

  final imageSizeParams = '--scale 2'.split(' ');
  final params =
      '-t dark -b transparent -i $tempFilePath -o ${outputFile.path} '
          .split(' ');

  final result = await Process.run('mmdc', [...params, ...imageSizeParams]);

  if (result.exitCode != 0) {
    print('Error while processing mermaid syntax');
    print(result.stderr);
  }
}
