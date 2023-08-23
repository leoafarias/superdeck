import 'package:palm_api/palm_api.dart';

//   {"category": "HARM_CATEGORY_DEROGATORY", "threshold": "4"},
//   {"category": "HARM_CATEGORY_TOXICITY", "threshold": "4"},
//   {"category": "HARM_CATEGORY_VIOLENCE", "threshold": "4"},
//   {"category": "HARM_CATEGORY_SEXUAL", "threshold": "4"},
//   {"category": "HARM_CATEGORY_MEDICAL", "threshold": "4"},
//   {"category": "HARM_CATEGORY_DANGEROUS", "threshold": "4"}

const _defaultSafetySettings = [
  SafetySetting(category: "HARM_CATEGORY_DEROGATORY", threshold: "4"),
  SafetySetting(category: "HARM_CATEGORY_TOXICITY", threshold: "4"),
  SafetySetting(category: "HARM_CATEGORY_VIOLENCE", threshold: "4"),
  SafetySetting(category: "HARM_CATEGORY_SEXUAL", threshold: "4"),
  SafetySetting(category: "HARM_CATEGORY_MEDICAL", threshold: "4"),
  SafetySetting(category: "HARM_CATEGORY_DANGEROUS", threshold: "4"),
];

class PromptData {
  final String prompt;
  final String modelName;
  final double temperature;
  final int candidateCount;
  final int topK;
  final double topP;
  final int maxOutputTokens;
  final List<String> stopSequences;
  final List<SafetySetting> safetySettings;

  PromptData({
    required this.prompt,
    required this.modelName,
    required this.temperature,
    required this.candidateCount,
    required this.topK,
    required this.topP,
    required this.maxOutputTokens,
    required this.stopSequences,
    this.safetySettings = _defaultSafetySettings,
  });

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'model_name': modelName,
        'temperature': temperature,
        'candidate_count': candidateCount,
        'top_k': topK,
        'top_p': topP,
        'max_output_tokens': maxOutputTokens,
        'stop_sequences': stopSequences,
        'safety_settings': safetySettings.map((e) => e.toMap()).toList(),
      };

  factory PromptData.fromJson(Map<String, dynamic> json) => PromptData(
        prompt: json['prompt'],
        modelName: json['model_name'],
        temperature: json['temperature'],
        candidateCount: json['candidate_count'],
        topK: json['top_k'],
        topP: json['top_p'],
        maxOutputTokens: json['max_output_tokens'],
        stopSequences: List<String>.from(json['stop_sequences'] ?? []),
        safetySettings: List<SafetySetting>.from(
          json['safety_settings']?.map(SafetySetting.fromJson) ?? [],
        ),
      );
}
