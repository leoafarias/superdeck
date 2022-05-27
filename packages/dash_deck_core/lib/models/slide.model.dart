import 'dart:convert';

import 'package:yaml/yaml.dart';

import './slide_options.model.dart';

/// Document containing the original `value`, front matter `data` and `content`.
class Slide {
  const Slide({
    required this.id,
    this.content,
    this.snippets = const [],
    this.options = const SlideOptions(),
  });

  final String id;
  final String? content;

  final List<String> snippets;

  /// The parsed YAML front matter as a [YamlMap].
  final SlideOptions options;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'snippets': snippets,
      'options': options.toMap(),
    };
  }

  factory Slide.fromMap(Map<String, dynamic> map) {
    return Slide(
      id: map['id'] ?? '',
      content: map['content'],
      snippets: List<String>.from(map['snippets']),
      options: SlideOptions.fromMap(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Slide.fromJson(String source) => Slide.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Slide(id: $id, content: $content, snippets: $snippets, options: $options)';
  }
}
