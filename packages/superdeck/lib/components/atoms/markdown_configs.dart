import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

// TextStyle for H1
const _h1Style = TextStyle(
  fontSize: 72,
  height: 88 / 72,
  fontWeight: FontWeight.bold,
);

// TextStyle for H2
const _h2Style = TextStyle(
  fontSize: 48,
  height: 58 / 48,
  fontWeight: FontWeight.bold,
);

// TextStyle for H3
const _h3Style = TextStyle(
  fontSize: 36,
  height: 44 / 36,
  fontWeight: FontWeight.bold,
);

// TextStyle for H4
const _h4Style = TextStyle(
  fontSize: 30,
  height: 36 / 30,
  fontWeight: FontWeight.bold,
);

// TextStyle for H5
const _h5Style = TextStyle(
  fontSize: 24,
  height: 29 / 24,
  fontWeight: FontWeight.bold,
);

// TextStyle for H6
const _h6Style = TextStyle(
  fontSize: 20,
  height: 24 / 20,
  fontWeight: FontWeight.bold,
);

const _pStyle = TextStyle(
  fontSize: 24,
  height: 1.5,
  fontWeight: FontWeight.normal,
);

class CustomH1Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH1Config({this.style = _h1Style});

  @override
  String get tag => MarkdownTag.h1.name;

  static CustomH1Config get darkConfig =>
      CustomH1Config(style: _h1Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}

class CustomH2Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH2Config({this.style = _h2Style});

  @override
  String get tag => MarkdownTag.h2.name;

  static CustomH2Config get darkConfig =>
      CustomH2Config(style: _h2Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}

class CustomH3Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH3Config({this.style = _h3Style});

  @override
  String get tag => MarkdownTag.h3.name;

  static CustomH3Config get darkConfig =>
      CustomH3Config(style: _h3Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}

class CustomH4Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH4Config({this.style = _h4Style});

  @override
  String get tag => MarkdownTag.h4.name;

  static CustomH4Config get darkConfig =>
      CustomH4Config(style: _h4Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}

class CustomH5Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH5Config({this.style = _h5Style});

  @override
  String get tag => MarkdownTag.h5.name;

  static CustomH5Config get darkConfig =>
      CustomH5Config(style: _h5Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}

class CustomH6Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH6Config({this.style = _h6Style});

  @override
  String get tag => MarkdownTag.h6.name;

  static CustomH6Config get darkConfig =>
      CustomH6Config(style: _h6Style.copyWith(color: Colors.white));

  @override
  HeadingDivider? get divider => null;
}
