import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

class FooterPart extends FixedSlidePart {
  const FooterPart({
    super.key,
  });

  @override
  double get height => 0;

  @override
  Widget build(context, configuration) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('SUPERDECK'),
        ],
      ),
    );
  }
}
