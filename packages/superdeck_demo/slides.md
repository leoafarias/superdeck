---
id: slide-1
background: https://source.unsplash.com/random/900×700/?runner
---

# H1
## H2
### H3
#### H4
##### H5
###### H6

### Paragraph

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.


---
id: slide-2
background: https://source.unsplash.com/random/900×700/?running,start
contentAlignment: centerLeft
---
# Emphaisis

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

---
id: slide-3
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?planner
---

# List

1. First ordered list item
2. Another item
⋅⋅* Unordered sub-list. 
1. Actual numbers don't matter, just that it's a number
⋅⋅1. Ordered sub-list
4. And another item.


* Unordered list can use asterisks
- Or minuses
+ Or pluses

---
id: slide-4
layout: image
imageFit: cover
image: https://source.unsplash.com/random/900×700/?water,hydration
imagePosition: right
contentAlignment: centerRight
---
# Links

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

---
id: slide-5
background: https://source.unsplash.com/random/900×700/?food,healthy
contentAlignment: bottomLeft
---

# Logo

Here's our logo (hover to see the title text):

Inline-style: 
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

Reference-style: 
![alt text][logo]


---
id: slide-6
background: https://source.unsplash.com/random/900×700/?running shoes
contentAlignment: centerLeft
---

# Inline `code` has `back-ticks around` it.

Inline `code` has `back-ticks around` it.

---
id: slide-7
background: https://source.unsplash.com/random/900×700/?inspiration
contentAlignment: bottomCenter
---

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syntax Highlight Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        home: const MyHomePage(),
      ),
    );
  }
}
 ```



---
id: slide-8
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?challenge
---
# Footnotes

Here is a simple footnote[^1].

A footnote can also have multiple lines[^2].  

You can also use words, to fit your writing style more closely[^note].

[^1]: My reference.
[^2]: Every new line should be prefixed with 2 spaces.  
  This allows you to have a footnote with multiple lines.
[^note]:
    Named footnotes will still render with numbers instead of the text but allow easier identification and linking.  
    This footnote also has been made with a different syntax using 4 spaces for new lines.
 
---
id: slide-9
---

# Tables

Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

---
id: slide-10
background: https://source.unsplash.com/random/900×700/?celebrate
contentAlignment: center
---
# Blockquotes

> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote. 

