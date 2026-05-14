import 'package:test/test.dart';
import 'package:example/usecases/optional_types/optional_types.dart';
import 'package:example/usecases/optional_types/another_class.dart';
import 'package:example/usecases/optional_types/custom_item.dart';
import 'package:example/usecases/optional_types/item_status.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-14T16:02:43.981277

void main() {
  final optionaltypes = OptionalTypes();

  group('sumNullable', () {
    test('sumNullable(0, 0) returns 0', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 1) returns 1', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -1) returns -1', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 2) returns 2', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -2) returns -2', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 10) returns 10', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -10) returns -10', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, null) returns 0', () {
      final a = 0;
      final b = null;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 0) returns 1', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 1) returns 2', () {
      final a = 1;
      final b = 1;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -1) returns 0', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 2) returns 3', () {
      final a = 1;
      final b = 2;
      final expected = 3;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -2) returns -1', () {
      final a = 1;
      final b = -2;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 10) returns 11', () {
      final a = 1;
      final b = 10;
      final expected = 11;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -10) returns -9', () {
      final a = 1;
      final b = -10;
      final expected = -9;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, null) returns 1', () {
      final a = 1;
      final b = null;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 0) returns -1', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 1) returns 0', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, -1) returns -2', () {
      final a = -1;
      final b = -1;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 2) returns 1', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, -2) returns -3', () {
      final a = -1;
      final b = -2;
      final expected = -3;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 10) returns 9', () {
      final a = -1;
      final b = 10;
      final expected = 9;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, -10) returns -11', () {
      final a = -1;
      final b = -10;
      final expected = -11;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, null) returns -1', () {
      final a = -1;
      final b = null;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, 0) returns 2', () {
      final a = 2;
      final b = 0;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, 1) returns 3', () {
      final a = 2;
      final b = 1;
      final expected = 3;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, -1) returns 1', () {
      final a = 2;
      final b = -1;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, 2) returns 4', () {
      final a = 2;
      final b = 2;
      final expected = 4;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, -2) returns 0', () {
      final a = 2;
      final b = -2;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, 10) returns 12', () {
      final a = 2;
      final b = 10;
      final expected = 12;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, -10) returns -8', () {
      final a = 2;
      final b = -10;
      final expected = -8;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(2, null) returns 2', () {
      final a = 2;
      final b = null;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, 0) returns -2', () {
      final a = -2;
      final b = 0;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, 1) returns -1', () {
      final a = -2;
      final b = 1;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, -1) returns -3', () {
      final a = -2;
      final b = -1;
      final expected = -3;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, 2) returns 0', () {
      final a = -2;
      final b = 2;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, -2) returns -4', () {
      final a = -2;
      final b = -2;
      final expected = -4;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, 10) returns 8', () {
      final a = -2;
      final b = 10;
      final expected = 8;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, -10) returns -12', () {
      final a = -2;
      final b = -10;
      final expected = -12;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-2, null) returns -2', () {
      final a = -2;
      final b = null;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, 0) returns 10', () {
      final a = 10;
      final b = 0;
      final expected = 10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, 1) returns 11', () {
      final a = 10;
      final b = 1;
      final expected = 11;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, -1) returns 9', () {
      final a = 10;
      final b = -1;
      final expected = 9;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, 2) returns 12', () {
      final a = 10;
      final b = 2;
      final expected = 12;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, -2) returns 8', () {
      final a = 10;
      final b = -2;
      final expected = 8;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, 10) returns 20', () {
      final a = 10;
      final b = 10;
      final expected = 20;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, -10) returns 0', () {
      final a = 10;
      final b = -10;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(10, null) returns 10', () {
      final a = 10;
      final b = null;
      final expected = 10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, 0) returns -10', () {
      final a = -10;
      final b = 0;
      final expected = -10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, 1) returns -9', () {
      final a = -10;
      final b = 1;
      final expected = -9;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, -1) returns -11', () {
      final a = -10;
      final b = -1;
      final expected = -11;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, 2) returns -8', () {
      final a = -10;
      final b = 2;
      final expected = -8;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, -2) returns -12', () {
      final a = -10;
      final b = -2;
      final expected = -12;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, 10) returns 0', () {
      final a = -10;
      final b = 10;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, -10) returns -20', () {
      final a = -10;
      final b = -10;
      final expected = -20;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-10, null) returns -10', () {
      final a = -10;
      final b = null;
      final expected = -10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, 0) returns 0', () {
      final a = null;
      final b = 0;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, 1) returns 1', () {
      final a = null;
      final b = 1;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, -1) returns -1', () {
      final a = null;
      final b = -1;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, 2) returns 2', () {
      final a = null;
      final b = 2;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, -2) returns -2', () {
      final a = null;
      final b = -2;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, 10) returns 10', () {
      final a = null;
      final b = 10;
      final expected = 10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, -10) returns -10', () {
      final a = null;
      final b = -10;
      final expected = -10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(null, null) returns 0', () {
      final a = null;
      final b = null;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
  });

  group('greet', () {
    test('greet(\'\', \'\') returns \' \'', () {
      final name = '';
      final prefix = '';
      final expected = ' ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', \'hello\') returns \'hello \'', () {
      final name = '';
      final prefix = 'hello';
      final expected = 'hello ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', \'  \') returns \'   \'', () {
      final name = '';
      final prefix = '  ';
      final expected = '   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', null) returns \'Hello \'', () {
      final name = '';
      final prefix = null;
      final expected = 'Hello ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\') returns \'Hello \'', () {
      final name = '';
      final expected = 'Hello ';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'\') returns \' hello\'', () {
      final name = 'hello';
      final prefix = '';
      final expected = ' hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'hello\') returns \'hello hello\'', () {
      final name = 'hello';
      final prefix = 'hello';
      final expected = 'hello hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'  \') returns \'   hello\'', () {
      final name = 'hello';
      final prefix = '  ';
      final expected = '   hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', null) returns \'Hello hello\'', () {
      final name = 'hello';
      final prefix = null;
      final expected = 'Hello hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\') returns \'Hello hello\'', () {
      final name = 'hello';
      final expected = 'Hello hello';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
    test('greet(\'  \', \'\') returns \'   \'', () {
      final name = '  ';
      final prefix = '';
      final expected = '   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', \'hello\') returns \'hello   \'', () {
      final name = '  ';
      final prefix = 'hello';
      final expected = 'hello   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', \'  \') returns \'     \'', () {
      final name = '  ';
      final prefix = '  ';
      final expected = '     ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', null) returns \'Hello   \'', () {
      final name = '  ';
      final prefix = null;
      final expected = 'Hello   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \') returns \'Hello   \'', () {
      final name = '  ';
      final expected = 'Hello   ';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
  });

  group('calculate', () {
    test('calculate(0, y: 0, z: 0) returns 0', () {
      final x = 0;
      final y = 0;
      final z = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 1) returns 1', () {
      final x = 0;
      final y = 0;
      final z = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -1) returns -1', () {
      final x = 0;
      final y = 0;
      final z = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 2) returns 2', () {
      final x = 0;
      final y = 0;
      final z = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -2) returns -2', () {
      final x = 0;
      final y = 0;
      final z = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 10) returns 10', () {
      final x = 0;
      final y = 0;
      final z = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -10) returns -10', () {
      final x = 0;
      final y = 0;
      final z = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: null) returns 0', () {
      final x = 0;
      final y = 0;
      final z = null;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0) returns 0', () {
      final x = 0;
      final y = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 0) returns 1', () {
      final x = 0;
      final y = 1;
      final z = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 1) returns 2', () {
      final x = 0;
      final y = 1;
      final z = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -1) returns 0', () {
      final x = 0;
      final y = 1;
      final z = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 2) returns 3', () {
      final x = 0;
      final y = 1;
      final z = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -2) returns -1', () {
      final x = 0;
      final y = 1;
      final z = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 10) returns 11', () {
      final x = 0;
      final y = 1;
      final z = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -10) returns -9', () {
      final x = 0;
      final y = 1;
      final z = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: null) returns 1', () {
      final x = 0;
      final y = 1;
      final z = null;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1) returns 1', () {
      final x = 0;
      final y = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 0) returns -1', () {
      final x = 0;
      final y = -1;
      final z = 0;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 1) returns 0', () {
      final x = 0;
      final y = -1;
      final z = 1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: -1) returns -2', () {
      final x = 0;
      final y = -1;
      final z = -1;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 2) returns 1', () {
      final x = 0;
      final y = -1;
      final z = 2;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: -2) returns -3', () {
      final x = 0;
      final y = -1;
      final z = -2;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 10) returns 9', () {
      final x = 0;
      final y = -1;
      final z = 10;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: -10) returns -11', () {
      final x = 0;
      final y = -1;
      final z = -10;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: null) returns -1', () {
      final x = 0;
      final y = -1;
      final z = null;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1) returns -1', () {
      final x = 0;
      final y = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: 0) returns 2', () {
      final x = 0;
      final y = 2;
      final z = 0;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: 1) returns 3', () {
      final x = 0;
      final y = 2;
      final z = 1;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: -1) returns 1', () {
      final x = 0;
      final y = 2;
      final z = -1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: 2) returns 4', () {
      final x = 0;
      final y = 2;
      final z = 2;
      final expected = 4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: -2) returns 0', () {
      final x = 0;
      final y = 2;
      final z = -2;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: 10) returns 12', () {
      final x = 0;
      final y = 2;
      final z = 10;
      final expected = 12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: -10) returns -8', () {
      final x = 0;
      final y = 2;
      final z = -10;
      final expected = -8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2, z: null) returns 2', () {
      final x = 0;
      final y = 2;
      final z = null;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 2) returns 2', () {
      final x = 0;
      final y = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: 0) returns -2', () {
      final x = 0;
      final y = -2;
      final z = 0;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: 1) returns -1', () {
      final x = 0;
      final y = -2;
      final z = 1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: -1) returns -3', () {
      final x = 0;
      final y = -2;
      final z = -1;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: 2) returns 0', () {
      final x = 0;
      final y = -2;
      final z = 2;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: -2) returns -4', () {
      final x = 0;
      final y = -2;
      final z = -2;
      final expected = -4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: 10) returns 8', () {
      final x = 0;
      final y = -2;
      final z = 10;
      final expected = 8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: -10) returns -12', () {
      final x = 0;
      final y = -2;
      final z = -10;
      final expected = -12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2, z: null) returns -2', () {
      final x = 0;
      final y = -2;
      final z = null;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -2) returns -2', () {
      final x = 0;
      final y = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: 0) returns 10', () {
      final x = 0;
      final y = 10;
      final z = 0;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: 1) returns 11', () {
      final x = 0;
      final y = 10;
      final z = 1;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: -1) returns 9', () {
      final x = 0;
      final y = 10;
      final z = -1;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: 2) returns 12', () {
      final x = 0;
      final y = 10;
      final z = 2;
      final expected = 12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: -2) returns 8', () {
      final x = 0;
      final y = 10;
      final z = -2;
      final expected = 8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: 10) returns 20', () {
      final x = 0;
      final y = 10;
      final z = 10;
      final expected = 20;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: -10) returns 0', () {
      final x = 0;
      final y = 10;
      final z = -10;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10, z: null) returns 10', () {
      final x = 0;
      final y = 10;
      final z = null;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 10) returns 10', () {
      final x = 0;
      final y = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: 0) returns -10', () {
      final x = 0;
      final y = -10;
      final z = 0;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: 1) returns -9', () {
      final x = 0;
      final y = -10;
      final z = 1;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: -1) returns -11', () {
      final x = 0;
      final y = -10;
      final z = -1;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: 2) returns -8', () {
      final x = 0;
      final y = -10;
      final z = 2;
      final expected = -8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: -2) returns -12', () {
      final x = 0;
      final y = -10;
      final z = -2;
      final expected = -12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: 10) returns 0', () {
      final x = 0;
      final y = -10;
      final z = 10;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: -10) returns -20', () {
      final x = 0;
      final y = -10;
      final z = -10;
      final expected = -20;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10, z: null) returns -10', () {
      final x = 0;
      final y = -10;
      final z = null;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -10) returns -10', () {
      final x = 0;
      final y = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, z: 0) returns 0', () {
      final x = 0;
      final z = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: 1) returns 1', () {
      final x = 0;
      final z = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: -1) returns -1', () {
      final x = 0;
      final z = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: 2) returns 2', () {
      final x = 0;
      final z = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: -2) returns -2', () {
      final x = 0;
      final z = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: 10) returns 10', () {
      final x = 0;
      final z = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: -10) returns -10', () {
      final x = 0;
      final z = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0, z: null) returns 0', () {
      final x = 0;
      final z = null;
      final expected = 0;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(0) returns 0', () {
      final x = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: 0) returns 1', () {
      final x = 1;
      final y = 0;
      final z = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: 1) returns 2', () {
      final x = 1;
      final y = 0;
      final z = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: -1) returns 0', () {
      final x = 1;
      final y = 0;
      final z = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: 2) returns 3', () {
      final x = 1;
      final y = 0;
      final z = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: -2) returns -1', () {
      final x = 1;
      final y = 0;
      final z = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: 10) returns 11', () {
      final x = 1;
      final y = 0;
      final z = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: -10) returns -9', () {
      final x = 1;
      final y = 0;
      final z = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0, z: null) returns 1', () {
      final x = 1;
      final y = 0;
      final z = null;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 0) returns 1', () {
      final x = 1;
      final y = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: 0) returns 2', () {
      final x = 1;
      final y = 1;
      final z = 0;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: 1) returns 3', () {
      final x = 1;
      final y = 1;
      final z = 1;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: -1) returns 1', () {
      final x = 1;
      final y = 1;
      final z = -1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: 2) returns 4', () {
      final x = 1;
      final y = 1;
      final z = 2;
      final expected = 4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: -2) returns 0', () {
      final x = 1;
      final y = 1;
      final z = -2;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: 10) returns 12', () {
      final x = 1;
      final y = 1;
      final z = 10;
      final expected = 12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: -10) returns -8', () {
      final x = 1;
      final y = 1;
      final z = -10;
      final expected = -8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1, z: null) returns 2', () {
      final x = 1;
      final y = 1;
      final z = null;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 1) returns 2', () {
      final x = 1;
      final y = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: 0) returns 0', () {
      final x = 1;
      final y = -1;
      final z = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: 1) returns 1', () {
      final x = 1;
      final y = -1;
      final z = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: -1) returns -1', () {
      final x = 1;
      final y = -1;
      final z = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: 2) returns 2', () {
      final x = 1;
      final y = -1;
      final z = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: -2) returns -2', () {
      final x = 1;
      final y = -1;
      final z = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: 10) returns 10', () {
      final x = 1;
      final y = -1;
      final z = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: -10) returns -10', () {
      final x = 1;
      final y = -1;
      final z = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1, z: null) returns 0', () {
      final x = 1;
      final y = -1;
      final z = null;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -1) returns 0', () {
      final x = 1;
      final y = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: 0) returns 3', () {
      final x = 1;
      final y = 2;
      final z = 0;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: 1) returns 4', () {
      final x = 1;
      final y = 2;
      final z = 1;
      final expected = 4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: -1) returns 2', () {
      final x = 1;
      final y = 2;
      final z = -1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: 2) returns 5', () {
      final x = 1;
      final y = 2;
      final z = 2;
      final expected = 5;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: -2) returns 1', () {
      final x = 1;
      final y = 2;
      final z = -2;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: 10) returns 13', () {
      final x = 1;
      final y = 2;
      final z = 10;
      final expected = 13;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: -10) returns -7', () {
      final x = 1;
      final y = 2;
      final z = -10;
      final expected = -7;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2, z: null) returns 3', () {
      final x = 1;
      final y = 2;
      final z = null;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 2) returns 3', () {
      final x = 1;
      final y = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: 0) returns -1', () {
      final x = 1;
      final y = -2;
      final z = 0;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: 1) returns 0', () {
      final x = 1;
      final y = -2;
      final z = 1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: -1) returns -2', () {
      final x = 1;
      final y = -2;
      final z = -1;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: 2) returns 1', () {
      final x = 1;
      final y = -2;
      final z = 2;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: -2) returns -3', () {
      final x = 1;
      final y = -2;
      final z = -2;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: 10) returns 9', () {
      final x = 1;
      final y = -2;
      final z = 10;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: -10) returns -11', () {
      final x = 1;
      final y = -2;
      final z = -10;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2, z: null) returns -1', () {
      final x = 1;
      final y = -2;
      final z = null;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -2) returns -1', () {
      final x = 1;
      final y = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: 0) returns 11', () {
      final x = 1;
      final y = 10;
      final z = 0;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: 1) returns 12', () {
      final x = 1;
      final y = 10;
      final z = 1;
      final expected = 12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: -1) returns 10', () {
      final x = 1;
      final y = 10;
      final z = -1;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: 2) returns 13', () {
      final x = 1;
      final y = 10;
      final z = 2;
      final expected = 13;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: -2) returns 9', () {
      final x = 1;
      final y = 10;
      final z = -2;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: 10) returns 21', () {
      final x = 1;
      final y = 10;
      final z = 10;
      final expected = 21;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: -10) returns 1', () {
      final x = 1;
      final y = 10;
      final z = -10;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10, z: null) returns 11', () {
      final x = 1;
      final y = 10;
      final z = null;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: 10) returns 11', () {
      final x = 1;
      final y = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: 0) returns -9', () {
      final x = 1;
      final y = -10;
      final z = 0;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: 1) returns -8', () {
      final x = 1;
      final y = -10;
      final z = 1;
      final expected = -8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: -1) returns -10', () {
      final x = 1;
      final y = -10;
      final z = -1;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: 2) returns -7', () {
      final x = 1;
      final y = -10;
      final z = 2;
      final expected = -7;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: -2) returns -11', () {
      final x = 1;
      final y = -10;
      final z = -2;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: 10) returns 1', () {
      final x = 1;
      final y = -10;
      final z = 10;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: -10) returns -19', () {
      final x = 1;
      final y = -10;
      final z = -10;
      final expected = -19;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10, z: null) returns -9', () {
      final x = 1;
      final y = -10;
      final z = null;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(1, y: -10) returns -9', () {
      final x = 1;
      final y = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(1, z: 0) returns 1', () {
      final x = 1;
      final z = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: 1) returns 2', () {
      final x = 1;
      final z = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: -1) returns 0', () {
      final x = 1;
      final z = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: 2) returns 3', () {
      final x = 1;
      final z = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: -2) returns -1', () {
      final x = 1;
      final z = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: 10) returns 11', () {
      final x = 1;
      final z = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: -10) returns -9', () {
      final x = 1;
      final z = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1, z: null) returns 1', () {
      final x = 1;
      final z = null;
      final expected = 1;
      final actual = optionaltypes.calculate(x, z: z);
      expect(actual, expected);
    });
    test('calculate(1) returns 1', () {
      final x = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: 0) returns -1', () {
      final x = -1;
      final y = 0;
      final z = 0;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: 1) returns 0', () {
      final x = -1;
      final y = 0;
      final z = 1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: -1) returns -2', () {
      final x = -1;
      final y = 0;
      final z = -1;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: 2) returns 1', () {
      final x = -1;
      final y = 0;
      final z = 2;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: -2) returns -3', () {
      final x = -1;
      final y = 0;
      final z = -2;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: 10) returns 9', () {
      final x = -1;
      final y = 0;
      final z = 10;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: -10) returns -11', () {
      final x = -1;
      final y = 0;
      final z = -10;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0, z: null) returns -1', () {
      final x = -1;
      final y = 0;
      final z = null;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 0) returns -1', () {
      final x = -1;
      final y = 0;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: 0) returns 0', () {
      final x = -1;
      final y = 1;
      final z = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: 1) returns 1', () {
      final x = -1;
      final y = 1;
      final z = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: -1) returns -1', () {
      final x = -1;
      final y = 1;
      final z = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: 2) returns 2', () {
      final x = -1;
      final y = 1;
      final z = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: -2) returns -2', () {
      final x = -1;
      final y = 1;
      final z = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: 10) returns 10', () {
      final x = -1;
      final y = 1;
      final z = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: -10) returns -10', () {
      final x = -1;
      final y = 1;
      final z = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1, z: null) returns 0', () {
      final x = -1;
      final y = 1;
      final z = null;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 1) returns 0', () {
      final x = -1;
      final y = 1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: 0) returns -2', () {
      final x = -1;
      final y = -1;
      final z = 0;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: 1) returns -1', () {
      final x = -1;
      final y = -1;
      final z = 1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: -1) returns -3', () {
      final x = -1;
      final y = -1;
      final z = -1;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: 2) returns 0', () {
      final x = -1;
      final y = -1;
      final z = 2;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: -2) returns -4', () {
      final x = -1;
      final y = -1;
      final z = -2;
      final expected = -4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: 10) returns 8', () {
      final x = -1;
      final y = -1;
      final z = 10;
      final expected = 8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: -10) returns -12', () {
      final x = -1;
      final y = -1;
      final z = -10;
      final expected = -12;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1, z: null) returns -2', () {
      final x = -1;
      final y = -1;
      final z = null;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -1) returns -2', () {
      final x = -1;
      final y = -1;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: 0) returns 1', () {
      final x = -1;
      final y = 2;
      final z = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: 1) returns 2', () {
      final x = -1;
      final y = 2;
      final z = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: -1) returns 0', () {
      final x = -1;
      final y = 2;
      final z = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: 2) returns 3', () {
      final x = -1;
      final y = 2;
      final z = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: -2) returns -1', () {
      final x = -1;
      final y = 2;
      final z = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: 10) returns 11', () {
      final x = -1;
      final y = 2;
      final z = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: -10) returns -9', () {
      final x = -1;
      final y = 2;
      final z = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2, z: null) returns 1', () {
      final x = -1;
      final y = 2;
      final z = null;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 2) returns 1', () {
      final x = -1;
      final y = 2;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: 0) returns -3', () {
      final x = -1;
      final y = -2;
      final z = 0;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: 1) returns -2', () {
      final x = -1;
      final y = -2;
      final z = 1;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: -1) returns -4', () {
      final x = -1;
      final y = -2;
      final z = -1;
      final expected = -4;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: 2) returns -1', () {
      final x = -1;
      final y = -2;
      final z = 2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: -2) returns -5', () {
      final x = -1;
      final y = -2;
      final z = -2;
      final expected = -5;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: 10) returns 7', () {
      final x = -1;
      final y = -2;
      final z = 10;
      final expected = 7;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: -10) returns -13', () {
      final x = -1;
      final y = -2;
      final z = -10;
      final expected = -13;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2, z: null) returns -3', () {
      final x = -1;
      final y = -2;
      final z = null;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -2) returns -3', () {
      final x = -1;
      final y = -2;
      final expected = -3;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: 0) returns 9', () {
      final x = -1;
      final y = 10;
      final z = 0;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: 1) returns 10', () {
      final x = -1;
      final y = 10;
      final z = 1;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: -1) returns 8', () {
      final x = -1;
      final y = 10;
      final z = -1;
      final expected = 8;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: 2) returns 11', () {
      final x = -1;
      final y = 10;
      final z = 2;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: -2) returns 7', () {
      final x = -1;
      final y = 10;
      final z = -2;
      final expected = 7;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: 10) returns 19', () {
      final x = -1;
      final y = 10;
      final z = 10;
      final expected = 19;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: -10) returns -1', () {
      final x = -1;
      final y = 10;
      final z = -10;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10, z: null) returns 9', () {
      final x = -1;
      final y = 10;
      final z = null;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: 10) returns 9', () {
      final x = -1;
      final y = 10;
      final expected = 9;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(-1, y: -10, z: 0) returns -11', () {
      final x = -1;
      final y = -10;
      final z = 0;
      final expected = -11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(-1, y: -10, z: 1) returns -10', () {
      final x = -1;
      final y = -10;
      final z = 1;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
  });

  group('formatStatus', () {
    test('formatStatus(ItemStatus.active, uppercase: true) returns \'ACTIVE\'', () {
      final status = ItemStatus.active;
      final uppercase = true;
      final expected = 'ACTIVE';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.active, uppercase: false) returns \'active\'', () {
      final status = ItemStatus.active;
      final uppercase = false;
      final expected = 'active';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.active) returns \'active\'', () {
      final status = ItemStatus.active;
      final expected = 'active';
      final actual = optionaltypes.formatStatus(status);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive, uppercase: true) returns \'INACTIVE\'', () {
      final status = ItemStatus.inactive;
      final uppercase = true;
      final expected = 'INACTIVE';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive, uppercase: false) returns \'inactive\'', () {
      final status = ItemStatus.inactive;
      final uppercase = false;
      final expected = 'inactive';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive) returns \'inactive\'', () {
      final status = ItemStatus.inactive;
      final expected = 'inactive';
      final actual = optionaltypes.formatStatus(status);
      expect(actual, expected);
    });
  });

  group('processItem', () {
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 0) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 0;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 1) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 1;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -1) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -1;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 2) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 2;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -2) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -2;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 10) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 10;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -10) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -10;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\')) returns 0', () {
      final item = CustomItem(id: 0, name: '');
      final expected = 0;
      final actual = optionaltypes.processItem(item);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 0) returns 0', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 0;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 1) returns 255', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 1;
      final expected = 255;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -1) returns -255', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -1;
      final expected = -255;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 2) returns 510', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 2;
      final expected = 510;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -2) returns -510', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -2;
      final expected = -510;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 10) returns 2550', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 10;
      final expected = 2550;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -10) returns -2550', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -10;
      final expected = -2550;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\')) returns 255', () {
      final item = CustomItem(id: 255, name: 'test');
      final expected = 255;
      final actual = optionaltypes.processItem(item);
      expect(actual, expected);
    });
  });

  group('getAnother', () {
    test('getAnother(0) returns AnotherClass(\'Title 0\', 0.0)', () {
      final i = 0;
      final expected = AnotherClass('Title 0', 0.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(1) returns AnotherClass(\'Title 1\', 1.0)', () {
      final i = 1;
      final expected = AnotherClass('Title 1', 1.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-1) returns AnotherClass(\'Title -1\', -1.0)', () {
      final i = -1;
      final expected = AnotherClass('Title -1', -1.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(2) returns AnotherClass(\'Title 2\', 2.0)', () {
      final i = 2;
      final expected = AnotherClass('Title 2', 2.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-2) returns AnotherClass(\'Title -2\', -2.0)', () {
      final i = -2;
      final expected = AnotherClass('Title -2', -2.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(10) returns AnotherClass(\'Title 10\', 10.0)', () {
      final i = 10;
      final expected = AnotherClass('Title 10', 10.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-10) returns AnotherClass(\'Title -10\', -10.0)', () {
      final i = -10;
      final expected = AnotherClass('Title -10', -10.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
  });

  group('findId', () {
    test('findId(\'\') returns null', () {
      final name = '';
      final actual = optionaltypes.findId(name);
      expect(actual, isNull);
    });
    test('findId(\'hello\') returns null', () {
      final name = 'hello';
      final actual = optionaltypes.findId(name);
      expect(actual, isNull);
    });
    test('findId(\'  \') returns null', () {
      final name = '  ';
      final actual = optionaltypes.findId(name);
      expect(actual, isNull);
    });
    test('findId(\'admin\') returns 1', () {
      final name = 'admin';
      final expected = 1;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
    test('findId(\'guest\') returns 0', () {
      final name = 'guest';
      final expected = 0;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
  });

  group('findItem', () {
    test('findItem(0) returns null', () {
      final id = 0;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
    test('findItem(1) returns CustomItem(id: 1, name: \'Item 1\')', () {
      final id = 1;
      final expected = CustomItem(id: 1, name: 'Item 1');
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(-1) returns null', () {
      final id = -1;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
    test('findItem(2) returns null', () {
      final id = 2;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
    test('findItem(-2) returns null', () {
      final id = -2;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
    test('findItem(10) returns null', () {
      final id = 10;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
    test('findItem(-10) returns null', () {
      final id = -10;
      final actual = optionaltypes.findItem(id);
      expect(actual, isNull);
    });
  });

}
