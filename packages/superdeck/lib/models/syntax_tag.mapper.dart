// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'syntax_tag.dart';

class SyntaxTagMapper extends EnumMapper<SyntaxTag> {
  SyntaxTagMapper._();

  static SyntaxTagMapper? _instance;
  static SyntaxTagMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SyntaxTagMapper._());
    }
    return _instance!;
  }

  static SyntaxTag fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SyntaxTag decode(dynamic value) {
    switch (value) {
      case '::left::':
        return SyntaxTag.left;
      case '::right::':
        return SyntaxTag.right;
      case '::content::':
        return SyntaxTag.content;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SyntaxTag self) {
    switch (self) {
      case SyntaxTag.left:
        return '::left::';
      case SyntaxTag.right:
        return '::right::';
      case SyntaxTag.content:
        return '::content::';
    }
  }
}

extension SyntaxTagMapperExtension on SyntaxTag {
  dynamic toValue() {
    SyntaxTagMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SyntaxTag>(this);
  }
}
