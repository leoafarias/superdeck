import 'package:flutter/material.dart';
import 'package:mesh/mesh.dart';
import 'package:superdeck/superdeck.dart';

Color _colorFromHex(String hexString) {
  hexString = hexString.trim();
  if (hexString.isEmpty) {
    return Colors.black; // Default color if null or empty
  }
  hexString = hexString.replaceAll(RegExp(r'[^a-fA-F0-9]'), '');
  hexString = hexString.replaceAll('#', '');
  if (hexString.length == 6) {
    hexString = 'FF$hexString'; // Add opacity if not provided
  }
  return Color(int.parse(hexString, radix: 16));
}

const _defaultColors = [
  Color.fromARGB(255, 239, 0, 0),
  Color.fromARGB(255, 121, 19, 255),
  Color.fromARGB(255, 160, 155, 24),
  Color.fromARGB(255, 0, 221, 255),
];

OMeshRect _meshBuilder(List<Color> colors) {
  return OMeshRect(
    width: 2,
    height: 2,
    fallbackColor: const Color(0xff0e0e0e),
    backgroundColor: const Color(0x00d6d6d6),
    vertices: [
      OVertex(0, 0), OVertex(1, 0), // Row 1
      OVertex(0, 1), OVertex(1, 1), // Row 2
    ],
    colors: colors,
  );
}

class _CustomBackgroundOptions {
  final List<Color> _colors;

  const _CustomBackgroundOptions({
    List<Color> colors = const [],
  }) : _colors = colors;

  static _CustomBackgroundOptions fromMap(Map<String, Object?>? map) {
    if (map == null) {
      return const _CustomBackgroundOptions();
    }
    return _CustomBackgroundOptions(
      colors: (map['colors'] as List<dynamic>? ?? const []).map((color) {
        return _colorFromHex(color.toString());
      }).toList(),
    );
  }

  static _CustomBackgroundOptions fromConfiguration(SlideConfiguration config) {
    return _CustomBackgroundOptions.fromMap(config.slide.options?.args);
  }

  List<Color> get colors {
    return _defaultColors.asMap().entries.map((entry) {
      final index = entry.key;
      return index < _colors.length ? _colors[index] : entry.value;
    }).toList();
  }
}

class BackgroundPart extends StatelessWidget {
  const BackgroundPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final options = _CustomBackgroundOptions.fromConfiguration(
        context.slide,
      );

      return AnimatedOMeshGradient(
          mesh: _meshBuilder(options.colors), duration: Durations.long4);
    });
  }
}
