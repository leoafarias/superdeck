import 'dart:convert';

import 'package:collection/collection.dart';

class PromptPresentationOutlineResponse {
  final String topic;
  final List<String> slides;

  PromptPresentationOutlineResponse({
    required this.topic,
    required this.slides,
  });

  PromptPresentationOutlineResponse copyWith({
    String? topic,
    List<String>? slides,
  }) {
    return PromptPresentationOutlineResponse(
      topic: topic ?? this.topic,
      slides: slides ?? this.slides,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'slides': slides,
    };
  }

  factory PromptPresentationOutlineResponse.fromMap(Map<String, dynamic> map) {
    return PromptPresentationOutlineResponse(
      topic: map['topic'] ?? '',
      slides: List<String>.from(map['slides']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PromptPresentationOutlineResponse.fromJson(String source) {
    return PromptPresentationOutlineResponse.fromMap(json.decode(source));
  }

  @override
  String toString() =>
      'PromptPresentationOutlineResponse(topic: $topic, slides: $slides)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is PromptPresentationOutlineResponse &&
        other.topic == topic &&
        listEquals(other.slides, slides);
  }

  @override
  int get hashCode => topic.hashCode ^ slides.hashCode;
}
