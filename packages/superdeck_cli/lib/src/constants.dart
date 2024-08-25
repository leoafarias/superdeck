import 'dart:io';

import 'package:path/path.dart' as p;

final kMarkdownFile = File('slides.md');

final kAssetsDir = Directory(p.join('.superdeck'));

final kGeneratedAssetsDir = Directory(p.join(kAssetsDir.path, 'generated'));
final kProjectConfigFile = File('superdeck.yaml');

final kReferenceFile = File(p.join(kAssetsDir.path, 'slides.json'));
final kReferenceFileYaml = File(p.join(kAssetsDir.path, 'slides.yaml'));
final kReferenceMarkdownCopy = File(p.join(kAssetsDir.path, 'slides_copy.md'));
