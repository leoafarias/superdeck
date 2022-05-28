import 'package:dash_deck_cli/helpers/slides_parser.dart';
import 'package:test/test.dart';

void main() {
  test('Focus code parser', () async {
    final codeSample = '''
      //@focus:1,2
    ''';

    final codeSample2 = '''
      //@focus:1,2:5
    ''';

    final codeSample3 = '''
      //@focus:1:5
    ''';
    final codeSample4 = '''
      //@focus:1
    ''';

    final codeSample5 = '''
      //@focus:1,2,3
    ''';

    final codeSample6 = '''
       v //@focus:1,2,3
    ''';

    expect(keywordLineParser(codeSample, 'focus'), [1, 2]);
    expect(keywordLineParser(codeSample2, 'focus'), [1, 2, 3, 4, 5]);
    expect(keywordLineParser(codeSample3, 'focus'), [1, 2, 3, 4, 5]);
    expect(keywordLineParser(codeSample4, 'focus'), [1]);
    expect(keywordLineParser(codeSample5, 'focus'), [1, 2, 3]);
    expect(keywordLineParser(codeSample6, 'focus'), []);
  });
}
