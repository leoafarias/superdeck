import 'package:superdeck_cli/src/builders/presentation_creator_prompt.dart';
import 'package:superdeck_cli/src/helper/palm_service.dart';
import 'package:palm_api/palm_api.dart';

class PromptsService {
  PromptsService._();

  static Future<String> createPresentation(
    String topic,
  ) async {
    final prompt = TextPrompt(text: presentationCreator(topic));
    print(topic);
    // final response = await _palmService.generateTextWithPrompt(prompt);
    final response = await palm.generateText(
      model: PalmModel.textBison001.name,
      prompt: prompt,
      temperature: 0.7,
      maxOutputTokens: 2000,
      topP: 0.95,
      topK: 40,
      safetySettings: [],
    );

    final candidates = response.candidates;

    if (candidates.isEmpty) {
      return '';
    }

    final firstCandidate = response.candidates.first;

    return firstCandidate.output;
  }
}
