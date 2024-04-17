import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:signals/signals_flutter.dart';

import '../../models/options_model.dart';
import '../../providers/superdeck_controller.dart';
import '../../styles/style_spec.dart';
import '../atoms/markdown_viewer.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.data,
    required this.options,
    super.key,
  });

  final String data;
  final ContentOptions? options;

  @override
  Widget build(context) {
    final spec = SlideSpec.of(context);

    final alignment = options?.alignment ?? ContentAlignment.center;

    final assets = superDeck.assets.watch(context);

    return AnimatedMixedBox(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer.copyWith(
        alignment: alignment.toAlignment(),
      ),
      child: SingleChildScrollView(
        child: IntrinsicWidth(
          child: AnimatedMarkdownViewer(
            content: data,
            spec: spec,
            assets: assets,
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }
}
