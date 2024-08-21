import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';

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
