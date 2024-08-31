---
style: 'here'
---
{@gist id: 5c0e154dd50af4a9ac856908061291bc flex: 5 }

![Mermaid Diagram](.superdeck/generated/mermaid_6EQHvrjD.png)

{@column}

![Mermaid Diagram](.superdeck/generated/mermaid_BTVEzSEg.png)

<!-- Notes go here -->

---
style: 'custom'
---
{@section}
{@column}
## This is an example of a widgets

{@widget name: demo}

{@column}

```dart
import 'package:flutter/material.dart';

void main() {
  final style = Style(
    $box.padding.all(),
    $box.border.all(),
  );
}

```

---
style: 'quote'
---
{@section}
{@column align: bottom_right flex: 3}
# This presentation will be great

{@column}

{@section}


{@column }
{@column flex: 2 align: top_right}
> Create your Flutter presentations faster and easier than ever.
> You can quote me on that
> ### Leo

---
style: 'show_sections'
---
{@section}
{@image src: https://picsum.photos/1200/1200?waves align: top_left fit: cover}

{@section flex: 2}
{@column flex: 2}
# Two Column HGoes here

This is a two-column layout. You can use it to compare two different concepts or ideas.


{@column}

### Section Options

Easily customize the content of each section to suit your needs.

Use front matter to define the layout of each section

---
style: 'show_sections'
---
{@section}
{@column align: bottom_right}

## First

{@column}  


## Header

{@section flex: 2}

### Left Section
Easily customize the content of each section to suit your needs.

Use front matter to define the layout of each section

{@column}

#### Section Options

```yaml
sections:
  left:
    alignment: bottom_right
    flex: 2
  right:
    alignment: bottom_left
  header:
    alignment: bottom_left
```

