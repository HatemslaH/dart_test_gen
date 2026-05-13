import 'package:dart_test_gen/test_generator.dart';
import 'package:test/test.dart';

void main() {
  group('success expectations — bool / null matchers', () {
    MethodSpec boolMethod({required bool useMatchers}) => MethodSpec(
      name: 'isOk',
      params: const [],
      returnType: 'bool',
      snapshotReturnType: 'bool',
      isStatic: true,
      useExpectMatchersBoolNull: useMatchers,
      testCases: const [TestCaseRow(argLiterals: [], expectedLiteral: 'true')],
    );

    test('matchers on: isTrue without expected local', () {
      final out = stripGeneratedTimestamp(
        generateTestFile(
          className: 'Calc',
          importPath: 'calc.dart',
          methods: [boolMethod(useMatchers: true)],
        ),
      );
      expect(out, contains('expect(actual, isTrue)'));
      expect(out, contains(r"test('isOk returns true', ()"));
      expect(out, isNot(contains('final expected = true')));
    });

    test('matchers off: expected binding and expect(actual, expected)', () {
      final out = stripGeneratedTimestamp(
        generateTestFile(
          className: 'Calc',
          importPath: 'calc.dart',
          methods: [boolMethod(useMatchers: false)],
        ),
      );
      expect(out, contains('final expected = true'));
      expect(out, contains(r"test('isOk returns true', ()"));
      expect(out, contains('expect(actual, expected)'));
    });

    test('null literal uses isNull when matchers on', () {
      final spec = MethodSpec(
        name: 'maybe',
        params: const [],
        returnType: 'String?',
        snapshotReturnType: 'String?',
        isStatic: true,
        testCases: const [TestCaseRow(argLiterals: [], expectedLiteral: 'null')],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'Box', importPath: 'b.dart', methods: [spec]),
      );
      expect(out, contains('expect(actual, isNull)'));
      expect(out, contains(r"test('maybe returns null', ()"));
      expect(out, isNot(contains('final expected = null')));
    });

    test('true on non-bool snapshot type keeps expected local', () {
      final spec = MethodSpec(
        name: 'm',
        params: const [],
        returnType: 'dynamic',
        snapshotReturnType: 'dynamic',
        isStatic: true,
        testCases: const [TestCaseRow(argLiterals: [], expectedLiteral: 'true')],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'Dyn', importPath: 'd.dart', methods: [spec]),
      );
      expect(out, contains('final expected = true'));
      expect(out, contains(r"test('m returns true', ()"));
      expect(out, contains('expect(actual, expected)'));
    });
  });
}
