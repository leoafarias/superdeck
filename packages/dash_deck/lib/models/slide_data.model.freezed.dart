// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slide_data.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SlideData _$SlideDataFromJson(Map<String, dynamic> json) {
  return _SlideData.fromJson(json);
}

/// @nodoc
mixin _$SlideData {
  String get id => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  List<CodeBlock> get codeBlocks => throw _privateConstructorUsedError;
  SlideOptions get options => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlideDataCopyWith<SlideData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideDataCopyWith<$Res> {
  factory $SlideDataCopyWith(SlideData value, $Res Function(SlideData) then) =
      _$SlideDataCopyWithImpl<$Res, SlideData>;
  @useResult
  $Res call(
      {String id,
      String? content,
      List<CodeBlock> codeBlocks,
      SlideOptions options});

  $SlideOptionsCopyWith<$Res> get options;
}

/// @nodoc
class _$SlideDataCopyWithImpl<$Res, $Val extends SlideData>
    implements $SlideDataCopyWith<$Res> {
  _$SlideDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? codeBlocks = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      codeBlocks: null == codeBlocks
          ? _value.codeBlocks
          : codeBlocks // ignore: cast_nullable_to_non_nullable
              as List<CodeBlock>,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as SlideOptions,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SlideOptionsCopyWith<$Res> get options {
    return $SlideOptionsCopyWith<$Res>(_value.options, (value) {
      return _then(_value.copyWith(options: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SlideDataCopyWith<$Res> implements $SlideDataCopyWith<$Res> {
  factory _$$_SlideDataCopyWith(
          _$_SlideData value, $Res Function(_$_SlideData) then) =
      __$$_SlideDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? content,
      List<CodeBlock> codeBlocks,
      SlideOptions options});

  @override
  $SlideOptionsCopyWith<$Res> get options;
}

/// @nodoc
class __$$_SlideDataCopyWithImpl<$Res>
    extends _$SlideDataCopyWithImpl<$Res, _$_SlideData>
    implements _$$_SlideDataCopyWith<$Res> {
  __$$_SlideDataCopyWithImpl(
      _$_SlideData _value, $Res Function(_$_SlideData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = freezed,
    Object? codeBlocks = null,
    Object? options = null,
  }) {
    return _then(_$_SlideData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      codeBlocks: null == codeBlocks
          ? _value._codeBlocks
          : codeBlocks // ignore: cast_nullable_to_non_nullable
              as List<CodeBlock>,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as SlideOptions,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SlideData extends _SlideData {
  const _$_SlideData(
      {required this.id,
      this.content,
      final List<CodeBlock> codeBlocks = const [],
      this.options = const SlideOptions()})
      : _codeBlocks = codeBlocks,
        super._();

  factory _$_SlideData.fromJson(Map<String, dynamic> json) =>
      _$$_SlideDataFromJson(json);

  @override
  final String id;
  @override
  final String? content;
  final List<CodeBlock> _codeBlocks;
  @override
  @JsonKey()
  List<CodeBlock> get codeBlocks {
    if (_codeBlocks is EqualUnmodifiableListView) return _codeBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_codeBlocks);
  }

  @override
  @JsonKey()
  final SlideOptions options;

  @override
  String toString() {
    return 'SlideData(id: $id, content: $content, codeBlocks: $codeBlocks, options: $options)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SlideData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._codeBlocks, _codeBlocks) &&
            (identical(other.options, options) || other.options == options));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, content,
      const DeepCollectionEquality().hash(_codeBlocks), options);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SlideDataCopyWith<_$_SlideData> get copyWith =>
      __$$_SlideDataCopyWithImpl<_$_SlideData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SlideDataToJson(
      this,
    );
  }
}

abstract class _SlideData extends SlideData {
  const factory _SlideData(
      {required final String id,
      final String? content,
      final List<CodeBlock> codeBlocks,
      final SlideOptions options}) = _$_SlideData;
  const _SlideData._() : super._();

  factory _SlideData.fromJson(Map<String, dynamic> json) =
      _$_SlideData.fromJson;

  @override
  String get id;
  @override
  String? get content;
  @override
  List<CodeBlock> get codeBlocks;
  @override
  SlideOptions get options;
  @override
  @JsonKey(ignore: true)
  _$$_SlideDataCopyWith<_$_SlideData> get copyWith =>
      throw _privateConstructorUsedError;
}
