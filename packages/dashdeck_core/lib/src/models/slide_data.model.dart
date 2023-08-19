import 'dart:convert';

import 'package:dashdeck_core/src/models/code_block.model.dart';
import 'package:equatable/equatable.dart';

import './slide_options.model.dart';

class SlideData extends Equatable {
  const SlideData({
    required this.id,
    this.content,
    this.codeBlocks = const [],
    this.options = const SlideOptions(),
  });

  final String id;
  final String? content;
  final List<CodeBlock> codeBlocks;
  final SlideOptions options;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'codeBlocks':
          codeBlocks.map((e) => e.toMap()).toList(), // Serialize codeBlocks
      'options': options.toMap(),
    };
  }

  factory SlideData.fromMap(Map<String, dynamic> map) {
    return SlideData(
      id: map['id'] as String? ?? '', // Ensure 'id' is String
      content: map['content'] as String?,
      codeBlocks: (map['codeBlocks'] as List? ?? [])
          .map((e) => CodeBlock.fromMap(e as Map<String, dynamic>))
          .toList(), // Handle possible null and ensure correct type
      options: SlideOptions.fromMap(map['options'] as Map<String, dynamic>? ??
          {}), // Handle possible null
    );
  }

  String toJson() => json.encode(toMap());

  factory SlideData.fromJson(String source) =>
      SlideData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Slide(id: $id, content: $content, codeBlocks: $codeBlocks, options: $options)';
  }

  @override
  List<Object?> get props => [id, content, codeBlocks, options];
}
