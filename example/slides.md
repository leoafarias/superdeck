---
style: cover
background: https://source.unsplash.com/people-watching-concert-during-night-time-blgOFmPIlr0
content:
  alignment: center
---

# Wild Ones
 
SuperDeck is a Flutter package that allows you to create beautiful presentations using Markdown.


---
style: quote
layout: image
options:
  src: https://source.unsplash.com/people-watching-concert-during-night-time-blgOFmPIlr0
  fit: cover
  position: right
content:
  alignment: bottom_right
  flex: 1
---


> If you want to go fast, go alone. 
> If you want to go far, go together.
> ### African Proverb

---
layout: widget
options:
  name: demo
  position: right
  args:
    text: Awesome Widget
    height: 200.0
    width: 500.0
---

This is an example of an awesome widget


---
layout: two_column_header
content:
  alignment: center
sections:
  left:
    alignment: bottom_right
    flex: 2
  right:
    alignment: bottom_left
  header:
    alignment: bottom_left
---

# Two Column Header

This is your main header, providing a context or introducing the core concept covered in this slide.

::left::

### Left Heading
- Point A
- Point B
- Point C

::right::

### Right Heading
- Point X
- Point Y
- Point Z



---
layout: image
options:
  src: https://source.unsplash.com/random/900×700/?nature
  fit: cover
  position: left
  flex: 1
---

# Key Features

- Innovative design
- User-friendly
- Energy-efficient

---
title: "Slide 2: Text Styling"
---

**Bold Text**

*Italic Text*

~~Strikethrough~~

`Inline Code`

---
title: "Slide 3: Links and Images"
---

[Link](https://github.com)

![Unsplash Image](https://source.unsplash.com/random/300x200/?landscape)


---
style: quote
layout: image
options:
  src: https://source.unsplash.com/random/900×700/?inspiration
  fit: cover
  position: right
content:
  alignment: bottom_right
---


> If you want to go fast, go alone. 
> If you want to go far, go together.
> ### African Proverb

---
---

```dart {1, 3-8}
int factorial(int n) {
  if (n == 0) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}
```

---
title: "Slide 6: Lists"
---

1. Ordered list item 1
2. Ordered list item 2

- Unordered list item 1
- Unordered list item 2

---
title: "Slide 7: Tables"
---

| Header 1 | Header 2 |
|----------|----------|
| Cell 1A  | Cell 1B  |
| Cell 2A  | Cell 2B  |

---
title: "Mermaid example"
layout: two_column
---

::left::

```mermaid
flowchart TD
    A[This is crazy] -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-car Car]
  
```
::right::

## Mermaid Example

---
title: "Slide 8: Task Lists"
layout: two_column
---

::left::

- [ ] Task List Item 1
- [x] Task List Item 2

::right::

#### Subtask

- [x] foo
  - [ ] bar
  - [x] baz
- [ ] bim

---
title: Dividers
---

_____
Dividers
____

---
title: Code rendering performance
---

```dart
class SyntaxTags {
  const SyntaxTags._();
  static final left = '::left::';
  static final right = '::right::';
  static final content = '::content::';
}

Map<String, List<String>> parseContentWithTags(
    String input, List<String> tags) {
  final Map<String, List<String>> parsedContent = {};
  int lastTagEndIndex = 0;
  String currentTag = SyntaxTags.content;

  for (int i = 0; i < input.length; i++) {
    for (String tag in tags) {
      if (input.substring(i).startsWith(tag)) {
        // Add the content before this tag to the list
        final content = input.substring(lastTagEndIndex, i).trim();
        if (content.isNotEmpty) {
          parsedContent.putIfAbsent(currentTag, () => []).add(content);
        }

        // Update the current tag and last tag end index
        currentTag = tag;
        lastTagEndIndex = i + tag.length;

        // Skip the characters of this tag
        i += tag.length - 1;
        break;
      }
    }
  }

  // Add remaining content if any
  if (lastTagEndIndex < input.length) {
    final content = input.substring(lastTagEndIndex).trim();
    if (content.isNotEmpty) {
      parsedContent.putIfAbsent(currentTag, () => []).add(content);
    }
  }

  return parsedContent;
}
```
