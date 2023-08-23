import 'package:dash_deck_cli/src/helper/palm_service.dart';
import 'package:dash_deck_cli/src/helper/prompts/dto/prompt_data.dto.dart';
import 'package:dash_deck_cli/src/helper/prompts/dto/prompt_responses.dto.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

final _defaultSafetySettings = [
  {"category": "HARM_CATEGORY_DEROGATORY", "threshold": "4"},
  {"category": "HARM_CATEGORY_TOXICITY", "threshold": "4"},
  {"category": "HARM_CATEGORY_VIOLENCE", "threshold": "4"},
  {"category": "HARM_CATEGORY_SEXUAL", "threshold": "4"},
  {"category": "HARM_CATEGORY_MEDICAL", "threshold": "4"},
  {"category": "HARM_CATEGORY_DANGEROUS", "threshold": "4"}
];

class PromptsService {
  PromptsService._();
  static PalmService _palmService = PalmService();
  static Future<SlideData> createSlide(
    PromptPresentationOutlineResponse outline,
    String topic,
  ) async {
    final data = {
      "prompt":
          "You are tasked with designing a slide presentation focused on various topics. Your creations are known for being concise, impactful, and engaging. As a guideline for your design:\n\nStart with a main title beginning with \"#\".\nFollow with a subtitle beginning with \"##\".\nUse bullet points or tables for the main content. Ensure consistency in formatting:\nBullet points should start with a capital letter.\nAvoid overly verbose explanations; aim for clarity and brevity.\nWhen contrasting or comparing topics, consider using tables for clarity.\nRemember, the content needs to fit onto a single slide, so be succinct.\nYour mission is to convey the essence of the topic ${outline.topic} in an informative yet engaging manner.\ninput: LLM Development vs. Traditional Development\noutput: # LLM Development vs. Traditional Development\n## Key Distinctions\n- LLM: Bypasses training, focuses on prompt design.\n- Traditional: Requires ML expertise, intensive training, hardware considerations.\ninput: What problems LLM Solves?\noutput: # LLM's Solutions\n## Addressing Language Complexities\n- Mastery in entity extraction, classification, and summarization.\n- Proficient in sentiment analysis and translation.\ninput: Prompt Design\noutput: # Prompt Design\n## Understanding Its Art\n- Creating prompts for desired LLM responses.\n- Balancing instructions and context.\ninput: Benefits of LLMs\noutput: # LLM Advantages\n## Why Opt for Large Language Models?\n- Multitaskers: One model, varied tasks.\n- Efficient and scalable: Needs minimal fine-tuning data.\ninput: Prompt design vs Prompt engineering\noutput: # Prompt Creation & Optimization\n## Distinguishing the Two\n- Design: Crafting for desired outputs.\n- Engineering: Fine-tuning for diverse applications.\ninput: What is prompt design in LLMs?\noutput: # Prompt Design in LLMs\n## Influencing Model Output\n- Quality of input shapes output caliber.\ninput: Examples of Prompt Design\noutput: # Practical Prompt Design\n## Diverse LLM Tasks\n- Social Media: Crafting thankful tweets.\n- Literature: Poems on melancholic subjects.\n- Professional: Emailing for a pay hike.\ninput: Cats vs. Dogs\noutput: # Cats vs. Dogs\n## Distinct Companions\n- Cats: Independent, serene, self-grooming.\n- Dogs: Social, trainable, enthusiastic about games.\ninput: What's inside a Cell?\noutput: # Cellular Components\n## Life's Building Blocks\n- Key parts: Nucleus, mitochondria, cell membrane.\n- Functions: Energy production, protein creation.\ninput: Digital vs. Traditional Marketing\noutput: # Digital vs. Traditional Marketing\n## The Advertising Landscape\n- Digital: Online presence, SEO, analytics.\n- Traditional: Print, TV & radio, limited tracking.\ninput: Plant-Based Diet Benefits\noutput: # Plant-Based Diet\n## Benefits for Body & Planet\n- Promotes heart health, natural weight loss.\n- Eco-friendly, reduced cancer risk.\ninput: Explain the difference between text summarization and question answering\noutput: # Summarization vs. Q&A\n## AI's Language Tasks\n| Task                 | Objective           | Output |\n|----------------------|----------------------|-------|\n| Text Summarization   | Condense text       | Shortened version |\n| Question Answering   | Answer based on text| Direct answer    |\ninput: $topic\noutput:",
      "model_name": "models/text-bison-001",
      "temperature": 0.7,
      "candidate_count": 1,
      "top_k": 40,
      "top_p": 0.95,
      "max_output_tokens": 1024,
      "stop_sequences": [],
    };
    final prompt = PromptData.fromJson(data);
    final response = await _palmService.generateTextWithPrompt(prompt);

    final firstCandidate = response?.candidates?.first;

    if (firstCandidate == null) {
      throw Exception('Unable to generate slide');
    }

    // Create a guid
    final id = '${DateTime.now().millisecondsSinceEpoch}';

    return SlideData(
      id: id,
      content: firstCandidate.output,
    );
  }

  static Future<PromptPresentationOutlineResponse> createPresentationOutline(
      String topic) async {
    final data = {
      "prompt":
          "You are an expert slide presentation creator. You specialize in impactful and engaging slide content, that is able to be informative, entertaining, and engaging. \ninput: Flutter framework\noutput: {\"topic\":\"Flutter framework\",\"slides\":[\"Introduction to Flutter Framework\",\"What is Flutter\",\"Key Flutter Features & Architecture\",\"Why Flutter uses Dart\",\"Flutter Installation & Setup\",\"UI Development with Flutter\",\"Flutter vs. Other Frameworks\",\"Conclusion & Q&A\"]}\ninput: Brazilian culture\noutput: {\"topic\":\"Brazilian Culture\",\"slides\":[\"Introduction to Brazilian Culture\",\"Historical Background of Brazil\",\"Language & Literature\",\"The Arts - Music, Theatre, Dance & Visual Arts\",\"Brazilian Cuisine & Its Diversity\",\"Festivals & Traditions\",\"Sports Culture - Beyond Just Football\",\"Brazil's Natural Beauty: Landmarks and Destinations\",\"Conclusion & Q&A\"]}\ninput: How to become a great Flutter developer\noutput: {\"topic\":\"How to become a great Flutter developer\",\"slides\":[\"Introduction: The Journey to Becoming a Great Flutter Developer\",\"Understanding Flutter: An Overview\",\"Mastering Dart: The Language Behind Flutter\",\"Exploring Flutter Widgets: The Building Blocks of Flutter Apps\",\"Learning about State Management in Flutter\",\"Creating Responsive User Interfaces\",\"Best practices: Working with APIs, Databases, and Libraries\",\"Testing and Debugging Flutter Applications\",\"Continuous Learning: Keeping up with Flutter Updates & Community\",\"Building a Portfolio: Steps to Gain Real-World Experience\",\"Conclusion: Key Takeaways & Q&A\"]}\ninput: How to microwave water\noutput: {\"topic\":\"How to microwave water\",\"slides\":[\"How to Microwave Water: The Right Way\",\"Step 1: Get the Right Container\",\"Step 2: Add Water to the Container\",\"Step 3: Place the Container in the Microwave\",\"Step 4: Set the Microwave Power and Time\",\"Step 5: Let the Water Cool\",\"Step 6: Enjoy Your Hot Water!\",\"Conclusion & Q&A\"]}\ninput: Start running 5k\noutput: {\"topic\":\"How to Start Running 5k\",\"slides\":[\"How to Start Running 5k: The Ultimate Guide\",\"Step 1: Set Your Goals\",\"Step 2: Get the Right Gear\",\"Step 3: Start Slowly and Gradually\",\"Step 4: Cross-Train to Avoid Injury\",\"Step 5: Fuel Your Body for Success\",\"Step 6: Stay Motivated\",\"Step 7: Deal with Setbacks\",\"Step 8: Celebrate Your Accomplishment!\",\"Conclusion & Q&A\"]}\ninput: What are the benefits of meditation\noutput: {\"topic\":\"Benefits of Meditation\",\"slides\":[\"Introduction to Meditation\",\"What is Meditation?\",\"The Benefits of Meditation\",\"How to Meditate\",\"Meditation Techniques\",\"Benefits of Meditation for Stress Reduction\",\"Benefits of Meditation for Sleep\",\"Benefits of Meditation for Mental Health\",\"Benefits of Meditation for Physical Health\",\"Benefits of Meditation for Creativity\",\"Benefits of Meditation for Spiritual Growth\",\"Conclusion & Q&A\"]}\ninput: How to use a bicycle pump\noutput: {\"topic\":\"How to use a bicycle pump\",\"slides\":[\"How to Use a Bicycle Pump: The Right Way\",\"Step 1: Choose the Right Pump\",\"Step 2: Attach the Pump to Your Bike\",\"Step 3: Inflate Your Tires to the Correct Pressure\",\"Step 4: Disconnect the Pump from Your Bike\",\"Step 5: Store the Pump Safely\",\"Conclusion & Q&A\"]}\ninput: How to improve your sleep\noutput: {\"topic\":\"How to Improve Your Sleep\",\"slides\":[\"How to Improve Your Sleep: A Guide for Better Rest\",\"Step 1: Create a Sleep-Friendly Bedtime Routine\",\"Step 2: Stick to a Regular Sleep Schedule\",\"Step 3: Create a Dark, Quiet, and Cool Bedroom\",\"Step 4: Avoid Caffeine and Alcohol Before Bed\",\"Step 5: Get Regular Exercise, But Not Too Close to Bedtime\",\"Step 6: Manage Stress and Anxiety\",\"Step 7: See a Doctor if You Have a Sleep Disorder\",\"Conclusion & Q&A\"]}\ninput: $topic\noutput:",
      "model_name": "models/text-bison-001",
      "temperature": 0.7,
      "candidate_count": 1,
      "top_k": 40,
      "top_p": 0.95,
      "max_output_tokens": 1024,
      "stop_sequences": [],
      "safety_settings": _defaultSafetySettings,
    };
    final prompt = PromptData.fromJson(data);

    final response = await _palmService.generateTextWithPrompt(prompt);

    final firstCandidate = response?.candidates?.first;

    if (firstCandidate == null) {
      throw Exception('Unable to generate presentation outline');
    }

    return PromptPresentationOutlineResponse.fromJson(firstCandidate.output);
  }
}
