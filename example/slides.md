---
layout: widget
style: demo
widget:
  name: demo
  preview: true
  args:
    text: 'Hello World'
    height: 400.0
    width: 350.0
---

# Demo Your Code


```dart
Example(
  name: 'demo',
  schema: ExampleOptions.schema,
  builder: (args) {
    return Center(
      child: Container(
        height: args.height,
        width: args.width,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(args.text),
      ),
    );
  },
),
```
