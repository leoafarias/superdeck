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
  List<SubSectionPart> subSections = [];

  SectionPart({
    required this.type,
    required this.options,
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
    final lastPart = subSections.lastOrNull;

    if (lastPart is ContentPart) {
      subSections.last = lastPart.copyWith(
        content: lastPart.content + '\n' + content,
      );
    } else {
      subSections.add(ContentPart(
        content: content,
        options: ContentOptions(),
      ));
    }
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class SubSectionPart<T extends ContentOptions> extends SlidePart
    with SubSectionPartMappable {
  final SubSectionPartType type;
  final T options;

  SubSectionPart({
    required this.type,
    required this.options,
  });
}

@MappableClass(discriminatorValue: SubSectionPartType.content)
class ContentPart extends SubSectionPart<ContentOptions>
    with ContentPartMappable {
  final String content;

  ContentPart({
    required this.content,
    required super.options,
  }) : super(type: SubSectionPartType.content);
}

@MappableClass(discriminatorValue: 'widget')
class WidgetPart extends SubSectionPart<WidgetOptions> with WidgetPartMappable {
  WidgetPart({
    required super.options,
  }) : super(type: SubSectionPartType.widget);
}

@MappableClass(discriminatorValue: 'image')
class ImagePart extends SubSectionPart<ImageOptions> with ImagePartMappable {
  ImagePart({
    required super.options,
  }) : super(type: SubSectionPartType.image);
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
