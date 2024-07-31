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
