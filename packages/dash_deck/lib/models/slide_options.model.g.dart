// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_options.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SlideOptions _$$_SlideOptionsFromJson(Map<String, dynamic> json) =>
    _$_SlideOptions(
      scrollable: json['scrollable'] as bool? ?? false,
      layout: $enumDecodeNullable(_$SlideLayoutEnumMap, json['layout']) ??
          SlideLayout.none,
      image: json['image'] as String?,
      imageFit: $enumDecodeNullable(_$ImageFitEnumMap, json['imageFit']) ??
          ImageFit.cover,
      contentAlignment: $enumDecodeNullable(
              _$ContentAlignmentEnumMap, json['contentAlignment']) ??
          ContentAlignment.center,
      styles: json['styles'] as String?,
    );

Map<String, dynamic> _$$_SlideOptionsToJson(_$_SlideOptions instance) =>
    <String, dynamic>{
      'scrollable': instance.scrollable,
      'layout': _$SlideLayoutEnumMap[instance.layout]!,
      'image': instance.image,
      'imageFit': _$ImageFitEnumMap[instance.imageFit]!,
      'contentAlignment': _$ContentAlignmentEnumMap[instance.contentAlignment]!,
      'styles': instance.styles,
    };

const _$SlideLayoutEnumMap = {
  SlideLayout.none: 'none',
  SlideLayout.cover: 'cover',
  SlideLayout.contentLeft: 'contentLeft',
  SlideLayout.contentRight: 'contentRight',
};

const _$ImageFitEnumMap = {
  ImageFit.cover: 'cover',
  ImageFit.contain: 'contain',
  ImageFit.fill: 'fill',
  ImageFit.fitHeight: 'fitHeight',
  ImageFit.fitWidth: 'fitWidth',
  ImageFit.none: 'none',
  ImageFit.scaleDown: 'scaleDown',
};

const _$ContentAlignmentEnumMap = {
  ContentAlignment.topLeft: 'topLeft',
  ContentAlignment.topCenter: 'topCenter',
  ContentAlignment.topRight: 'topRight',
  ContentAlignment.centerLeft: 'centerLeft',
  ContentAlignment.center: 'center',
  ContentAlignment.centerRight: 'centerRight',
  ContentAlignment.bottomLeft: 'bottomLeft',
  ContentAlignment.bottomCenter: 'bottomCenter',
  ContentAlignment.bottomRight: 'bottomRight',
};
