import 'package:dash_deck_demo/env/env.dart';
import 'package:palm_api/palm_api.dart';

final _text = TextService(apiKey: Env.palmApiKey);

const promptString =
    '''You're an expert conference presenter. Revamp the provided slide content to make it punchy, ALWAYS adhering to the original markdown structure. Utilize the guidelines below.

GUIDELINE:
* **Conciseness, Active Voice, Strong Verbs**: Use brief, active voice with strong verbs. Mix sentence lengths, format text for readability, maintain relevance, engage the audience, emphasize key points, and end with a call to action.

input: ## Importance of Nutrition for Endurance Training

- Balanced diet: Ensure a mix of protein, complex carbohydrates, and healthy fats.
- Pre-ride fueling: Consume protein and carbohydrates before training rides.
- Post-ride recovery: Protein for muscle repair and carbs for energy replenishment.
output: ## Fuel Your Endurance Training
- **Balanced Bite**: Mix protein, complex carbs, and good fats for peak performance.
- **Pre-Ride Power-Up**: Load up on protein and carbs before hitting the road.
- **Post-Ride Recharge**: Refuel with protein for muscle mend and carbs to re-energize.

input: ## First Steps

- Starting with walking 
- Introducing short run intervals: Start with 1 minute running and 2 minute walking
- Gradual progression: Each week, increase running and decrease walking time

output: ## Hit the Ground Running

- **Step Up**: Start by walking.
- **Interval Intro**: Kick-off with 1-min runs and 2-min walks.
- **Crank it Up**: Boost run time and cut walk time weekly.

input: ## Understanding the 5k goal

- Improving cardiovascular health
- Enhancing mental well-being
- Boosting overall fitness

output: ## 5K Goals Unpacked

- **Heart Hero**: Amp up your cardiovascular health.
- **Mind Master**: Elevate your mental well-being.
- **Fitness Fanatic**: Turbocharge your overall fitness.

input: ## Debunking Myths

- "I'm not a runner": Everyone can run, it's all about building up gradually
- "5k is too much for beginners": With the right training, a beginner can prepare for 5k in 8-10 weeks
- "I don't have time": It only requires 30 minutes of training, three times a week
output: ## Myth-Busters: The 5K Edition

- **"Not a Runner?"**: Think again! Build up gradually and you're good to go.
- **"5K Too Daunting?"**: Wrong! 8-10 weeks of smart training gets you race-ready.
- **"Too Busy?"**: Just 30 mins, thrice a week, is all it takes!

input: ## A Guide to Home Exercise
- A warm-up: A simple jog-in-place or high-knee move gets the heart rate up.
- Bodyweight exercises: This includes squats, push-ups, lunges, etc.
- Cardio: Can include jumping jacks, mountain climbers, burpees, etc.
- Cooldown: This usually involves stretching to relax the muscles.
output: ## Home Exercise Blueprint
- **Kickstart**: Get your heart racing with a high-knee jog or jumping jacks.
- **Bodyweight Buff**: Flexibility meets strength with squats, push-ups, lunges and more!
- **Cardio Crunch**: Amp it up with mountain climbers, burpees, and jumpy jacks.
- **Ease Off**: Unwind and de-stress with good old stretch-outs.
input: ## Understanding Yoga
- Physical element: This includes asanas or physical postures.
- Mind element: This encompasses meditation and mindfulness.
- Breathing element: This involves pranayama or breathing techniques.
output: ## Yoga: Your Three-Pronged Wellness Wand
- **Body Booster**: Unfurl into wellness with asanas or physical postures.
- **Soul Soother**: Dive deep into tranquility with meditation and mindfulness.
- **Breath Builder**: Elevate your life force with pranayama or breathing control.
input: ## Benefits of Regular Exercise
- Promotes heart health: Regular activity strengthens the heart.
- Boosts energy levels: Exercise helps deliver oxygen and nutrients to tissues.
- Improves mental health: Physical activity stimulates various brain chemicals.
output: ## The Exercise Advantage
- **Heart Health Hub**: Pump up your heart's strength with daily activity.
- **Power Surge**: Bid fatigue goodbye as exercise fuels your tissues with oxygen & nutrients.
- **Mental Marvel**: Elevate your mood and stimulate your brain with routine workouts.
input: ## Getting started with CrossFit
- Warm-up: A mix of aerobic work and mobility drills.
- Strength work: Squats, deadlifts, or cleans.
- Conditioning: This could include a mix of running, rowing, or cycling.
output: ## CrossFit Crash Course
- **Warm-up Wonder**: Kickstart with some good old aerobic work and mobility drills.
- **Strength Surge**: Level up with squats, deadlifts, or cleans.
- **Conditioning Champ**: Master your game with running, rowing, or cycling.
input: {{input}}
output:''';

const stopSequences = <String>[];

Future<String> makeItPunchier(String input) async {
  final response = await _text.generateText(
    model: PalmModel.textBison001.name,
    prompt: TextPrompt(text: promptString.replaceAll('{{input}}', input)),
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
