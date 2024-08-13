import 'dart:io';

import 'package:path/path.dart' as p;

final File kMarkdownFile = File('slides.md');

final Directory kAssetsDir = Directory(p.join('.superdeck'));

final Directory kGeneratedAssetsDir =
    Directory(p.join(kAssetsDir.path, 'generated'));
final File kProjectConfigFile = File('superdeck.yaml');

final File kReferenceFile = File(p.join(kAssetsDir.path, 'slides.json'));
