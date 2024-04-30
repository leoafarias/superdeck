import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/utils.dart';

void main() {
  group(
    'Util tests',
    () {
      test('shortHashId generates consistent short IDs', () {
        const input1 = 'Hello, World!';
        const expectedOutput1 = 'zUZHawvl';
        expect(shortHashId(input1), equals(expectedOutput1));

        const input2 = 'Flutter is awesome';
        const expectedOutput2 = 'NQZU1Szg';
        expect(shortHashId(input2), equals(expectedOutput2));

        const input3 = 'Dart is fun';
        const expectedOutput3 = 'YDepxypq';
        expect(shortHashId(input3), equals(expectedOutput3));

        const input4 = 'SuperDecks';
        const expectedOutput4 = '84Zl5kOM';
        expect(shortHashId(input4), equals(expectedOutput4));

        const input5 = 'Short ID Generator';
        const expectedOutput5 = 'ymnjxlmN';
        expect(shortHashId(input5), equals(expectedOutput5));

        const input6 = 'https://www.google.com';
        const expectedOutput6 = 'LxeeFu6H';
        expect(shortHashId(input6), equals(expectedOutput6));

        const input7 = 'https://some.domain.com/image.jpg';
        const expectedOutput7 = 'M1wJvIQn';
        expect(shortHashId(input7), equals(expectedOutput7));

        const input8 = 'https://www.asdf.com/asdf?v=1234567890';
        const expectedOutput8 = 'WhQYB0uJ';
        expect(shortHashId(input8), equals(expectedOutput8));

        const input9 = 'asdfasdfasdfasdfasdfasdf';
        const expectedOutput9 = '0K3ABgP0';
        expect(shortHashId(input9), equals(expectedOutput9));

        const input10 = '&%*43;,.asdfasdf.INFINITY>;;`122190-+*/=-+';
        const expectedOutput10 = 'jzYRk5Oj';
        expect(shortHashId(input10), equals(expectedOutput10));
      });
    },
  );
}
