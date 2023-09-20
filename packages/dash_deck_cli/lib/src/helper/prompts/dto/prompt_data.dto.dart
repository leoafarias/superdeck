import 'package:palm_api/palm_api.dart';

const defaultSafetySettings = [
  SafetySetting(
    category: HarmCategory.derogatory,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
  SafetySetting(
    category: HarmCategory.toxicity,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
  SafetySetting(
    category: HarmCategory.violence,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
  SafetySetting(
    category: HarmCategory.sexual,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
  SafetySetting(
    category: HarmCategory.medical,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
  SafetySetting(
    category: HarmCategory.dangerous,
    threshold: HarmBlockThreshold.blockOnlyHigh,
  ),
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
    this.safetySettings = defaultSafetySettings,
  });

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
        'model_name': modelName,
        'temperature': temperature,
        'candidate_count': candidateCount,
        'topK': topK,
        'topP': topP,
        'maxOutputTokens': maxOutputTokens,
        'stopSequences': stopSequences,
        'safetySettings': safetySettings.map((e) => e.toMap()).toList(),
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
