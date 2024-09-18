import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

class FooterPart extends SlidePart {
  const FooterPart({
    super.key,
  });

  @override
  double get height => 40;

  @override
  Widget build(BuildContext context) {
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
