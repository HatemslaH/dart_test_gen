import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:test/test.dart';

void main() {
  group('descriptive success test titles', () {
    test('method with args uses returns <literal>', () {
      final spec = MethodSpec(
        name: 'add',
        params: const [
          Param('a', ParamType.int_),
          Param('b', ParamType.int_),
        ],
        returnType: 'int',
        snapshotReturnType: 'int',
        isStatic: true,
        testCases: const [
          TestCaseRow(argLiterals: ['1', '2'], expectedLiteral: '3'),
        ],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'Calc', importPath: 'c.dart', methods: [spec]),
      );
      expect(out, contains(r"test('add(1, 2) returns 3', ()"));
    });

    test('bool matcher mode still names expected true in title', () {
      final spec = MethodSpec(
        name: 'isEven',
        params: const [Param('n', ParamType.int_)],
        returnType: 'bool',
        snapshotReturnType: 'bool',
        isStatic: true,
        useExpectMatchersBoolNull: true,
        testCases: const [
          TestCaseRow(argLiterals: ['0'], expectedLiteral: 'true'),
        ],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'Calc', importPath: 'c.dart', methods: [spec]),
      );
      expect(out, contains(r"test('isEven(0) returns true', ()"));
      expect(out, contains('expect(actual, isTrue)'));
    });

    test('double closeTo uses returns a value close to phrase', () {
      final spec = MethodSpec(
        name: 'half',
        params: const [],
        returnType: 'double',
        snapshotReturnType: 'double',
        isStatic: true,
        useCloseForDouble: true,
        doubleEpsilon: 1e-9,
        testCases: const [TestCaseRow(argLiterals: [], expectedLiteral: '0.5')],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'D', importPath: 'd.dart', methods: [spec]),
      );
      expect(out, contains("test('half returns a value close to 0.5', ()"));
    });

    test('async success test gets descriptive title', () {
      final spec = MethodSpec(
        name: 'next',
        params: const [],
        returnType: 'Future<int>',
        snapshotReturnType: 'int',
        isStatic: true,
        isAsync: true,
        testCases: const [TestCaseRow(argLiterals: [], expectedLiteral: '1')],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'A', importPath: 'a.dart', methods: [spec]),
      );
      expect(out, contains(r"test('next returns 1', () async"));
    });

    test('string arg with quotes is escaped inside test name', () {
      final spec = MethodSpec(
        name: 'len',
        params: const [Param('s', ParamType.string_)],
        returnType: 'int',
        snapshotReturnType: 'int',
        isStatic: true,
        testCases: const [
          TestCaseRow(argLiterals: ["'hello'"], expectedLiteral: '5'),
        ],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'S', importPath: 's.dart', methods: [spec]),
      );
      expect(out, contains(r"test('len(\'hello\') returns 5', ()"));
    });

    test('falls back to compact title when descriptive is too long', () {
      final longXs = "'${'x' * 300}'";
      final spec = MethodSpec(
        name: 'm',
        params: const [Param('a', ParamType.int_)],
        returnType: 'String',
        snapshotReturnType: 'String',
        isStatic: true,
        testCases: [
          TestCaseRow(argLiterals: const ['0'], expectedLiteral: longXs),
        ],
      );
      final out = stripGeneratedTimestamp(
        generateTestFile(className: 'T', importPath: 't.dart', methods: [spec]),
      );
      expect(out, contains(r"test('m(0)', ()"));
      expect(out, isNot(contains('returns ${'x' * 50}')));
    });
  });
}
