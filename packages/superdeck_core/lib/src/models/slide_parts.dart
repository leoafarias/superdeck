import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_parts.mapper.dart';

@MappableEnum()
enum SectionPartType {
  root,
  header,
  body,
  footer,
}

@MappableEnum()
enum SubSectionPartType {
  content,
  image,
  widget,
}

interface class SlidePart {
  const SlidePart();
}

@MappableClass()
abstract class SectionPart extends SlidePart with SectionPartMappable {
  final SectionPartType type;

  final ContentOptions options;

  final List<ContentSectionPart> contentSections;

  SectionPart({
    required this.type,
    required this.options,
    this.contentSections = const [],
  });

  factory SectionPart.build(
    SectionPartType type, {
    ContentOptions? options,
  }) {
    options ??= ContentOptions();
    return switch (type) {
      SectionPartType.header => HeaderLayoutPart(options: options),
      SectionPartType.body => BodyLayoutPart(options: options),
      SectionPartType.footer => FooterLayoutPart(options: options),
      SectionPartType.root => RootLayoutPart(options: options),
    };
  }

  String get name => type.name;

  SectionPart addLine(String content) {
    final lastPart = contentSections.lastOrNull;
    final subSectionsCopy = [...contentSections];

    if (lastPart is ContentPart) {
      subSectionsCopy.last = lastPart.copyWith(
        content: lastPart.content + '\n' + content,
      );
    } else {
      subSectionsCopy.add(ContentPart(
        content: content,
        options: ContentOptions(),
      ));
    }

    return copyWith(contentSections: subSectionsCopy);
  }

  SectionPart addSubSection(ContentSectionPart part) {
    return copyWith(contentSections: [...contentSections, part]);
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ContentSectionPart<T extends ContentOptions> extends SlidePart
    with ContentSectionPartMappable {
  @MappableField()
  final String content;
  final SubSectionPartType type;

  final T options;

  ContentSectionPart({
    required this.type,
    required this.content,
    required this.options,
  });
}

@MappableClass(discriminatorValue: 'content')
class ContentPart extends ContentSectionPart<ContentOptions>
    with ContentPartMappable {
  ContentPart({
    required super.content,
    required super.options,
  }) : super(type: SubSectionPartType.content);
}

@MappableClass(discriminatorValue: 'widget')
class WidgetPart extends ContentSectionPart<WidgetOptions>
    with WidgetPartMappable {
  WidgetPart({
    required super.options,
    required super.content,
  }) : super(type: SubSectionPartType.widget);
}

@MappableClass(discriminatorValue: 'image')
class ImagePart extends ContentSectionPart<ImageOptions>
    with ImagePartMappable {
  ImagePart({
    required super.options,
    required super.content,
  }) : super(type: SubSectionPartType.image);
}

@MappableClass(discriminatorValue: 'root')
class RootLayoutPart extends SectionPart with RootLayoutPartMappable {
  RootLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionPartType.root,
        );
}

@MappableClass(discriminatorValue: 'header')
class HeaderLayoutPart extends SectionPart with HeaderLayoutPartMappable {
  HeaderLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionPartType.header,
        );
}

@MappableClass(discriminatorValue: 'body')
class BodyLayoutPart extends SectionPart with BodyLayoutPartMappable {
  BodyLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionPartType.body,
        );
}

@MappableClass(discriminatorValue: 'footer')
class FooterLayoutPart extends SectionPart with FooterLayoutPartMappable {
  FooterLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionPartType.footer,
        );
}
