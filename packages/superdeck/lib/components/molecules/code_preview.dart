import 'package:flutter/material.dart';

class CodePreview extends StatelessWidget {
  const CodePreview({
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // final options = SlideDataProvider.of(context);
    return LayoutBuilder(builder: (context, contraints) {
      return CodePreviewScaffold(child: child);
    });
  }
}

class CodePreviewScaffold extends StatelessWidget {
  const CodePreviewScaffold({this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor:
          brightness == Brightness.dark ? Colors.black12 : Colors.grey,
      body: Center(child: child),
    );
  }
}
