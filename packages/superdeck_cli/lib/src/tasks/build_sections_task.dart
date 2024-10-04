// slide_sections_task.dart

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/parsers/section_parser.dart';

class BuildSectionsTask extends Task {
  BuildSectionsTask() : super('build_sections_task');

  @override
  void run(context) {
    context.slide = context.slide.copyWith(
      sections: parseSections(context.slide.markdown),
    );
  }
}
