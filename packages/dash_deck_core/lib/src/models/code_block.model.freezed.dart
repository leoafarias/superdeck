// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'code_block.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CodeBlock _$CodeBlockFromJson(Map<String, dynamic> json) {
  return _CodeBlock.fromJson(json);
}

/// @nodoc
mixin _$CodeBlock {
  String get source => throw _privateConstructorUsedError;
  List<int> get focusLines => throw _privateConstructorUsedError;
  List<int> get showLines => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CodeBlockCopyWith<CodeBlock> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodeBlockCopyWith<$Res> {
  factory $CodeBlockCopyWith(CodeBlock value, $Res Function(CodeBlock) then) =
      _$CodeBlockCopyWithImpl<$Res, CodeBlock>;
  @useResult
  $Res call({String source, List<int> focusLines, List<int> showLines});
}

/// @nodoc
class _$CodeBlockCopyWithImpl<$Res, $Val extends CodeBlock>
    implements $CodeBlockCopyWith<$Res> {
  _$CodeBlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? focusLines = null,
    Object? showLines = null,
  }) {
    return _then(_value.copyWith(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      focusLines: null == focusLines
          ? _value.focusLines
          : focusLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
      showLines: null == showLines
          ? _value.showLines
          : showLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CodeBlockCopyWith<$Res> implements $CodeBlockCopyWith<$Res> {
  factory _$$_CodeBlockCopyWith(
          _$_CodeBlock value, $Res Function(_$_CodeBlock) then) =
      __$$_CodeBlockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String source, List<int> focusLines, List<int> showLines});
}

/// @nodoc
class __$$_CodeBlockCopyWithImpl<$Res>
    extends _$CodeBlockCopyWithImpl<$Res, _$_CodeBlock>
    implements _$$_CodeBlockCopyWith<$Res> {
  __$$_CodeBlockCopyWithImpl(
      _$_CodeBlock _value, $Res Function(_$_CodeBlock) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? focusLines = null,
    Object? showLines = null,
  }) {
    return _then(_$_CodeBlock(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      focusLines: null == focusLines
          ? _value._focusLines
          : focusLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
      showLines: null == showLines
          ? _value._showLines
          : showLines // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CodeBlock extends _CodeBlock {
  const _$_CodeBlock(
      {required this.source,
      required final List<int> focusLines,
      required final List<int> showLines})
      : _focusLines = focusLines,
        _showLines = showLines,
        super._();

  factory _$_CodeBlock.fromJson(Map<String, dynamic> json) =>
      _$$_CodeBlockFromJson(json);

  @override
  final String source;
  final List<int> _focusLines;
  @override
  List<int> get focusLines {
    if (_focusLines is EqualUnmodifiableListView) return _focusLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_focusLines);
  }

  final List<int> _showLines;
  @override
  List<int> get showLines {
    if (_showLines is EqualUnmodifiableListView) return _showLines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_showLines);
  }

  @override
  String toString() {
    return 'CodeBlock(source: $source, focusLines: $focusLines, showLines: $showLines)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CodeBlock &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality()
                .equals(other._focusLines, _focusLines) &&
            const DeepCollectionEquality()
                .equals(other._showLines, _showLines));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      source,
      const DeepCollectionEquality().hash(_focusLines),
      const DeepCollectionEquality().hash(_showLines));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CodeBlockCopyWith<_$_CodeBlock> get copyWith =>
      __$$_CodeBlockCopyWithImpl<_$_CodeBlock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CodeBlockToJson(
      this,
    );
  }
}

abstract class _CodeBlock extends CodeBlock {
  const factory _CodeBlock(
      {required final String source,
      required final List<int> focusLines,
      required final List<int> showLines}) = _$_CodeBlock;
  const _CodeBlock._() : super._();

  factory _CodeBlock.fromJson(Map<String, dynamic> json) =
      _$_CodeBlock.fromJson;

  @override
  String get source;
  @override
  List<int> get focusLines;
  @override
  List<int> get showLines;
  @override
  @JsonKey(ignore: true)
  _$$_CodeBlockCopyWith<_$_CodeBlock> get copyWith =>
      throw _privateConstructorUsedError;
}
