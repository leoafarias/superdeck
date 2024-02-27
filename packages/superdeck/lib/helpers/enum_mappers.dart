import 'package:flutter/material.dart';

import '../models/slide_options_model.dart';

class FlexAlignment {
  const FlexAlignment({
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  factory FlexAlignment.fromContentAlignment(ContentAlignment alignment) {
    return FlexAlignment(
      mainAxisAlignment: _mainAxisFromContentAlignment(alignment),
      crossAxisAlignment: _crossAxisFromContentAlignment(alignment),
    );
  }
}

MainAxisAlignment _mainAxisFromContentAlignment(ContentAlignment alignment) {
  if (alignment.name.startsWith(VerticalAlignment.top.name)) {
    return MainAxisAlignment.start;
  }

  if (alignment.name.startsWith(VerticalAlignment.bottom.name)) {
    return MainAxisAlignment.end;
  }

  return MainAxisAlignment.center;
}

CrossAxisAlignment _crossAxisFromContentAlignment(ContentAlignment alignment) {
  // capitalize string

  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.left.name)) {
    return CrossAxisAlignment.start;
  }

  if (alignment.name.toLowerCase().endsWith(HorizontalAlignment.right.name)) {
    return CrossAxisAlignment.end;
  }

  return CrossAxisAlignment.center;
}
