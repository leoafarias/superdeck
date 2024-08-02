import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

/// Path/filename comment
const String pubspecPath = 'pubspec.yaml';

void main() {
  updatePubspecAssets();
}

/// Updates the pubspec.yaml to include .superdeck/ and .superdeck/generated/ assets.
void updatePubspecAssets() {
  // Read the pubspec.yaml file
  final File file = File(pubspecPath);
  if (!file.existsSync()) {
    print('pubspec.yaml not found.');
    return;
  }

  final String content = file.readAsStringSync();
  final YamlMap yamlContent = loadYaml(content);

  // Ensure the flutter: key exists
  Map<String, dynamic> flutterSection = yamlContent['flutter'] ?? {};

  // Get the existing assets or create a new list if it doesn't exist
  List<dynamic> assets = flutterSection['assets']?.toList() ?? [];

  // Add the new asset paths if they don't exist
  if (!assets.contains('.superdeck/')) {
    assets.add('.superdeck/');
  }
  if (!assets.contains('.superdeck/generated/')) {
    assets.add('.superdeck/generated/');
  }

  // Update the flutter section with the new assets list
  flutterSection['assets'] = assets;

  // Convert the updated map back to YAML
  final updatedYaml = Map<String, dynamic>.from(yamlContent)
    ..['flutter'] = flutterSection;

  final String updatedContent = YamlWriter().write(updatedYaml);

  // Write the updated content back to the pubspec.yaml file
  file.writeAsStringSync(updatedContent);

  print('pubspec.yaml updated successfully.');
}
