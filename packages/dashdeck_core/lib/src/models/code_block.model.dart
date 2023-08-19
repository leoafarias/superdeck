import 'dart:convert';

import 'package:equatable/equatable.dart';

class CodeBlock extends Equatable {
  final String source;
  final List<int> focusLines;
  final List<int> showLines;

  const CodeBlock({
    required this.source,
    required this.focusLines,
    required this.showLines,
  });

  Map<String, dynamic> toMap() {
    return {
      'source': source,
      'focusLines': focusLines,
      'showLines': showLines,
    };
  }

  factory CodeBlock.fromMap(Map<String, dynamic> map) {
    return CodeBlock(
      source: map['source'] ?? '',
      focusLines: List<int>.from(map['focusLines']),
      showLines: List<int>.from(map['showLines']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeBlock.fromJson(String source) {
    return CodeBlock.fromMap(json.decode(source));
  }

  @override
  String toString() {
    return 'Snippet(source: $source, focusLines: $focusLines, showLines: $showLines)';
  }

  @override
  List<Object?> get props => [source, focusLines, showLines];
}
