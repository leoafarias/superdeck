// ignore_for_file: prefer_const_constructors

import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';

const _snippets = {};
final _styles = {};

class DashDeckApp extends DashDeckShell {
  DashDeckApp({Key? key})
      : super(
          data: DashDeckData(slides: slides),
          key: key,
        );
}

List<SlideData> get slides => [
      SlideData(
        id: 'slide_0',
        content:
            '\n# Introduction to Flutter\nAuthor: Google Expert Developer\n\n```dart \{2,3\}\nclass ParsedSyntax \{\n  final String updatedContent;\n  final List<int> highlightedLines;\n\n  ParsedSyntax\(this\.updatedContent, this\.highlightedLines\);\n\}\n\n```\n\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background:
              'https://media.giphy.com/media/gicYGfRxoJlFqYpwnE/giphy.gif',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '\n## What is Flutter\?\n- \*\*Open-Source:\*\* Created by Google\n- \*\*UI Toolkit:\*\* Build natively compiled applications\n- \*\*Cross-Platform:\*\* One codebase for Android and iOS\n\n### Key Features\n- Fast Development\n- Expressive and Flexible UI\n- Native Performance\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_2',
        content:
            '\n## Flutter Architecture\n- \*\*Widgets:\*\* Building blocks of Flutter UI\n- \*\*Dart Platform:\*\* Strongly typed language by Google\n- \*\*Skia Engine:\*\* 2D rendering engine\n\n### Main Components\n- Framework\n- Engine\n- Embedder\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentRight,
          background: 'https://source.unsplash.com/random/900×700/?coding',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_3',
        content:
            '\n## Development with Flutter\n- \*\*Hot Reload:\*\* Instant updates\n- \*\*Rich Libraries:\*\* Extensive set of pre-designed widgets\n- \*\*Integration with Firebase:\*\* Backend services\n\n### Popular Packages\n- HTTP\n- Provider\n- SQFLite\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentLeft,
          background:
              'https://source.unsplash.com/random/900×700/?mobile-development',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_4',
        content:
            '\n## Design Principles\n- \*\*Material Design:\*\* Comprehensive guide\n- \*\*Cupertino Widgets:\*\* iOS-style components\n- \*\*Customization:\*\* Extensive styling options\n\n### Responsive Design\n- Adapt to different screen sizes\n- Maintain layout integrity\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentRight,
          background: 'https://source.unsplash.com/random/900×700/?app-design',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_5',
        content:
            '\n## Innovation and Community\n- \*\*State Management:\*\* Various approaches\n- \*\*Accessibility:\*\* Focus on inclusive design\n- \*\*Community Contributions:\*\* Plugins, packages, conferences\n\n### Collaboration\n- Open to contributions\n- Active developer forums\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentLeft,
          background:
              'https://source.unsplash.com/random/900×700/?technology-innovation',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_6',
        content:
            '\n## Conclusion\n- \*\*Revolutionizing Development:\*\* Cross-platform efficiency\n- \*\*Ongoing Growth:\*\* Constant updates, community-driven\n- \*\*Bright Future:\*\* Continued innovation, industry adoption\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.cover,
          background:
              'https://source.unsplash.com/random/900×700/?future-technology',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.bottomCenter,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_7',
        content:
            '\n## Platforms Supported by Flutter\nFlutter isn\'t just about iOS and Android; it\'s a multi-platform framework! Here are the platforms it supports:\n\n\| Platform       \| Description                           \|\n\|----------------\|---------------------------------------\|\n\| \*\*Android\*\*    \| For building Android apps             \|\n\| \*\*iOS\*\*        \| For creating apps on Apple devices    \|\n\| \*\*Web\*\*        \| Write web applications                \|\n\| \*\*Windows\*\*    \| Desktop applications for Windows      \|\n\| \*\*macOS\*\*      \| macOS desktop applications            \|\n\| \*\*Linux\*\*      \| Desktop applications for Linux        \|\n\n### Platform Agnostic\n- Same codebase for various platforms\n- Unified development experience\n- Increased development efficiency\n',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentRight,
          background:
              'https://source.unsplash.com/random/900×700/?flutter-platforms',
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
    ];
