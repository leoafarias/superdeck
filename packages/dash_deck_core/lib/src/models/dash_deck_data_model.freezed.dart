// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dash_deck_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DashDeckData _$DashDeckDataFromJson(Map<String, dynamic> json) {
  return _DashDeckData.fromJson(json);
}

/// @nodoc
mixin _$DashDeckData {
  List<SlideData> get slides => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashDeckDataCopyWith<DashDeckData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashDeckDataCopyWith<$Res> {
  factory $DashDeckDataCopyWith(
          DashDeckData value, $Res Function(DashDeckData) then) =
      _$DashDeckDataCopyWithImpl<$Res, DashDeckData>;
  @useResult
  $Res call({List<SlideData> slides});
}

/// @nodoc
class _$DashDeckDataCopyWithImpl<$Res, $Val extends DashDeckData>
    implements $DashDeckDataCopyWith<$Res> {
  _$DashDeckDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slides = null,
  }) {
    return _then(_value.copyWith(
      slides: null == slides
          ? _value.slides
          : slides // ignore: cast_nullable_to_non_nullable
              as List<SlideData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DashDeckDataCopyWith<$Res>
    implements $DashDeckDataCopyWith<$Res> {
  factory _$$_DashDeckDataCopyWith(
          _$_DashDeckData value, $Res Function(_$_DashDeckData) then) =
      __$$_DashDeckDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SlideData> slides});
}

/// @nodoc
class __$$_DashDeckDataCopyWithImpl<$Res>
    extends _$DashDeckDataCopyWithImpl<$Res, _$_DashDeckData>
    implements _$$_DashDeckDataCopyWith<$Res> {
  __$$_DashDeckDataCopyWithImpl(
      _$_DashDeckData _value, $Res Function(_$_DashDeckData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slides = null,
  }) {
    return _then(_$_DashDeckData(
      slides: null == slides
          ? _value._slides
          : slides // ignore: cast_nullable_to_non_nullable
              as List<SlideData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DashDeckData implements _DashDeckData {
  _$_DashDeckData({required final List<SlideData> slides}) : _slides = slides;

  factory _$_DashDeckData.fromJson(Map<String, dynamic> json) =>
      _$$_DashDeckDataFromJson(json);

  final List<SlideData> _slides;
  @override
  List<SlideData> get slides {
    if (_slides is EqualUnmodifiableListView) return _slides;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slides);
  }

  @override
  String toString() {
    return 'DashDeckData(slides: $slides)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DashDeckData &&
            const DeepCollectionEquality().equals(other._slides, _slides));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_slides));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DashDeckDataCopyWith<_$_DashDeckData> get copyWith =>
      __$$_DashDeckDataCopyWithImpl<_$_DashDeckData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DashDeckDataToJson(
      this,
    );
  }
}

abstract class _DashDeckData implements DashDeckData {
  factory _DashDeckData({required final List<SlideData> slides}) =
      _$_DashDeckData;

  factory _DashDeckData.fromJson(Map<String, dynamic> json) =
      _$_DashDeckData.fromJson;

  @override
  List<SlideData> get slides;
  @override
  @JsonKey(ignore: true)
  _$$_DashDeckDataCopyWith<_$_DashDeckData> get copyWith =>
      throw _privateConstructorUsedError;
}
