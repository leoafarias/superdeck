# SuperDeck

SuperDeck enables you to craft visually appealing and interactive presentations directly within your Flutter apps, using the simplicity and power of Markdown. Tailor every aspect of your slides with comprehensive customization options, and leverage a variety of templates to bring your content to life.


## Getting Started

Follow these steps to integrate SuperDeck into your Flutter project:

1. Install the `superdeck` package by running the following command:

   ```bash
   flutter pub add superdeck
   ```

2. Import the `superdeck` package in your Dart code:

   ```dart
   import 'package:superdeck/superdeck.dart';
   ```

3. Initialize SuperDeck and run the app. The `SuperDeck.initialize()` function sets up the necessary configurations and assets for the package.

   ```dart
   void main() async {
     await SuperDeck.initialize();
     runApp(const SuperDeck());
   }
   ```

4. Create a `slides.md` file at the root of your project.

5. Configure your `pubspec.yaml` file to include the necessary assets:

   ```yaml
   flutter:
     assets:
       - assets/
       - assets/images/
   ```

   The `assets` directory is used to slide and asset references, while the `assets/images` directory is specifically used for storing images used in your presentations.

6. Start building your slides in the `slides.md` file using Markdown syntax and SuperDeck's slide templates and configurations.

## Configuration Options

Each slide in SuperDeck can be uniquely tailored through a set of configuration options defined in the YAML front matter at the beginning of each slide section in the `slides.md` file. These options control various aspects of the slide's appearance, layout, and behavior.

### Available Options

The following options are available for configuring each slide. All options are optional.

#### `title`

The title of the slide.

#### `background`

The background image that will be displayed on the slide. You can use a URL or a local asset path.

#### `content_alignment`

The alignment of the slide content. Options include:

- `top_left`, `top_center`, and `top_right`
- `center_left`, `center`, and `center_right`
- `bottom_left`, `bottom_center`, and `bottom_right`

This option allows you to position the slide content within the slide area. For example, `top_left` aligns the content to the top-left corner of the slide.

#### `layout`

Selects a slide layout template. Available options include: `simple`, `two_column`, `two_column_header`, and `image`.

## Templates

SuperDeck provides a diverse collection of templates, each designed to meet different presentation needs. From simple text slides to complex layouts with images and columns, you can easily find the right template for your content.

### Simple Template (default)

A straightforward template for your presentations.

```markdown
---
background: https://source.unsplash.com/random/900×700/?landscape
---

# Introduction to SuperDeck

Create **engaging**, **customizable** presentations within your Flutter app.
```

### Two-Column Template

Ideal for presenting comparative or complementary information side by side.

```markdown
---
layout: two_column
---

::left::
# Product A
- Feature 1
- Feature 2

::right::
# Product B
- Feature X
- Feature Y
```

To specify the content for each column, use the `::left::` and `::right::` tags. The content before the first tag will be placed in the top section of the slide. If either tag is omitted, the corresponding column will be left empty.

### Two-Column Header Template

Similar to the two-column template, but with an additional header section at the top of the slide.

```markdown
---
layout: two_column_header
---

# Product Comparison

::left::
## Product A
- Feature 1
- Feature 2
- Feature 3

::right::
## Product B
- Feature X
- Feature Y
- Feature Z
```

The content before the first tag will be placed in the header section, while the content within the `::left::` and `::right::` tags will be placed in the respective columns.

### Image Template

Display an image alongside the slide content.

```markdown
---
layout: image
image:
  src: https://source.unsplash.com/random/900×700/?nature
  fit: cover
  position: left
---

# Key Features

- Innovative design
- User-friendly
- Energy-efficient
```

The `image` option specifies the image to be displayed. It has the following sub-options:

- `src`: The URL or path to the image file.
- `fit`: How the image should be fitted within the slide. Possible values are: `fill`, `contain`, `cover`, `fit_width`, `fit_height`, `none`, `scale_down`.
- `position`: The position of the image relative to the slide content. Possible values are: `left` (image on the left, content on the right) or `right` (image on the right, content on the left).
