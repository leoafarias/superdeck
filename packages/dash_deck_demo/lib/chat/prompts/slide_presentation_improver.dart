const promptString =
    '''Improve the content of various educational slide presentations by tailoring it according to the provided feedback, ensuring it stays true to the original markdown format and maintains the accuracy and essence of the information.
input: CONTENT:
# Unraveling the Mystery of Sleep:
## Your Pathway to Improved Well-being
Immerse yourself in a comprehensive exploration of sleep, its nuances, and practical strategies to enhance your sleep quality.


FEEDBACK:
Make the content simpler and shorter

output: # Demystifying Sleep
## A Guide to Better Rest
Learn practical ways to improve your sleep quality.

input: CONTENT:

# Sleep Mechanics:
- Unpacking REM and non-REM sleep stages
- Circadian rhythm's crucial role in sleep quality
- Diving into sleep cycles and their implications

::right::

## Embracing a Sleep-oriented Lifestyle
- Practical strategies for sleep improvement
- The link between diet, exercise, and sleep
- Managing stress to enhance sleep performance

FEEDBACK:
Make bullet points consistent.
output: # Sleep Mechanics
- Understanding REM and non-REM stages
- The role of circadian rhythms
- The impact of sleep cycles

::right::

# Lifestyle and Sleep
- Strategies for better sleep
- The diet-sleep connection
- Managing stress for better res
input: CONTENT:
## Sleep-enhancing Measures

::left::

### Sleep Hygiene for Optimal Rest
- Consistent sleep routine and bedtime ritual
- Comfortable sleep environment

::right::

### Diet and Stress Management
- Impact of diet on sleep health
- Stress-reducing activities for better sleep

FEEDBACK:
use simpler words for headers
output: ## Sleep-enhancing Strategies

::left::

### Sleep Hygiene
- Consistent sleep schedule
- Comfortable sleep environment

::right::

### Diet and Stress Management
- Healthy diet
- Stress-reducing activities
input: CONTENT:

## Importance of Nutrition for Endurance Training

- Balanced diet: Ensure a mix of protein, complex carbohydrates, and healthy fats.
- Pre-ride fueling: Consume protein and carbohydrates before training rides.
- Post-ride recovery: Protein for muscle repair and carbs for energy replenishment.

FEEDBACK:

Make it punchy
output: ## Fuel Your Endurance Training
- **Balanced Bite**: Mix protein, complex carbs, and good fats for peak performance.
- **Pre-Ride Power-Up**: Load up on protein and carbs before hitting the road.
- **Post-Ride Recharge**: Refuel with protein for muscle mend and carbs to re-energize.

input: CONTENT:

## Tips for Effective Group Discussion

- Be clear and concise.
- Respect and acknowledge everyone's perspectives and ideas.
- Foster cooperative atmosphere and constructive criticism to fuel productivity.

FEEDBACK:

Relay the same information in a playful manner.
output: ## Group Discussion Hacks

- Keep it short and sweet!
- Don't forget everyone's ideas count.
- Build a teamwork jungle - more fun, more productivity!
input: CONTENT:

## Achieving Success in Sports Through Mindfulness

- Recognize the impact of your thoughts and emotions on performance.
- Practice regular mental conditioning to control mindset.
- Cultivate resilience and mental toughness through mindfulness techniques

FEEDBACK:

Keep it simple and straightforward.

output: ## Winning At Sports With Mindfulness

- Know how your thoughts and emotions affect your game.
- Regularly train your mind.
- Use mindfulness to build resilience and toughness.

input: CONTENT:

#### The Impact of Climate Change on Agriculture

- Changes in weather patterns lead to crop loss and degradation.
- The increase in global temperature can affect the balanced climate needed for farming.
- The rise in sea levels and frequency of natural calamities caused by climate change poses a threat to agriculture.

FEEDBACK:

Cut down wordiness; make it compact.

output: #### Climate Change &amp; Agriculture

- Weather shifts cause crop loss.
- Global warming disturbs farming climate.
- Rising sea levels and frequent calamities threaten agriculture.

input: CONTENT:
## Core Principles of Sustainable Living

::left::

- Reduced waste generation
- Conservation and preservation
- Decreased carbon footprint

::right::

- Positive societal impact
- Sustainable practices in consumption
- Green energy practices

FEEDBACK:

Make it even more simple and direct.

output: ## Sustainable Living Basics

::left::

- Less waste
- Save and preserve
- Lower your carbon footprint

::right::

- Help society
- Consume responsibly
- Use green energy

input: CONTENT:

### Strategies for Achieving Better Work-Life Balance

::left::

- Time management and planning
- Creating a productive work environment
- Setting clear goals and priorities

::right::

- Engaging in regular exercise
- Making time for relaxation and hobbies
- Healthy eating and sleeping habits

FEEDBACK:

Use catchy phrases for each point.

output: ### Winning at Work-life Balance

::left::

- Become a time-bender
- Master the zen art of a productive workspace
- Be a goal-digger

::right::

- Flex, don't stress
- Hobby hour is power hour
- Tuck-in and eat-in for the win!

input: CONTENT:

### Debunking the Myths of Veganism

- Myth: Vegans don't get enough protein.
  Truth: Well-balanced vegan diets provide more than enough protein.
- Myth: Meat substitutes used by vegans are always healthier.
  Truth: Some faux meats can be overly processed and may not be as healthy as presumed.

FEEDBACK:

Make it more accessible to non-vegans.
output: ### Unmasking Vegan Myths

- Myth: Vegan? No protein!
  Truth: Well-planned vegan meals are protein-rich.
- Myth: Vegan means healthier meat alternatives.
  Truth: Not all plant-based meats are healthy - check labels!

input: CONTENT: 

{{content}}

FEEDBACK:

{{feedback}}

output:`
    ''';

const stopSequences = <String>[];

String improveContent(String content, String feedback) {
  return promptString
      .replaceAll('{{content}}', content)
      .replaceAll('{{feedback}}', feedback);
}
