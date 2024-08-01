import 'dart:convert';

class RawSlide {
  final Map<String, dynamic> data;

  const RawSlide(this.data);

  String get content => (data['content'] ?? '') as String;

  String get key => (data['key'] ?? '') as String;

  RawSlide copyWith({
    String? content,
  }) {
    return RawSlide(
      {
        ...data,
        'content': content ?? data['content'],
      },
    );
  }

  String toJson() => jsonEncode(data);
}

class RawAsset {
  final String path;
  final int width;
  final int height;

  const RawAsset({
    required this.path,
    required this.width,
    required this.height,
  });

  static RawAsset fromJson(Map<String, dynamic> json) {
    return RawAsset(
      path: json['path'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
    );
  }

  String toJson() => jsonEncode({
        'path': path,
        'width': width,
        'height': height,
      });
}
