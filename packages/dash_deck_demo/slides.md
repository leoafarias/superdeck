---
title: Introduction to Flutter
layout: cover
background: https://media.giphy.com/media/WrP3awchXRagVvRDfS/giphy.gif
---

# Introduction to Flutter

---
layout: cover
---
# What is Flutter?

Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, desktop, and embedded devices from a single codebase.

Flutter is free and open source, and its creation has been driven by the fact that developers have long desired an uncompromising UI that allows for creative expression, but is also easy to create and has great developer and tooling experience.

---
layout: twoColumn
---
## Installing Flutter
Follow the instructions [here](https://flutter.dev/docs/get-started/install) to install Flutter on your system.

::right::

```dart
// check Flutter installation
flutter doctor
```

---
layout: image
image: https://source.unsplash.com/random/900×700?runner
---

## Your first Flutter app

1. Create a new project:

```dart
flutter create my_app
```

2. Navigate into the newly created project:

```dart
cd my_app
```

3. Run your app:

```dart
flutter run
```

---

layout: twoColumnHeader
---

## Flutter's Hot Reload

Hot Reload lets you experiment, build UIs, add features, and fix bugs faster.


1. Change your code.
2. Hit 'Save' in your IDE.
3. Observe the change in your simulator.

::right::

Right content goes here

---
layout: twoColumn
---

## The Dart language

Flutter apps are written in the Dart language. Dart shares features with many languages like Java, JavaScript, C, C++, Kotlin, etc.

::right::

```dart
void main() {
  print('Hello, World!');
}
```

---
layout: twoColumn
---

## Flutter Widgets

Everything in Flutter is a widget.

Widgets describe what their view should look like given their current configuration and state.

::right::

```dart
Center(
 child: Text(
   "Hello Flutter!",
   style: TextStyle(fontSize: 32),
 ),
);
```

---
layout: cover
background: https://source.unsplash.com/random/900x700/?landscape
---

Let's see a live demo!

---
layout: twoColumn
---

# Summary and Q&A

- We installed Flutter.
- We created our first Flutter app.
- We learned about Hot Reload and Dart.
- We talked about Widgets.

::right::

Any Questions?