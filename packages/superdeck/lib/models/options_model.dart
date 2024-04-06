import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../helpers/json_schema.dart';

part 'options_model.mapper.dart';

@MappableClass()
class Config with ConfigMappable {
  final String? background;
  final String? style;
  final TransitionOptions? transition;

  @MappableField(key: 'content')
  final ContentOptions? contentOptions;

  const Config({
    required this.background,
    required this.style,
    required this.transition,
    required this.contentOptions,
  });

  const Config.empty()
      : background = null,
        style = null,
        contentOptions = null,
        transition = null;

  static const fromMap = ConfigMapper.fromMap;
  static const fromJson = ConfigMapper.fromJson;

  static final schema = SchemaObject(
    optional: {
      'content': ContentOptions.schema,
      "background": Schema.string,
      "style": Schema.string,
      "transition": TransitionOptions.schema,
    },
  );
}

@MappableClass()
class ContentOptions with ContentOptionsMappable {
  final ContentAlignment? alignment;
  final int? flex;

  const ContentOptions({
    this.flex,
    this.alignment,
  });

  ContentOptions merge(ContentOptions? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static const fromMap = ContentOptionsMapper.fromMap;
  static const fromJson = ContentOptionsMapper.fromJson;

  static final schema = SchemaObject(
    optional: {
      "alignment": ContentAlignment.schema,
      "flex": Schema.integer,
    },
  );
}

@MappableClass()
class ImageOptions with ImageOptionsMappable {
  final String src;
  final ImageFit? fit;
  final LayoutPosition position;
  final int flex;

  const ImageOptions({
    required this.src,
    this.fit,
    this.flex = 1,
    this.position = LayoutPosition.left,
  });

  static const fromMap = ImageOptionsMapper.fromMap;
  static const fromJson = ImageOptionsMapper.fromJson;

  static final schema = SchemaObject(
    optional: {
      "fit": ImageFit.schema,
      "position": LayoutPosition.schema,
      "flex": Schema.integer,
    },
    required: {
      "src": Schema.string,
    },
  );
}

@MappableClass(
  includeCustomMappers: [DurationMapper()],
)
class TransitionOptions with TransitionOptionsMappable {
  final TransitionType type;
  final Duration? duration;
  final Duration? delay;
  final CurveType? curve;

  const TransitionOptions({
    required this.type,
    this.duration,
    this.delay,
    this.curve,
  });

  static const fromMap = TransitionOptionsMapper.fromMap;

  static const fromJson = TransitionOptionsMapper.fromJson;

  static final schema = SchemaObject(
    required: {
      "type": TransitionType.schema,
    },
    optional: {
      "duration": Schema.integer,
      "delay": Schema.integer,
      "curve": CurveType.schema
    },
  );
}

class DurationMapper extends SimpleMapper<Duration> {
  const DurationMapper();

  @override
  Duration decode(Object value) {
    return Duration(milliseconds: value as int);
  }

  @override
  int encode(Duration self) {
    return self.inMilliseconds;
  }
}

typedef WidgetBuilderOptions = Widget Function(WidgetOptions);

@MappableClass()
class WidgetOptions with WidgetOptionsMappable {
  final String name;
  final Map<String, dynamic> args;
  final LayoutPosition position;
  final int flex;

  const WidgetOptions({
    required this.name,
    this.args = const {},
    this.flex = 1,
    this.position = LayoutPosition.left,
  });

  static const fromMap = WidgetOptionsMapper.fromMap;
  static const fromJson = WidgetOptionsMapper.fromJson;

  static final schema = SchemaObject(
    required: {
      "name": Schema.string,
    },
    optional: {
      "args": Schema.map,
      "position": LayoutPosition.schema,
      "flex": Schema.integer,
    },
  );
}

@MappableEnum()
enum ImageFit {
  fill,
  contain,
  cover,
  fitWidth,
  fitHeight,
  none,
  scaleDown;

  static final schema = SchemaEnum(
    values: ImageFit.values.map((e) => e.name.snakeCase).toList(),
  );

  BoxFit toBoxFit() {
    return switch (this) {
      ImageFit.fill => BoxFit.fill,
      ImageFit.contain => BoxFit.contain,
      ImageFit.cover => BoxFit.cover,
      ImageFit.fitWidth => BoxFit.fitWidth,
      ImageFit.fitHeight => BoxFit.fitHeight,
      ImageFit.none => BoxFit.none,
      ImageFit.scaleDown => BoxFit.scaleDown,
    };
  }
}

class LayoutType {
  const LayoutType._();
  static const simple = 'simple';
  static const image = 'image';
  static const widget = 'widget';
  static const twoColumn = 'two_column';
  static const twoColumnHeader = 'two_column_header';
  static const invalid = 'invalid';
}

@MappableEnum()
enum SyntaxHighlightTheme {
  a11yDark,
  a11yLight,
  agate,
  anOldHope,
  androidstudio,
  arduinoLight,
  arta,
  ascetic,
  atomOneDarkReasonable,
  atomOneDark,
  atomOneLight,
  brownPaper,
  codepenEmbed,
  colorBrewer,
  dark,
  defaultTheme,
  devibeans,
  docco,
  far,
  felipec,
  foundation,
  githubDarkDimmed,
  githubDark,
  github,
  gml,
  googlecode,
  gradientDark,
  gradientLight,
  grayscale,
  hybrid,
  idea,
  intellijLight,
  irBlack,
  isblEditorDark,
  isblEditorLight,
  kimbieDark,
  kimbieLight,
  lightfair,
  lioshi,
  magula,
  monoBlue,
  monokaiSublime,
  monokai,
  nightOwl,
  nnfxDark,
  nnfxLight,
  nord,
  obsidian,
  pandaSyntaxDark,
  pandaSyntaxLight,
  paraisoDark,
  paraisoLight,
  pojoaque,
  purebasic,
  qtcreatorDark,
  qtcreatorLight,
  rainbow,
  routeros,
  schoolBook,
  shadesOfPurple,
  srcery,
  stackoverflowDark,
  stackoverflowLight,
  sunburst,
  tokyoNightDark,
  tokyoNightLight,
  tomorrowNightBlue,
  tomorrowNightBright,
  vs,
  vs2015,
  xcode,
  xt256;

  static final schema = SchemaEnum(
    values: SyntaxHighlightTheme.values.map((e) => e.name.snakeCase).toList(),
  );
}

@MappableEnum()
enum TransitionType {
  // FadeIn Animations
  fadeIn,
  fadeInDown,
  fadeInDownBig,
  fadeInUp,
  fadeInUpBig,
  fadeInLeft,
  fadeInLeftBig,
  fadeInRight,
  fadeInRightBig,

  // FadeOut Animations
  fadeOut,
  fadeOutDown,
  fadeOutDownBig,
  fadeOutUp,
  fadeOutUpBig,
  fadeOutLeft,
  fadeOutLeftBig,
  fadeOutRight,
  fadeOutRightBig,

  // BounceIn Animations
  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,

  // ElasticIn Animations
  elasticIn,
  elasticInDown,
  elasticInUp,
  elasticInLeft,
  elasticInRight,

  // SlideIns Animations
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,

  // FlipIn Animations
  flipInX,
  flipInY,

  // Zooms
  zoomIn,
  zoomOut,

  // SpecialIn Animations
  jelloIn,

  // Attention Seeker
  bounce,
  dance,
  flash,
  pulse,
  roulette,
  shakeX,
  shakeY,
  spin,
  spinPerfect,
  swing;

  static final schema = SchemaEnum(
    values: TransitionType.values.map((e) => e.name.snakeCase).toList(),
  );
}

@MappableEnum()
enum CurveType {
  ease,
  bounceIn,
  bounceOut,
  easeIn,
  easeInOut,
  easeOut,
  elasticIn,
  elasticInOut,
  elasticOut,
  fastLinearToSlowEaseIn,
  fastOutSlowIn,
  linear,
  decelerate,
  slowMiddle,
  linearToEaseOut;

  static final schema = SchemaEnum(
    values: CurveType.values.map((e) => e.name.snakeCase).toList(),
  );
}

@MappableEnum()
enum LayoutPosition {
  left,
  right,
  top,
  bottom;

  static final schema = SchemaEnum(
    values: LayoutPosition.values.map((e) => e.name.snakeCase).toList(),
  );
}

@MappableEnum()
enum ContentAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight;

  static final schema = SchemaEnum(
    values: ContentAlignment.values.map((e) => e.name.snakeCase).toList(),
  );

  CrossAxisAlignment toCrossAxisAlignment() {
    switch (this) {
      // If the alignment is left align start
      case ContentAlignment.topLeft:
      case ContentAlignment.centerLeft:
      case ContentAlignment.bottomLeft:
        return CrossAxisAlignment.start;

      // If the alignment is right align end
      case ContentAlignment.topRight:
      case ContentAlignment.centerRight:
      case ContentAlignment.bottomRight:
        return CrossAxisAlignment.end;
      // If the alignment is center align center
      default:
        return CrossAxisAlignment.center;
    }
  }

  MainAxisAlignment toMainAxisAlignment() {
    switch (this) {
      // If the alignment is top align start
      case ContentAlignment.topLeft:
      case ContentAlignment.topCenter:
      case ContentAlignment.topRight:
        return MainAxisAlignment.start;

      // If the alignment is bottom align end
      case ContentAlignment.bottomLeft:
      case ContentAlignment.bottomCenter:
      case ContentAlignment.bottomRight:
        return MainAxisAlignment.end;

      // If the alignment is center align center
      default:
        return MainAxisAlignment.center;
    }
  }
}
