const promptString =
    '''As a speaker, create a slide presentation for a specific topic.

## Presentation content 

- Presentation should have 9 slides total
- Content should be relevant and engaging on the topic

## Slide

### Properties 

- '`id`: Id string of the slide
- `layout`: Type of layout
- `background`: Background image (optional) -  A string containing the URL for the Unsplash background image
- `contentAlignment`: Alignment of the content (optional) -  Specifies the positioning of content. Options include topLeft, topCenter, topRight, centerLeft, center, centerRight, bottomLeft, bottomCenter, bottomRight.

### Layouts

1. **basic**: This is the default layout, featuring a simple content display with options to customize the background image and content alignment. Additional properties include:
  
2. **image**: Intended for slides that feature an image alongside the text content, with controls for the image's fit and position. Additional properties include:
    - `image`: A string containing the Unsplash URL for the image to be used.
    - `imageFit`: Dictates how the image should be resized to fit its container. Options include "contain," "cover," "fill," "none," "scale-down."
    - `imagePosition`: Determines the image's placement on the slide relative to the text. Options include "left" or "right."

3. **twoColumn**: Splits the slide into two equal columns for presenting different content types side-by-side. It doesn't have specific extra properties. Instead, it uses a text directive (`::right::`) to separate the content for the left and right columns.

4. **twoColumnHeader**: Similar to "TwoColumn" layout, but it includes an additional option for a header spanning across both columns. No additional properties specified in the original prompt, but it likely follows the same directives for content separation as the "TwoColumn" layout.

## Image Sourcing

You can use images for `background` and `image` properties. The images are sourced from Unsplash.

Use abstract or emotive keywords for image sourcing: 
For example, use keywords like `inspiration`, `innovation`. As this is from Unsplash, it can become difficult to get images for very specific keywords, like "flutter", "Apple Watch" and so on. Therefore, keep the keywords more as a complement of emotion, or conceptual, unless for very common actions like "running". Also, when focusing more on coding or a specific technology, we should avoid imagery, unless you want to use abstract, decorative imagery.
Try not to repeat keywords.

Url format: https://source.unsplash.com/random/900×700/?KEYWORD,OTHERKEYWORD


Let's start:

input: 5k for beginners
output:---
id: slide-1
background: https://source.unsplash.com/random/900×700/?start
contentAlignment: bottomLeft
---
# Welcome to 5K Trainingf For Beginners
Start your running journey with confidence and a clear plan.

---
id: slide-2
background: https://source.unsplash.com/random/900×700/?running,practice
contentAlignment: centerLeft
---
# Setting Your Goals
- Understand your motivation
- Define achievable milestones
- Create a timeline for training

---
id: slide-3
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?planner
---
## Training Basics

Understand the fundamentals of a 5K training program.

::right::

### Weekly Training Breakdown
| Day | Activity |
| --- | -------- |
| Day 1 | Interval Training |
| Day 2 | Rest or Cross-Train |
| Day 3 | Tempo Run |
| Day 4 | Easy Run |
| Day 5 | Rest Day |
| Day 6 | Long Run |
| Day 7 | Recovery Run |

---
id: slide-4
layout: image
imageFit: cover
image: https://source.unsplash.com/random/900×700/?water,hydration
imagePosition: right
contentAlignment: centerRight
---
# Importance of Hydration
Proper hydration is crucial for safe and effective training.

---
id: slide-5
background: https://source.unsplash.com/random/900×700/?food,healthy
contentAlignment: bottomLeft
---
# Nutrition for Runners
Learn how to fuel your body for endurance and recovery.

---
id: slide-6
background: https://source.unsplash.com/random/900×700/?running shoes
contentAlignment: centerLeft
---
# Choosing the Right Gear
- The importance of proper footwear
- Comfortable clothing for different weathers
- Essential accessories

---
id: slide-7
background: https://source.unsplash.com/random/900×700/?inspiration
contentAlignment: bottomCenter
---
# "The miracle isn't that I finished. The miracle is that I had the courage to start."  
- John Bingham

---
id: slide-8
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?challenge
---
## Common Challenges & Solutions
::left::
### Overcoming Mental Barriers
- Setting realistic expectations
- Positive self-talk
- Visualizing success

::right::
### Physical Challenges
- Pre-run warm-up
- Post-run cool down
- Listening to your body's signals

---
id: slide-9
background: https://source.unsplash.com/random/900×700/?run,competition
contentAlignment: center
---
# Race Day Preparation
Tips and strategies for a successful and enjoyable race day.

---
id: slide-10
background: https://source.unsplash.com/random/900×700/?celebrate
contentAlignment: center
---
# You're Ready! Celebrate Your Training Journey
As you approach your first 5K, remember how far you've come and look forward to the finish line.

input: Improve your sleep
output:---
id: slide-1
background: https://source.unsplash.com/random/900×700/?sleeping
contentAlignment: bottomLeft
---
# Improving your sleep:
Understanding the importance of sleep and how to improve sleep quality.

---
id: slide-2
background: https://source.unsplash.com/random/900×700/?peaceful
contentAlignment: centerLeft
---
# Importance of Quality Sleep
- Fundamental to physical health and effective functioning of the immune system.
- Crucial for cognitive functions such as memory and learning.
- Enhances mood and fosters mental wellbeing.

---
id: slide-3
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?night-sky
---
## Understanding Sleep Cycle

Understanding the natural cycle of sleep can significantly help in optimizing sleep quality.

::right::

### Stages of Sleep
- Stage 1: Light sleep, muscle activity slows down, and occasional muscle twitching.
- Stage 2: Breathing pattern and heart rate slows down.
- Stage 3: Deep sleep, difficult to wake up, no eye movement or muscle activity.

---
id: slide-4
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?bedroom
---
::left::

### Physical Factors That Improve Sleep
- Optimal sleep environment: Calm, quiet, and dark room.
- Comfortable bedroom temperature: Around 18-22°C (65-72°F).
- Adequate ventilation.
- Noise and light control.

::right::

### Role of Diet

A balanced diet can affect sleep quality. Here's how:

| Food Type    | Aids Sleep | Avoid Before Sleep | Remarks                  |
|--------------|------------|--------------------|--------------------------|
| Dairy        | Yes        | No                 | Contains tryptophan      |
| Caffeine     | No         | Yes                | Stimulant                |
| Fatty Foods  | No         | Yes                | Heavy to digest          |

---
id: slide-5
layout: image
imageFit: cover
image: https://source.unsplash.com/random/900×700/?workout
imagePosition: right
contentAlignment: centerRight
---
# Role of Exercise
Regular physical exercise can significantly improve the quality of your sleep and help reduce sleep disorders such as insomnia and sleep apnea.

---
id: slide-6
background: https://source.unsplash.com/random/900×700/?bedtime
contentAlignment: centerLeft
---
# Sleep Hygiene
Good sleep hygiene leads to better sleep quality.
- Keeping a consistent sleep schedule.
- Making a bedtime routine.
- Sleeping on a comfortable, supportive mattress and pillows.

---
id: slide-7
background: https://source.unsplash.com/random/900×700/?relaxation
contentAlignment: centerRight
---
# Stress and Sleep Quality
Promoting a relaxed state of mind before sleep can significantly improve sleep quality.
- Reducing stress and worry.
- Engaging in mind-calming activities.
- Trying meditation or yoga.

---
id: slide-8
layout: twoColumn
background: https://source.unsplash.com/random/900×700/?alarm-clock
---
## Sleep Aids, Consultation, and Sleep Schedule
::left::
#### Role of Sleep Aids and Consultation
- Over-the-counter sleep aids can be helpful occasionally, but they should not be relied upon.
- Consult with a healthcare provider if sleep troubles persist despite trying various strategies.

::right::
#### Creating a Sleep Schedule
- Make sleep a priority in your daily schedule.
- Aim for consistency in sleep and wake times.
- Ensure adequate sleep duration: Aim for 7-9 hours per night.

---
id: slide-9
background: https://source.unsplash.com/random/900×700/?questions
contentAlignment: center
---
# Conclusion and Q&A
We've now covered a comprehensive guide to improving your sleep quality. 
- Let's review the key points. 
- Open for Q&A


input: {{input}}
output:''';

const stopSequences = <String>[];

String presentationCreator(String topic) {
  return promptString.replaceAll('{{input}}', topic);
}
