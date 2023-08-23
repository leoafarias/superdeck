// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_block.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CodeBlock _$$_CodeBlockFromJson(Map<String, dynamic> json) => _$_CodeBlock(
      source: json['source'] as String,
      highlightLines: (json['highlightLines'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_CodeBlockToJson(_$_CodeBlock instance) =>
    <String, dynamic>{
      'source': instance.source,
      'highlightLines': instance.highlightLines,
    };
