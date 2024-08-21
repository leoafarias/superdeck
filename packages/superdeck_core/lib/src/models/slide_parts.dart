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

@MappableClass(discriminatorKey: 'type')
sealed class SectionPart extends SlidePart with SectionPartMappable {
  final SectionPartType type;

  final ContentOptions options;
  @MappableField(key: 'content_sections')
  List<ContentSectionPart> contentSections;

  SectionPart({
    required this.type,
    required this.options,
    this.contentSections = const [],
  });

  factory SectionPart.build(
    SectionPartType type,
    ContentOptions options,
  ) {
    return switch (type) {
      SectionPartType.header => HeaderLayoutPart(options),
      SectionPartType.body => BodyLayoutPart(options),
      SectionPartType.footer => FooterLayoutPart(options),
      SectionPartType.root => RootLayoutPart(options),
    };
  }

  String get name => type.name;

  void concatLine(String content) {
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

    contentSections = subSectionsCopy;
  }

  void addSubSection(ContentSectionPart part) {
    contentSections = [...contentSections, part];
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ContentSectionPart<T extends ContentOptions> extends SlidePart
    with ContentSectionPartMappable {
  @MappableField(hook: EmptyToNullHook())
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
  WidgetPart({required super.options, required super.content})
      : super(type: SubSectionPartType.widget);
}

@MappableClass(discriminatorValue: 'image')
class ImagePart extends ContentSectionPart<ImageOptions>
    with ImagePartMappable {
  ImagePart({required super.options, required super.content})
      : super(type: SubSectionPartType.image);
}

@MappableClass(discriminatorValue: 'root')
class RootLayoutPart extends SectionPart with RootLayoutPartMappable {
  RootLayoutPart(ContentOptions options)
      : super(type: SectionPartType.root, options: options);
}

@MappableClass(discriminatorValue: 'header')
class HeaderLayoutPart extends SectionPart with HeaderLayoutPartMappable {
  HeaderLayoutPart(ContentOptions options)
      : super(type: SectionPartType.header, options: options);
}

@MappableClass(discriminatorValue: 'body')
class BodyLayoutPart extends SectionPart with BodyLayoutPartMappable {
  BodyLayoutPart(ContentOptions options)
      : super(type: SectionPartType.body, options: options);
}

@MappableClass(discriminatorValue: 'footer')
class FooterLayoutPart extends SectionPart with FooterLayoutPartMappable {
  FooterLayoutPart(ContentOptions options)
      : super(type: SectionPartType.footer, options: options);
}
