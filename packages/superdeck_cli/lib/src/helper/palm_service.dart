import 'package:superdeck_cli/env/env.dart';
import 'package:superdeck_cli/src/helper/prompts/dto/prompt_data.dto.dart';
import 'package:palm_api/palm_api.dart';

final palm = TextService(apiKey: Env.palmApiKey);

class PalmService {
  Future<GenerateTextResponse?> generateTextWithPrompt(PromptData data) async {
    return palm.generateText(
      model: data.modelName,
      prompt: TextPrompt(text: data.prompt),
      candidateCount: data.candidateCount,
      maxOutputTokens: data.maxOutputTokens,
      stopSequences: data.stopSequences,
      safetySettings: data.safetySettings,
      temperature: data.temperature,
      topK: data.topK,
      topP: data.topP,
    );
  }
}
