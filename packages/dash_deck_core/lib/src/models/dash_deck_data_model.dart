import 'package:dash_deck_core/dash_deck_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dash_deck_data_model.freezed.dart';
part 'dash_deck_data_model.g.dart';

@freezed
class DashDeckData with _$DashDeckData {
  factory DashDeckData({
    required List<SlideData> slides,
  }) = _DashDeckData;

  factory DashDeckData.fromJson(Map<String, dynamic> json) =>
      _$DashDeckDataFromJson(json);
}
