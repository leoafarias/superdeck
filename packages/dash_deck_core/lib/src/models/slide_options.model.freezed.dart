// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slide_options.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SlideOptions _$SlideOptionsFromJson(Map<String, dynamic> json) {
  return _SlideOptions.fromJson(json);
}

/// @nodoc
mixin _$SlideOptions {
  bool get scrollable => throw _privateConstructorUsedError;
  SlideLayout get layout => throw _privateConstructorUsedError;
  String? get background => throw _privateConstructorUsedError;
  ImageFit get backgroundFit => throw _privateConstructorUsedError;
  ContentAlignment get contentAlignment => throw _privateConstructorUsedError;
  String? get styles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlideOptionsCopyWith<SlideOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideOptionsCopyWith<$Res> {
  factory $SlideOptionsCopyWith(
          SlideOptions value, $Res Function(SlideOptions) then) =
      _$SlideOptionsCopyWithImpl<$Res, SlideOptions>;
  @useResult
  $Res call(
      {bool scrollable,
      SlideLayout layout,
      String? background,
      ImageFit backgroundFit,
      ContentAlignment contentAlignment,
      String? styles});
}

/// @nodoc
class _$SlideOptionsCopyWithImpl<$Res, $Val extends SlideOptions>
    implements $SlideOptionsCopyWith<$Res> {
  _$SlideOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollable = null,
    Object? layout = null,
    Object? background = freezed,
    Object? backgroundFit = null,
    Object? contentAlignment = null,
    Object? styles = freezed,
  }) {
    return _then(_value.copyWith(
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as SlideLayout,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundFit: null == backgroundFit
          ? _value.backgroundFit
          : backgroundFit // ignore: cast_nullable_to_non_nullable
              as ImageFit,
      contentAlignment: null == contentAlignment
          ? _value.contentAlignment
          : contentAlignment // ignore: cast_nullable_to_non_nullable
              as ContentAlignment,
      styles: freezed == styles
          ? _value.styles
          : styles // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SlideOptionsCopyWith<$Res>
    implements $SlideOptionsCopyWith<$Res> {
  factory _$$_SlideOptionsCopyWith(
          _$_SlideOptions value, $Res Function(_$_SlideOptions) then) =
      __$$_SlideOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool scrollable,
      SlideLayout layout,
      String? background,
      ImageFit backgroundFit,
      ContentAlignment contentAlignment,
      String? styles});
}

/// @nodoc
class __$$_SlideOptionsCopyWithImpl<$Res>
    extends _$SlideOptionsCopyWithImpl<$Res, _$_SlideOptions>
    implements _$$_SlideOptionsCopyWith<$Res> {
  __$$_SlideOptionsCopyWithImpl(
      _$_SlideOptions _value, $Res Function(_$_SlideOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrollable = null,
    Object? layout = null,
    Object? background = freezed,
    Object? backgroundFit = null,
    Object? contentAlignment = null,
    Object? styles = freezed,
  }) {
    return _then(_$_SlideOptions(
      scrollable: null == scrollable
          ? _value.scrollable
          : scrollable // ignore: cast_nullable_to_non_nullable
              as bool,
      layout: null == layout
          ? _value.layout
          : layout // ignore: cast_nullable_to_non_nullable
              as SlideLayout,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as String?,
      backgroundFit: null == backgroundFit
          ? _value.backgroundFit
          : backgroundFit // ignore: cast_nullable_to_non_nullable
              as ImageFit,
      contentAlignment: null == contentAlignment
          ? _value.contentAlignment
          : contentAlignment // ignore: cast_nullable_to_non_nullable
              as ContentAlignment,
      styles: freezed == styles
          ? _value.styles
          : styles // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SlideOptions extends _SlideOptions {
  const _$_SlideOptions(
      {this.scrollable = false,
      this.layout = SlideLayout.none,
      this.background,
      this.backgroundFit = ImageFit.cover,
      this.contentAlignment = ContentAlignment.center,
      this.styles})
      : super._();

  factory _$_SlideOptions.fromJson(Map<String, dynamic> json) =>
      _$$_SlideOptionsFromJson(json);

  @override
  @JsonKey()
  final bool scrollable;
  @override
  @JsonKey()
  final SlideLayout layout;
  @override
  final String? background;
  @override
  @JsonKey()
  final ImageFit backgroundFit;
  @override
  @JsonKey()
  final ContentAlignment contentAlignment;
  @override
  final String? styles;

  @override
  String toString() {
    return 'SlideOptions(scrollable: $scrollable, layout: $layout, background: $background, backgroundFit: $backgroundFit, contentAlignment: $contentAlignment, styles: $styles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SlideOptions &&
            (identical(other.scrollable, scrollable) ||
                other.scrollable == scrollable) &&
            (identical(other.layout, layout) || other.layout == layout) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.backgroundFit, backgroundFit) ||
                other.backgroundFit == backgroundFit) &&
            (identical(other.contentAlignment, contentAlignment) ||
                other.contentAlignment == contentAlignment) &&
            (identical(other.styles, styles) || other.styles == styles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, scrollable, layout, background,
      backgroundFit, contentAlignment, styles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SlideOptionsCopyWith<_$_SlideOptions> get copyWith =>
      __$$_SlideOptionsCopyWithImpl<_$_SlideOptions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SlideOptionsToJson(
      this,
    );
  }
}

abstract class _SlideOptions extends SlideOptions {
  const factory _SlideOptions(
      {final bool scrollable,
      final SlideLayout layout,
      final String? background,
      final ImageFit backgroundFit,
      final ContentAlignment contentAlignment,
      final String? styles}) = _$_SlideOptions;
  const _SlideOptions._() : super._();

  factory _SlideOptions.fromJson(Map<String, dynamic> json) =
      _$_SlideOptions.fromJson;

  @override
  bool get scrollable;
  @override
  SlideLayout get layout;
  @override
  String? get background;
  @override
  ImageFit get backgroundFit;
  @override
  ContentAlignment get contentAlignment;
  @override
  String? get styles;
  @override
  @JsonKey(ignore: true)
  _$$_SlideOptionsCopyWith<_$_SlideOptions> get copyWith =>
      throw _privateConstructorUsedError;
}
