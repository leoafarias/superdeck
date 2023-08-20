// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SlideData _$$_SlideDataFromJson(Map<String, dynamic> json) => _$_SlideData(
      id: json['id'] as String,
      content: json['content'] as String?,
      codeBlocks: (json['codeBlocks'] as List<dynamic>?)
              ?.map((e) => CodeBlock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      options: json['options'] == null
          ? const SlideOptions()
          : SlideOptions.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SlideDataToJson(_$_SlideData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'codeBlocks': instance.codeBlocks,
      'options': instance.options,
    };
