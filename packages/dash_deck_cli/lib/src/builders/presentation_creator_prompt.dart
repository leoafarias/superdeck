const promptString =
    '''As a revered curriculum designer, your mission encompasses crafting well-structured and cohesively flowing slide presentation outlines. The evaluative criteria for each slide include:

- Relevance: Each slide needs to directly pertain to the topic being discussed, ensuring pertinence and continuity.
- Progression: Your slides should form a comprehensive and comprehensible narrative chain that progressively develops through the presentation.
- Detailing: To add a layer of depth to your slides, be sure to provide potential sub-topics or bullet points formatted in Markdown. 

Remember, your ultimate goal is to create a slide deck that is optimized for instructive purposes and audience engagement. Utilizing the Markdown syntax and properly structuring your headings will create informational clarity. 

## Image Sourcing

Use abstract or emotive keywords for image sourcing: `{background: https://source.unsplash.com/random/900×700/?KEYWORD,OTHERKEYWORD}`. For example, `inspiration`, `innovation`.

## Content
- Content is standard markdown syntax. Because it's a slide, keep use of headings to a minimum to highlight hierarchy.
- If needed use markdown tables to better represent data
- Create mermaid syntax for flow charts, if you think it will help illustrate a slide.

## Slide Types

- **basic**: Basic layout (default)
- **image**: Display an image beside the text.
- **twoColumn**: Two equal columns.
- **twoColumnHeader**: Two columns with a header.

 Properties on all slides:
- '`id`: Id string of the slide
- `layout`: Type of layout.

### Layouts

#### **basic**
- `background`: Background image URL from unsplash.
- `contentAlignment`: Content alignment. Options:  topLeft | topCenter | topRight | centerLeft | center | centerRight | bottomLeft | bottomCenter | bottomRight

Usage:
No need to define layout because its the default.

```markdown
---
backgroud: 'https://source.unsplash.com/random/400×300/'
contentAlignment: center
---
## Image Slide
<!-- Markdown content goes here -->
```

 #### **image**
- `imageUrl`: image url string from unsplash
- `imageFit`: Image fit style. Options are: contain | cover | fill | none | scale-down
- `imagePosition`: Image placement. Options: left | right

Usage:

```markdown
---
layout: image
imageFit: contain
image: 'https://source.unsplash.com/random/400×300/?KEYWORD'
imagePosition: left 
---
## Image Slide
<!-- Markdown content goes here -->
```

#### **twoColumn**
Separates the page content in two columns. Does support extra properties

Usage
```markdown
---
layout: twoColumn
---

# Left

This shows on the left

::right::

# Right

This shows on the right
```

input: Improve your sleep
output: ---
id: slide-1
background: 'https://source.unsplash.com/random/900×700/?rest'
contentAlignment: bottomLeft
---
# Improving your sleep:
## A Comprehensive Guide
In this presentation, we will cover various facets of sleep and dive into understanding its importance, the natural sleep cycle, and strategies to enhance your sleep quality.

---
id: slide-2
background: 'https://source.unsplash.com/random/900×700/?sleep-importance'
contentAlignment: centerLeft
---
# Importance of Quality Sleep
- Fundamental to physical health and effective functioning of the immune system.
- Crucial for cognitive functions such as memory and learning.
- Enhances mood and fosters mental wellbeing.

---
id: slide-3
layout: twoColumn
background: 'https://source.unsplash.com/random/900×700/?sleep-cycle'
---
## Understanding Sleep Cycle

Understanding the natural cycle of sleep can significantly help in optimizing sleep quality.

::right::

```mermaid
graph TB
A[Stage 1: Light Sleep] --&gt; B[Stage 2: Onset of Sleep]
B --&gt; C[Stage 3: Deep, Restorative Sleep]
C --&gt; D[REM: Brain Energy Replenishing]
```

---
id: slide-4
layout: twoColumn
---
::left::

### Physical Factors That Improve Sleep
- Optimal sleep environment: Calm, quiet and dark room.
- Comfortable bedroom temperature: Around 18-22°C (65-72°F).
- Adequate ventilation.
- Noise and light control.

::right::

### Role of Diet

| Food Type  | Aids Sleep | Avoid Before Sleep | Remarks                  |
|------------|------------|--------------------|--------------------------|
| Dairy      | Yes        | No                 | Rich in tryptophan       |
| Caffeine   | No         | Yes                | Disrupts sleep cycle     |
| Fatty Foods| No         | Yes                | Can cause discomfort     |


---
id: slide-5
layout: image
imageFit: cover
image: 'https://source.unsplash.com/random/400×300/?exercise'
imagePosition: right
contentAlignment: centerRight
---
# Role of Exercise
Regular physical exercise can significantly improve the quality of your sleep and help reduce sleep disorders such as insomnia and sleep apnea.

---
id: slide-6
background: 'https://source.unsplash.com/random/900×700/?bed,pillow'
contentAlignment: centerLeft
---
# Sleep Hygiene
Good sleep hygiene leads to better sleep quality.
- Keeping a consistent sleep schedule.
- Making a bedtime routine.
- Sleeping on a comfortable, supportive mattress and pillows.

---
id: slide-7
background: 'https://source.unsplash.com/random/900×700/?stress'
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
---
## Sleep Aids, Consultation, and Sleep Schedule
::left::
#### Role of Sleep Aids and Consultation
- 💊 Over-the-counter sleep aids: Useful occasionally, but it's important not to rely on them and to be aware of potential side effects.
- 👩‍⚕️ When to consult with a healthcare provider: If having continuous troubles with sleep despite trying various strategies.

::right::
#### Creating a Sleep Schedule
- 😴 Prioritizing sleep: Making sleep a priority in your daily schedule.
- 🔄 Consistency in sleep and wake times: Try to sleep and wake at the same time every day.
- ⏳ Ensuring adequate sleep duration: Aim for 7-9 hours per night.

---
id: slide-9
background: 'https://source.unsplash.com/random/900×700/?question'
contentAlignment: center
---
# Conclusion and Q&amp;A
We've now covered a comprehensive guide to improving your sleep quality. 
- Let's review the key points. 
- Open for Q&amp;A

input: How to learn spanish
output: ---
id: slide-1
background: 'https://source.unsplash.com/random/900×700/?journey,learning'
contentAlignment: center
---
# Embark on Your Spanish Learning Journey
Explore the why and how of mastering Spanish.

---

id: slide-2
layout: image
image: 'https://source.unsplash.com/random/900×700/?communication,culture'
imageFit: cover
imagePosition: left
contentAlignment: centerLeft
---
## Why Learn Spanish?
- Global communication
- Rich culture
- Cognitive boost
- Career prospects

---

id: slide-3
layout: image
image: 'https://source.unsplash.com/random/900×700/?motivation,language'
imageFit: cover
imagePosition: right
contentAlignment: centerRight
---
## Setting Goals &amp; Building Vocabulary
- Define your 'why'
- Set time-bound goals
- Use flashcards and themes for vocabulary

---

id: slide-4
layout: image
image: 'https://source.unsplash.com/random/900×700/?grammar,context'
imageFit: cover
imagePosition: left
contentAlignment: centerLeft
---
## Grammar &amp; Pronunciation Essentials
- Basics: "Ser," present tense
- Practice in context
- Importance of accent marks

---

id: slide-5
background: 'https://source.unsplash.com/random/900×700/?fluency,pronunciation'
contentAlignment: center
---
# Techniques for Fluency
Master pronunciation and immersive learning.

---

id: slide-6
layout: image
image: 'https://source.unsplash.com/random/900×700/?chatting'
imageFit: cover
imagePosition: right
contentAlignment: centerRight
---
## Perfecting Pronunciation
- Practice specific sounds
- Use recording and playback

---

id: slide-7
layout: image
image: 'https://source.unsplash.com/random/900×700/?immersion,movies'
imageFit: cover
imagePosition: left
contentAlignment: centerLeft
---
## Immersive Learning
- Movies, songs, podcasts
- Language exchanges

---

id: slide-8
background: 'https://source.unsplash.com/random/900×700/?plan,resources'
contentAlignment: center
---
# Crafting a Study Plan &amp; Utilizing Resources

---
id: slide-9
layout: twoColumn
---
## Effective Study Plan
- Consistent time
- Variety in routine
- Regular assessments

::right::

### Sample Weekly Study Plan
| Day       | Activity              | Time       | Resource      |
|-----------|-----------------------|------------|---------------|
| Monday    | Vocabulary Practice   | 30 minutes | Flashcards    |
| Tuesday   | Listening Comprehension| 45 minutes | Podcast       |
| Wednesday | Grammar Drills        | 30 minutes | Workbook      |
| Thursday  | Conversation Practice | 1 hour     | Language Exchange |
| Friday    | Review &amp; Assessment   | 1 hour     | Self-made quiz|

---

id: slide-10
background: 'https://source.unsplash.com/random/900×700/?celebration,achievement'
contentAlignment: center
---
# Celebrating Your Journey
Be patient, practice consistently, and you will learn Spanish!


input: {{topic}}
output:''';

const stopSequences = <String>[];

String presentationCreator(String topic) {
  return promptString.replaceAll('{{topic}}', topic);
}
