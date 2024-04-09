import 'package:flutter/material.dart';

class CodePreview extends StatelessWidget {
  const CodePreview({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // final options = SlideDataProvider.of(context);
    return Center(child: child);
  }
}
