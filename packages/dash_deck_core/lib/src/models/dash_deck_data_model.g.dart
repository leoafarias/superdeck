// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dash_deck_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DashDeckData _$$_DashDeckDataFromJson(Map<String, dynamic> json) =>
    _$_DashDeckData(
      slides: (json['slides'] as List<dynamic>)
          .map((e) => SlideData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DashDeckDataToJson(_$_DashDeckData instance) =>
    <String, dynamic>{
      'slides': instance.slides,
    };
