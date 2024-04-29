import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/services.dart';

class FileMapper extends SimpleMapper<File> {
  const FileMapper();

  @override
  File decode(Object value) {
    return File(value as String);
  }

  @override
  String encode(File self) {
    return self.path;
  }
}

class DurationMapper extends SimpleMapper<Duration> {
  const DurationMapper();

  @override
  Duration decode(Object value) {
    return Duration(milliseconds: value as int);
  }

  @override
  int encode(Duration self) {
    return self.inMilliseconds;
  }
}

class SizeMapper extends SimpleMapper<Size> {
  const SizeMapper();

  @override
  Size decode(Object value) {
    final valueMap = value as Map<String, dynamic>;

    final width = valueMap['width'] as num;
    final height = valueMap['height'] as num;

    return Size(
      width.toDouble(),
      height.toDouble(),
    );
  }

  @override
  Map<String, dynamic> encode(Size self) {
    return {"width": self.width, "height": self.height};
  }
}
