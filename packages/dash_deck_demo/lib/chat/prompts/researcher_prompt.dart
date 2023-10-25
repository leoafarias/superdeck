import 'package:dash_deck_demo/env/env.dart';
import 'package:palm_api/palm_api.dart';

final _text = TextService(apiKey: Env.palmApiKey);

const promptString =
    '''As an AI assistant researcher, when a user provides a topic, your task is to provide comprehensive information relating to the topic. This information will serve as foundational material to help the user produce a detailed presentation. 
input: Start running a 5k
output: # Start Running a 5K

## Introduction
Running a 5K is an excellent goal for beginners and seasoned runners alike. It serves as a compelling challenge that requires both physical and mental preparation. This presentation will guide you through the essentials of training for, and successfully completing, a 5K run.

---

## Key Themes

### 1. Training Regimens
- Importance of a structured training plan
- Week-by-week training breakdown
- Cross-training and rest days

### 2. Nutritional Considerations
- The role of carbohydrates, proteins, and fats in endurance running
- Hydration strategies
- Pre-race and post-race nutrition

### 3. Mental Preparation Strategies
- Setting achievable goals
- Visualization techniques
- Coping with race-day anxiety

---

## Relevant Facts and Information
- According to Runner's World, a beginner should train for at least 8 weeks before attempting a 5K.
- Carb-loading, a strategy often employed by marathoners, isn't as effective for a 5K race. Your body already stores enough glycogen to get you through.
- A study found that elite runners often use positive self-talk and imagery to boost performance, skills that can be adopted by any runner.

---

## Relevant Quotes
1. "To give anything less than your best is to sacrifice the gift." - Steve Prefontaine
2. "It's not the will to win that matters—everyone has that. It's the will to prepare to win that matters." - Paul "Bear" Bryant

input: How to Improve Your Sleep
output: # How to Improve Your Sleep

## Introduction
Improving sleep quality is an essential aspect of overall well-being, impacting everything from cognitive function to emotional stability. In a world brimming with distractions and stressors, achieving restful sleep is more important than ever. This presentation aims to provide a comprehensive guide on enhancing sleep by delving into the mechanics of sleep cycles, lifestyle factors, and practical strategies for improvement.

---

## Key Themes

### 1. Understanding Sleep Mechanics
- Importance of REM and non-REM sleep
- Circadian rhythm and its effect on sleep quality
- Sleep cycles and their durations

### 2. Lifestyle Factors Affecting Sleep
- Impact of diet and exercise
- The role of stress and anxiety
- Substance abuse and sleep disorders

### 3. Practical Strategies for Sleep Improvement
- Sleep environment optimization (lighting, temperature, etc.)
- Sleep hygiene practices
- Sleep aids and their effectiveness

---

## Relevant Facts and Information
- **Understanding Sleep Mechanics**: REM sleep contributes to cognitive functions, while non-REM sleep is essential for physical repair.
- **Lifestyle Factors Affecting Sleep**: Exercise increases the duration of deep sleep, whereas caffeine can drastically reduce the quality of sleep.
- **Practical Strategies for Sleep Improvement**: Studies show that a cool room (between 60-67°F) can improve sleep quality.

---

## Relevant Quotes
1. "Sleep is the best meditation." - Dalai Lama
2. "The future is shaped by your dreams, so stop wasting time and go to sleep!" - Anonymous


input: Building your first flutter app
output: # Building Your First App in Flutter

## Introduction
Creating your first app in Flutter can be a rewarding experience. Flutter offers a rich set of tools and libraries for building natively compiled applications for mobile, web, and desktop. This guide will walk you through the process of developing your first Flutter app, focusing on foundational concepts, project structure, and best practices.

---

## Key Themes

### 1. Setting Up Development Environment
- Flutter SDK installation
- IDE setup (Visual Studio Code, IntelliJ, etc.)
- Creating a new Flutter project
  **Interesting Fact**: Flutter allows you to build for iOS and Android from a single codebase.

### 2. Basic Flutter Concepts
- Widgets and their properties
- State management solutions
- Building UI with widget trees
  **Interesting Fact**: The `Scaffold` widget is like the root of your app's visual structure, offering app bar, body content, and navigation drawer options.

### 3. Your First Flutter App
- "Hello, World!" in Flutter
- Adding functionality
- Running the app on an emulator or physical device
  **Interesting Fact**: Flutter's hot reload feature lets you see changes instantly without rebuilding the whole app, making development faster.

---

## Interesting Facts
- Flutter was developed by Google and is used in some of the company's flagship applications.
- Widgets in Flutter are inspired by React's component-based architecture.
- Dart, the language behind Flutter, compiles to native code, offering performance advantages over traditional hybrid frameworks.

---

## Relevant Facts and Information
- **Setting Up Development Environment**: Flutter's versatility means it can run on various IDEs, not just Android Studio.
- **Basic Flutter Concepts**: Understanding the widget lifecycle can help in better state management.
- **Your First Flutter App**: You can run your Flutter app on the web with minimal changes to the existing codebase, thanks to Flutter Web.

---

## Relevant Quotes
1. "Code is like humor. When you have to explain it, it’s bad." - Cory House
2. "First, solve the problem. Then, write the code." - John Johnson


input: how to take care of a baby
output: # How to Take Care of a Baby

## Introduction
Taking care of a baby is a challenging yet rewarding experience that requires attention to various aspects including health, development, and emotional well-being. This guide aims to provide comprehensive insights and practical advice for new parents and caregivers on how to ensure a baby's well-rounded development and care.

---

## Key Themes

### 1. Feeding and Nutrition
- Breastfeeding vs. formula feeding
- Introduction of solids
- Importance of vitamins and hydration

  **Interesting Fact**: Did you know breast milk changes its nutritional profile as the baby grows to meet their changing needs?

### 2. Health and Safety
- Immunization schedule
- Baby-proofing the home
- Regular check-ups and milestones

  **Interesting Fact**: A newborn baby has more bones than an adult, as some bones fuse together as they grow.

### 3. Development and Well-being
- Importance of sleep and sleep training
- Developmental milestones
- Emotional well-being and bonding

  **Interesting Fact**: Babies start learning language while they are still in the womb, particularly during the last ten weeks of pregnancy.

---

## Interesting Facts
- The soft spot on a baby's head enables easier passage through the birth canal and allows for rapid brain growth.
- Babies have a natural reflex to grasp objects, which is so strong that a newborn can support their own body weight for a short period.
- Newborns can recognize their mother's voice from birth, but it takes a few weeks to months to visually recognize their mother.

---

## Relevant Facts and Information
- **Feeding and Nutrition**: Lack of certain nutrients in the first 1,000 days can lead to irreversible developmental issues.
- **Health and Safety**: Sudden Infant Death Syndrome (SIDS) risks can be reduced by placing the baby on their back to sleep.
- **Development and Well-being**: Baby massage can promote emotional bonding and even improve sleep and digestion.

---

## Relevant Quotes
1. "Making the decision to have a child is momentous. It is to decide forever to have your heart go walking around outside your body." - Elizabeth Stone
2. "A baby is born with a need to be

input: Importance of Prompt Design in Large Language Models
output: # Importance of Prompt Design in Large Language Models (LLMs)

## Introduction
The effectiveness of Large Language Models (LLMs) is not solely dependent on their architecture or training data but also on the quality of prompts provided to them. Prompt design can influence the accuracy, coherence, and contextuality of the model's responses. This presentation aims to shed light on the complexities and significance of prompt design in the realm of LLMs.

---

## Key Themes

### 1. Fundamentals of Prompt Design
- Anatomy of a prompt
- Open-ended vs. closed-ended prompts
- Use of tokens and keywords

### 2. Impact on Model Performance
- Influence on response length and detail
- Effect on the contextual relevance of the output
- Importance for specialized applications (e.g., medical, legal)

### 3. Best Practices and Techniques
- A/B Testing of prompts
- User-centric design approaches
- Industry standards and guidelines

---

## Interesting Facts
- In "zero-shot" learning scenarios, the effectiveness of the prompt can make or break the model's ability to understand the task.
- The term "prompt engineering" is emerging as a specialized field focused on the design and optimization of prompts.
- Advanced models like GPT-4 can understand a series of prompts in a conversational context, improving the coherency of the dialogue.

---

## Relevant Facts and Information
- **Fundamentals of Prompt Design**: The optimal number of tokens in a prompt can vary depending on the complexity of the task.
- **Impact on Model Performance**: In specialized fields, a well-designed prompt can be the difference between a useful tool and an unreliable one.
- **Best Practices and Techniques**: Industry guidelines are emerging that standardize the formulation of prompts for better reproducibility of results.

---

## Relevant Quotes
1. "The limits of my language mean the limits of my world." - Ludwig Wittgenstein
2. "If you can't explain it simply, you don't understand it well enough." - Albert Einstein


input: How to Train for an Ironman
output: # How to Train for an Ironman

## Introduction
Training for an Ironman is an intense, multi-faceted commitment that tests not only one's physical capabilities but also mental resilience. This guide aims to equip you with the necessary knowledge and strategies to successfully complete an Ironman, from mastering the three disciplines to optimizing your nutrition and recovery.

---

## Key Themes

### 1. Understanding the Ironman Components
- Overview of the swim, bike, and run segments
- Essential gear for each discipline
- Common mistakes and how to avoid them

### 2. Training Plans and Schedules
- Building a realistic training schedule
- Periodization and training cycles
- Balancing training with everyday life

### 3. Nutrition and Recovery
- Importance of macronutrients and hydration
- Fueling strategies during training and the race
- Recovery techniques and their significance

---

## Interesting Facts
- Ironman triathlons originally started as a challenge among a group of Navy Seals.
- The current world record for completing an Ironman is 7 hours, 35 minutes, and 39 seconds, set by Jan Frodeno in 2016.
- The oldest person to complete an Ironman was 84 years old.

---

## Relevant Facts and Information
- **Understanding the Ironman Components**: Failing to prepare for the transitions between disciplines can cost you valuable time.
- **Training Plans and Schedules**: Overtraining is a common mistake that can lead to injuries and burnout.
- **Nutrition and Recovery**: Electrolyte imbalance during the race can lead to severe medical conditions, including hyponatremia.

---

## Relevant Quotes
1. "Success is where preparation and opportunity meet." - Bobby Unser
2. "Your body will argue that there is no justifiable reason to continue. Your only recourse is to call on your spirit, which fortunately functions independently of logic." - Tim Noakes
input: {{topic}}
output:''';

const stopSequences = <String>[];

Future<String> generateResearch(String topic) async {
  final response = await _text.generateText(
    model: PalmModel.textBison001.name,
    prompt: TextPrompt(text: promptString.replaceAll('{{topic}}', topic)),
    temperature: 0.7,
    // optional, how many candidate results to generate
    candidateCount: 1,
    // optional, number of most probable tokens to consider for generation
    topK: 40,
    // optional, for nucleus sampling decoding strategy
    topP: 0.95,
    // optional, maximum number of output tokens to generate
    maxOutputTokens: 1024,
    // optional, sequences at which to stop model generation
    stopSequences: stopSequences,
    // optional, safety settings
    safetySettings: [
      const SafetySetting(
          category: HarmCategory.derogatory,
          threshold: HarmBlockThreshold.blockOnlyHigh),
      const SafetySetting(
          category: HarmCategory.toxicity,
          threshold: HarmBlockThreshold.blockOnlyHigh),
      const SafetySetting(
          category: HarmCategory.violence,
          threshold: HarmBlockThreshold.blockOnlyHigh),
      const SafetySetting(
          category: HarmCategory.sexual,
          threshold: HarmBlockThreshold.blockOnlyHigh),
      const SafetySetting(
          category: HarmCategory.medical,
          threshold: HarmBlockThreshold.blockOnlyHigh),
      const SafetySetting(
          category: HarmCategory.dangerous,
          threshold: HarmBlockThreshold.blockOnlyHigh)
    ],
  );
  return response.candidates.first.output;
}
