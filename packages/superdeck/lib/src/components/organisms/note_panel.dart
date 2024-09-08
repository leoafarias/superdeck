import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../modules/deck_reference/deck_reference_hooks.dart';

class NotePanel extends HookWidget {
  const NotePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final slide = useCurrentSlide();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
            child: SingleChildScrollView(
              child: Column(
                children:
                    slide.notes.map((note) => Text(note.content)).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
