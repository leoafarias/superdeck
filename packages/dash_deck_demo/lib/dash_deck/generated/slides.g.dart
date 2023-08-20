import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';

const _snippets = {};
final _styles = {};

class DashDeckApp extends DashDeck {
  DashDeckApp({Key? key})
      : super(
          data: DashDeckData(slides: slides),
          key: key,
        );
}

List<SlideData> get slides => [
      SlideData(
        id: 'slide_1',
        content: '# Introduction to Dlutter\nAuthor: Google Expert Developer',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.cover,
          image: 'https://source.unsplash.com/random/900×700/?flutter',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## What is Flutter\?\n- \*\*Open-Source:\*\* Created by Google\n- \*\*UI Toolkit:\*\* Build natively compiled applications\n- \*\*Cross-Platform:\*\* One codebase for Android and iOS\n\n### Key Features\n- Fast Development\n- Expressive and Flexible UI\n- Native Performance',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentLeft,
          image: 'https://source.unsplash.com/random/900×700/?programming',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## Flutter Architecture\n- \*\*Widgets:\*\* Building blocks of Flutter UI\n- \*\*Dart Platform:\*\* Strongly typed language by Google\n- \*\*Skia Engine:\*\* 2D rendering engine\n\n### Main Components\n- Framework\n- Engine\n- Embedder',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentRight,
          image: 'https://source.unsplash.com/random/900×700/?coding',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## Development with Flutter\n- \*\*Hot Reload:\*\* Instant updates\n- \*\*Rich Libraries:\*\* Extensive set of pre-designed widgets\n- \*\*Integration with Firebase:\*\* Backend services\n\n### Popular Packages\n- HTTP\n- Provider\n- SQFLite',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentLeft,
          image:
              'https://source.unsplash.com/random/900×700/?mobile-development',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.topLeft,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## Design Principles\n- \*\*Material Design:\*\* Comprehensive guide\n- \*\*Cupertino Widgets:\*\* iOS-style components\n- \*\*Customization:\*\* Extensive styling options\n\n### Responsive Design\n- Adapt to different screen sizes\n- Maintain layout integrity',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentRight,
          image: 'https://source.unsplash.com/random/900×700/?app-design',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## Innovation and Community\n- \*\*State Management:\*\* Various approaches\n- \*\*Accessibility:\*\* Focus on inclusive design\n- \*\*Community Contributions:\*\* Plugins, packages, conferences\n\n### Collaboration\n- Open to contributions\n- Active developer forums',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.contentLeft,
          image:
              'https://source.unsplash.com/random/900×700/?technology-innovation',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: 'slide_1',
        content:
            '## Conclusion\n- \*\*Revolutionizing Development:\*\* Cross-platform efficiency\n- \*\*Ongoing Growth:\*\* Constant updates, community-driven\n- \*\*Bright Future:\*\* Continued innovation, industry adoption',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.cover,
          image:
              'https://source.unsplash.com/random/900×700/?future-technology',
          imageFit: ImageFit.cover,
          contentAlignment: ContentAlignment.bottomCenter,
          styles: null,
        ),
      ),
    ];
