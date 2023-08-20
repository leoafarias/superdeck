// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_block.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CodeBlock _$$_CodeBlockFromJson(Map<String, dynamic> json) => _$_CodeBlock(
      source: json['source'] as String,
      focusLines:
          (json['focusLines'] as List<dynamic>).map((e) => e as int).toList(),
      showLines:
          (json['showLines'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$_CodeBlockToJson(_$_CodeBlock instance) =>
    <String, dynamic>{
      'source': instance.source,
      'focusLines': instance.focusLines,
      'showLines': instance.showLines,
    };
