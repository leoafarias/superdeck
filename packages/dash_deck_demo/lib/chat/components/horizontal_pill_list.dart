// Create a new widget
import 'package:flutter/material.dart';

class HorizontalPillList extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onSelectedPill;

  const HorizontalPillList({
    Key? key,
    required this.items,
    required this.onSelectedPill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30, // adjust as per your need
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: OutlinedButton(
              onPressed: () => onSelectedPill(items[index]),
              child: Text(items[index]),
            ),
          );
        },
      ),
    );
  }
}
