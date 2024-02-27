import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CustomH1Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH1Config({required this.style});

  @override
  String get tag => MarkdownTag.h1.name;

  @override
  HeadingDivider? get divider => null;
}

class CustomH2Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH2Config({required this.style});

  @override
  String get tag => MarkdownTag.h2.name;

  @override
  HeadingDivider? get divider => null;
}

class CustomH3Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH3Config({required this.style});

  @override
  String get tag => MarkdownTag.h3.name;

  @override
  HeadingDivider? get divider => null;
}

class CustomH4Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH4Config({required this.style});

  @override
  String get tag => MarkdownTag.h4.name;

  @override
  HeadingDivider? get divider => null;
}

class CustomH5Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH5Config({required this.style});

  @override
  String get tag => MarkdownTag.h5.name;

  @override
  HeadingDivider? get divider => null;
}

class CustomH6Config extends HeadingConfig {
  @override
  final TextStyle style;

  CustomH6Config({required this.style});

  @override
  String get tag => MarkdownTag.h6.name;

  @override
  HeadingDivider? get divider => null;
}
