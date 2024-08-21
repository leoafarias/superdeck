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

class EmptyIterableToNullHook extends MappingHook {
  const EmptyIterableToNullHook();
  dynamic afterEncode(Object? value) {
    if (value is Iterable && value.isEmpty) {
      return null;
    }

    if (value is Map && value.isEmpty) {
      return null;
    }

    if (value is String && value.isEmpty) {
      return null;
    }

    if (value is List && value.isEmpty) {
      return null;
    }

    if (value is Set && value.isEmpty) {
      return null;
    }

    return value;
  }
}
