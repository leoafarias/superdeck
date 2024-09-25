import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/slide/slide_configuration.dart';

class NotePanel extends StatelessWidget {
  const NotePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final slide = SlideConfiguration.of(context);

    final notes =
        slide.notes.isEmpty ? [SlideNote(content: 'No notes')] : slide.notes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notes
                    .map(
                      (note) => Text(note.content),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
