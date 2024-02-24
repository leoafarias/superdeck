import 'package:flutter/material.dart';

Widget buildPromptBottomSheet(BuildContext context) {
  // This is where you define your bottom sheet contents
  return Container(
    child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      ListTile(
        leading: const Icon(Icons.text_snippet),
        title: const Text('Prompt 1'),
        onTap: () {
          Navigator.pop(context);
          // Implement your functionality here
        },
      ),
      ListTile(
        leading: const Icon(Icons.text_snippet),
        title: const Text('Prompt 2'),
        onTap: () {
          Navigator.pop(context);
          // Implement your functionality here
        },
      ),
      // add as many ListTiles as you need
    ]),
  );
}
