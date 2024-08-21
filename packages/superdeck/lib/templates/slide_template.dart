import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../components/molecules/slide_content.dart';

class SlideTemplate extends StatelessWidget {
  final Slide config;
  const SlideTemplate(
    this.config, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: config.sections.map((section) {
        final sectionFlex = section.options.flex ?? 1;

        return Expanded(
          flex: sectionFlex,
          child: Row(
            children: section.contentSections.map((part) {
              return Expanded(
                flex: part.options.flex ?? 1,
                child: switch (part) {
                  (ImagePart p) => ImageBlock(
                      options: p.options,
                    ),
                  (ContentPart p) => ContentBlock(
                      content: p.content,
                      options: p.options,
                    ),
                  (WidgetPart p) => WidgetBlock(
                      options: p.options,
                    ),
                },
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
