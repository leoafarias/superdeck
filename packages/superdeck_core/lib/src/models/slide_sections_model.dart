part of 'models.dart';

@MappableEnum()
enum SectionType {
  root,
  header,
  body,
  footer,
}

@MappableEnum()
enum SubSectionType {
  content,
  image,
  widget,
}

interface class PartDto {
  const PartDto();
}

@MappableClass()
abstract class SectionDto extends PartDto with SectionDtoMappable {
  final SectionType type;

  final ContentOptions options;

  final List<ContentSectionPart> contentSections;

  SectionDto({
    required this.type,
    required this.options,
    this.contentSections = const [],
  });

  factory SectionDto.build(
    SectionType type, {
    ContentOptions? options,
  }) {
    options ??= ContentOptions();
    return switch (type) {
      SectionType.header => HeaderLayoutPart(options: options),
      SectionType.body => BodyLayoutPart(options: options),
      SectionType.footer => FooterLayoutPart(options: options),
      SectionType.root => RootLayoutPart(options: options),
    };
  }

  String get name => type.name;

  SectionDto addLine(String content) {
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

  SectionDto addSubSection(ContentSectionPart part) {
    return copyWith(contentSections: [...contentSections, part]);
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ContentSectionPart<T extends ContentOptions> extends PartDto
    with ContentSectionPartMappable {
  @MappableField()
  final String content;
  final SubSectionType type;

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
  }) : super(type: SubSectionType.content);
}

@MappableClass(discriminatorValue: 'widget')
class WidgetPart extends ContentSectionPart<WidgetOptions>
    with WidgetPartMappable {
  WidgetPart({
    required super.options,
    required super.content,
  }) : super(type: SubSectionType.widget);
}

@MappableClass(discriminatorValue: 'image')
class ImagePart extends ContentSectionPart<ImageOptions>
    with ImagePartMappable {
  ImagePart({
    required super.options,
    required super.content,
  }) : super(type: SubSectionType.image);
}

@MappableClass(discriminatorValue: 'root')
class RootLayoutPart extends SectionDto with RootLayoutPartMappable {
  RootLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionType.root,
        );
}

@MappableClass(discriminatorValue: 'header')
class HeaderLayoutPart extends SectionDto with HeaderLayoutPartMappable {
  HeaderLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionType.header,
        );
}

@MappableClass(discriminatorValue: 'body')
class BodyLayoutPart extends SectionDto with BodyLayoutPartMappable {
  BodyLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionType.body,
        );
}

@MappableClass(discriminatorValue: 'footer')
class FooterLayoutPart extends SectionDto with FooterLayoutPartMappable {
  FooterLayoutPart({
    required super.options,
    super.contentSections = const [],
  }) : super(
          type: SectionType.footer,
        );
}
