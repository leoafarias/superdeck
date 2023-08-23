import 'package:freezed_annotation/freezed_annotation.dart';

part 'code_block.model.freezed.dart';
part 'code_block.model.g.dart';

@freezed
class CodeBlock with _$CodeBlock {
  const CodeBlock._();
  const factory CodeBlock({
    required String source,
    required List<int> highlightLines,
  }) = _CodeBlock;

  factory CodeBlock.fromJson(Map<String, dynamic> json) =>
      _$CodeBlockFromJson(json);
}
