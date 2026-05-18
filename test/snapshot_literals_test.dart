import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:test/test.dart';

void main() {
  group('dartLiteralFromJson — primitives', () {
    test('int', () {
      expect(dartLiteralFromJson(42, 'int', []), '42');
    });

    test('double non-integer', () {
      expect(dartLiteralFromJson(1.5, 'double', []), '1.5');
    });

    test('double integer-valued emits trailing .0', () {
      expect(dartLiteralFromJson(1.0, 'double', []), '1.0');
    });

    test('bool true', () {
      expect(dartLiteralFromJson(true, 'bool', []), 'true');
    });

    test('bool false', () {
      expect(dartLiteralFromJson(false, 'bool', []), 'false');
    });

    test('String plain', () {
      expect(dartLiteralFromJson('hello', 'String', []), "'hello'");
    });

    test("String with single quote is escaped", () {
      expect(dartLiteralFromJson("a'b", 'String', []), r"'a\'b'");
    });

    test(r'String with backslash is escaped', () {
      expect(dartLiteralFromJson(r'a\b', 'String', []), r"'a\\b'");
    });
  });

  group('dartLiteralFromJson — collections', () {
    test('List<int>', () {
      expect(dartLiteralFromJson([1, 2, 3], 'List<int>', []), '[1, 2, 3]');
    });

    test('List<String>', () {
      expect(dartLiteralFromJson(['a', 'b'], 'List<String>', []), "['a', 'b']");
    });

    test('Set<int> is sorted', () {
      expect(dartLiteralFromJson([3, 1, 2], 'Set<int>', []), '{1, 2, 3}');
    });

    test('Set<String> is sorted', () {
      expect(dartLiteralFromJson(['c', 'a', 'b'], 'Set<String>', []), "{'a', 'b', 'c'}");
    });

    test('empty Set<int>', () {
      expect(dartLiteralFromJson(<dynamic>[], 'Set<int>', []), '<int>{}');
    });

    test('Iterable<int>', () {
      expect(dartLiteralFromJson([10, 20], 'Iterable<int>', []), '[10, 20]');
    });

    test('Map<String, int>', () {
      expect(dartLiteralFromJson({'a': 1, 'b': 2}, 'Map<String, int>', []), "{'a': 1, 'b': 2}");
    });
  });

  group('dartLiteralFromJson — enum payload', () {
    test('renders EnumType.enumName', () {
      final value = {'_enumType': 'LogLevel', '_enumName': 'warn'};
      expect(dartLiteralFromJson(value, 'LogLevel', []), 'LogLevel.warn');
    });
  });

  group('dartLiteralFromJson — user class via ClassInfo', () {
    test('positional params produce ClassName(v1, v2)', () {
      final classInfo = const ClassInfo(
        'Point',
        ['x', 'y'],
        constructorPositionalParams: ['x', 'y'],
      );
      final value = {'_type': 'Point', 'x': 1, 'y': 2};
      expect(dartLiteralFromJson(value, 'Point', [classInfo]), 'Point(1, 2)');
    });

    test('named params produce ClassName(name: v)', () {
      final classInfo = const ClassInfo(
        'Size',
        ['width', 'height'],
        constructorNamedParams: ['width', 'height'],
      );
      final value = {'_type': 'Size', 'width': 10, 'height': 20};
      expect(
        dartLiteralFromJson(value, 'Size', [classInfo]),
        'Size(width: 10, height: 20)',
      );
    });

    test('fallback _value for unknown class', () {
      final value = {'_type': 'Unknown', '_value': 'someStr'};
      expect(dartLiteralFromJson(value, 'Unknown', []), 'someStr');
    });
  });

  group('dartLiteralFromJsonLoose', () {
    test('null → null', () {
      expect(dartLiteralFromJsonLoose(null), 'null');
    });

    test('bool true → true', () {
      expect(dartLiteralFromJsonLoose(true), 'true');
    });

    test('bool false → false', () {
      expect(dartLiteralFromJsonLoose(false), 'false');
    });

    test('int', () {
      expect(dartLiteralFromJsonLoose(7), '7');
    });

    test('double', () {
      expect(dartLiteralFromJsonLoose(3.14), '3.14');
    });

    test('String', () {
      expect(dartLiteralFromJsonLoose('hi'), "'hi'");
    });

    test('unsupported type throws StateError', () {
      expect(() => dartLiteralFromJsonLoose([1, 2, 3]), throwsStateError);
    });
  });
}
