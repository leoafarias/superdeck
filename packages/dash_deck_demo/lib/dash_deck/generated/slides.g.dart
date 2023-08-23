// ignore_for_file: prefer_const_constructors

import 'package:dash_deck/dash_deck.dart';
import 'package:flutter/material.dart';

const _snippets = {};
final _styles = {};

class DashDeckApp extends DashDeckShell {
  DashDeckApp({Key? key})
      : super(
          data: DashDeckData(slides: slides),
          key: key,
        );
}

List<SlideData> get slides => [
      SlideData(
        id: '1692808854942',
        content:
            '# How to Prepare for a Half Ironman\n## The Ultimate Guide\n\| Phase                 \| Goal                        \| Key Activities       \|\n\|-----------------------\|-----------------------------\|-----------------------\|\n\| 1\. Pre-season training  \| Build fitness and endurance \| Swim, bike, run regularly \|\n\| 2\. Buildup phase       \| Increase training volume   \| Add more swim, bike, run \|\n\| 3\. Peak phase          \| Peak fitness                \| Taper training, taper diet \|\n\| 4\. Race day            \| Execute your race plan     \| Race day nutrition, hydration \|\n\| 5\. Recovery phase      \| Recover from race          \| Rest, cross-training, stretching \|',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808859294',
        content:
            '# How to Prepare for a Half Ironman\n## Step 1: Set Your Goals\n- Set a realistic timeline and achievable goals\.\n- Train for a variety of distances and intensities\.\n- Optimize nutrition and hydration\.\n- Get enough rest and recovery\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808861925',
        content:
            '# How to Train for a Half Ironman\n## Step 2: Choose the Right Training Plan\n\| Plan \| Duration \| Volume \|\n\|---\|---\|---\|\n\| Base \| 12-16 weeks \| 3-5 hours per week \|\n\| Build \| 8-10 weeks \| 5-7 hours per week \|\n\| Peak \| 4-6 weeks \| 7-9 hours per week \|\n\| Taper \| 1-2 weeks \| 2-3 hours per week \|\ninput: How to prepare for a half Ironman\noutput: # How to Prepare for a Half Ironman\n## Training Tips for First-Timers\n- Start training 12-16 weeks in advance\.\n- Focus on building your aerobic base\.\n- Complete a variety of workouts, including running, swimming, and cycling\.\n- Gradually increase your training volume and intensity\.\n- Take rest days and listen to your body\.\n- Follow a healthy diet and get enough sleep\.\n- Stay motivated and enjoy the journey!',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808864639',
        content:
            '# Step 3: Fuel Your Body for Success\n## Hydrate and Fuel\n- Drink plenty of water\.\n- Eat healthy snacks before and after your workout\.\ninput: How to Prepare for a Half Ironman\noutput: # How to Prepare for a Half Ironman\n## A 12-Week Training Plan\n\| Week  \| Training \|\n\|---\|---\|\n\| 1-4  \| Build endurance with long, easy runs \|\n\| 5-8  \| Add speed with intervals and tempo runs \|\n\| 9-12 \| Peak with shorter, faster runs and taper \|',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808869160',
        content:
            '# Step 4: Get the Right Gear\n## Gear List\n- Bike: Road bike, triathalon bike, or TT bike\.\n- Wetsuit: For swimming\.\n- Triathlon suit: For running and biking\.\n- Running shoes: For running\.\n- Swim cap: For swimming\.\n- Goggles: For swimming\.\n- Helmet: For biking\.\n- Nutrition: For fueling during the race\.\n- Hydration: For staying hydrated during the race\.\n- Bike tools: For fixing bike problems\.\n- First aid kit: For minor injuries\.\n- Sunscreen: For protecting your skin from the sun\.\n- Sunglasses: For protecting your eyes from the sun\.\n- Ear plugs: For blocking out noise\.\n- Headband: For keeping sweat out of your eyes\.\n- Socks: For keeping your feet comfortable\.\n- Chamois cream: For preventing chafing\.\n- Towel: For drying off after swimming\.\n- Change of clothes: For after the race\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808871009',
        content:
            '# How to Prepare for a Half Ironman\n## Step 5: Mentally Prepare for the Challenge\n- Get excited, not scared\.\n- Focus on the process, not the outcome\.\n- Visualize yourself crossing the finish line\.\n- Remember your why\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808875508',
        content:
            '# Half Ironman Training\n## Step 6: Stay Motivated\n- Set goals, track progress, and reward yourself\.\n- Connect with other triathletes for support\.\n- Take breaks when needed\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808877352',
        content:
            '# Step 7: Deal with Setbacks\n## Be prepared for setbacks\.\n- \*\*Identify potential setbacks\.\*\*\n- \*\*Have a plan in place\.\*\*\n- \*\*Don\'t give up\.\*\*',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808884033',
        content:
            '# How to Prepare for a Half Ironman\n## Step 8: Train Smart, Not Hard\n- Mix up your training routine\.\n- Schedule rest days\.\n- Focus on your nutrition\.\n- Hydrate properly\.\n- Get enough sleep\.',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808887313',
        content:
            '# How to Prepare for a Half Ironman\n## 9 Key Steps\n1\. \*\*Set a goal\.\*\*\n2\. \*\*Get a coach\.\*\*\n3\. \*\*Get fit\.\*\*\n4\. \*\*Build your nutrition plan\.\*\*\n5\. \*\*Choose your gear\.\*\*\n6\. \*\*Practice your transitions\.\*\*\n7\. \*\*Taper your training\.\*\*\n8\. \*\*Race day!\*\*\n9\. \*\*Enjoy the journey!\*\*',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
      SlideData(
        id: '1692808889464',
        content:
            '# Conclusion & Q&A\n## Reviewing Preparation\n- Train consistently\.\n- Fuel your body\.\n- Pace yourself\.\n- Stay positive\.\n## Questions\?',
        options: SlideOptions(
          scrollable: false,
          layout: SlideLayout.none,
          background: null,
          backgroundFit: ImageFit.cover,
          contentAlignment: ContentAlignment.center,
          styles: null,
        ),
      ),
    ];
