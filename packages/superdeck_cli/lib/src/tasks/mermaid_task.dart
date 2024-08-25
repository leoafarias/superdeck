import 'dart:async';

import 'package:puppeteer/puppeteer.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';

// ---
// title: Hello Title
// config:
//   theme: base
//   themeVariables:
//     primaryColor: "#00ff00"
// ---

Future<String> _generateMermaidGraph(
  Browser browser,
  String graphDefinition,
) async {
  logger
    ..detail('')
    ..detail('Generating mermaid graph...')
    ..detail(graphDefinition)
    ..detail('');

  final page = await browser.newPage();

  await page.setContent('''
    <html>
      <body>
        <pre class="mermaid">
          $graphDefinition
        </pre>
        <script type="module">
          import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
          mermaid.initialize({
            startOnLoad: false,
            theme: 'dark',
          });
          mermaid.run({
            querySelector: 'pre.mermaid',
          });
        </script>
      </body>
    </html>
  ''');

  await page.waitForSelector('pre.mermaid > svg');
  final element = await page.$('pre.mermaid > svg');
  final svgContent = await element.evaluate('el => el.outerHTML');

  await page.close();
  return svgContent;
}

Future<String> _convertToRoughDraft(Browser browser, String svgContent) async {
  print('Converting to rough draft...');
  final page = await browser.newPage();

  await page.setContent('''
    <html>
      <body>
        <div class="svg-container">$svgContent</div>
        <div class="sketch-container"></div>
        <script src="https://unpkg.com/svg2roughjs/dist/svg2roughjs.umd.min.js"></script>
        <script>
          const svgElement = document.querySelector('.svg-container > svg');
          const svgConverter = new svg2roughjs.Svg2Roughjs('.sketch-container');
          svgConverter.svg = svgElement;
          svgConverter.sketch();
        </script>
      </body>
    </html>
  ''');

  await page.waitForSelector('.sketch-container > svg');
  final element = await page.$('.sketch-container > svg');

  final output = await element.evaluate('el => el.outerHTML');

  await page.close();

  return output;
}

Future<List<int>> _convertSvgToImage(Browser browser, String svgContent) async {
  final page = await browser.newPage();

  await page.setContent('''
    <html>
      <body>
        <div class="svg-container">$svgContent</div>
      </body>
    </html>
  ''');

  final element = await page.$('.svg-container > svg');

  final screenshot = await element.screenshot(
    format: ScreenshotFormat.png,
    omitBackground: true,
  );

  await page.close();

  return screenshot;
}

Future<List<int>> generateRoughMermaidGraph(
    Browser browser, String graphDefinition) async {
  final svgContent = await _generateMermaidGraph(browser, graphDefinition);
  // final roughDraft = await _convertToRoughDraft(browser, svgContent);

  return _convertSvgToImage(browser, svgContent);
}

class MermaidConverterTask extends Task {
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

      final mermaidFile = buildAssetFile(
        buildReferenceName(mermaidSyntax),
        'png',
      );

      if (!await mermaidFile.exists()) {
        final browser = await controller.pipeline.getBrowser();

        final imageData =
            await generateRoughMermaidGraph(browser, mermaidSyntax);

        await mermaidFile.writeAsBytes(imageData);
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
