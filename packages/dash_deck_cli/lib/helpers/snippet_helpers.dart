import 'package:dash_deck_cli/helpers/recase.dart';

String widgetName(String slideName, int snippetIndex) {
  return ReCase('${slideName}_snippet_${snippetIndex}_widget').pascalCase;
}
