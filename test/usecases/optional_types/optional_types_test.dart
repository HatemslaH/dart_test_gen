import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/optional_types/optional_types.dart';
import 'package:dart_test_gen/usecases/optional_types/another_class.dart';
import 'package:dart_test_gen/usecases/optional_types/custom_item.dart';
import 'package:dart_test_gen/usecases/optional_types/item_status.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T02:09:02.897357

void main() {
  final optionaltypes = OptionalTypes();

  group('sumNullable', () {
    test('sumNullable(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(0, null)', () {
      final a = 0;
      final b = null;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 3;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 11;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -9;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(1, null)', () {
      final a = 1;
      final b = null;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = -2;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
    test('sumNullable(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = optionaltypes.sumNullable(a, b);
      expect(actual, expected);
    });
  });

  group('greet', () {
    test('greet(\'\', \'\')', () {
      final name = '';
      final prefix = '';
      final expected = ' ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', \'hello\')', () {
      final name = '';
      final prefix = 'hello';
      final expected = 'hello ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', \'  \')', () {
      final name = '';
      final prefix = '  ';
      final expected = '   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\', null)', () {
      final name = '';
      final prefix = null;
      final expected = 'Hello ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'\')', () {
      final name = '';
      final expected = 'Hello ';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'\')', () {
      final name = 'hello';
      final prefix = '';
      final expected = ' hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'hello\')', () {
      final name = 'hello';
      final prefix = 'hello';
      final expected = 'hello hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', \'  \')', () {
      final name = 'hello';
      final prefix = '  ';
      final expected = '   hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\', null)', () {
      final name = 'hello';
      final prefix = null;
      final expected = 'Hello hello';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'hello\')', () {
      final name = 'hello';
      final expected = 'Hello hello';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
    test('greet(\'  \', \'\')', () {
      final name = '  ';
      final prefix = '';
      final expected = '   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', \'hello\')', () {
      final name = '  ';
      final prefix = 'hello';
      final expected = 'hello   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', \'  \')', () {
      final name = '  ';
      final prefix = '  ';
      final expected = '     ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \', null)', () {
      final name = '  ';
      final prefix = null;
      final expected = 'Hello   ';
      final actual = optionaltypes.greet(name, prefix);
      expect(actual, expected);
    });
    test('greet(\'  \')', () {
      final name = '  ';
      final expected = 'Hello   ';
      final actual = optionaltypes.greet(name);
      expect(actual, expected);
    });
  });

  group('calculate', () {
    test('calculate(0, y: 0, z: 0)', () {
      final x = 0;
      final y = 0;
      final z = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 1)', () {
      final x = 0;
      final y = 0;
      final z = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -1)', () {
      final x = 0;
      final y = 0;
      final z = -1;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 2)', () {
      final x = 0;
      final y = 0;
      final z = 2;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -2)', () {
      final x = 0;
      final y = 0;
      final z = -2;
      final expected = -2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: 10)', () {
      final x = 0;
      final y = 0;
      final z = 10;
      final expected = 10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: -10)', () {
      final x = 0;
      final y = 0;
      final z = -10;
      final expected = -10;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0, z: null)', () {
      final x = 0;
      final y = 0;
      final z = null;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 0)', () {
      final x = 0;
      final y = 0;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 0)', () {
      final x = 0;
      final y = 1;
      final z = 0;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 1)', () {
      final x = 0;
      final y = 1;
      final z = 1;
      final expected = 2;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -1)', () {
      final x = 0;
      final y = 1;
      final z = -1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 2)', () {
      final x = 0;
      final y = 1;
      final z = 2;
      final expected = 3;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -2)', () {
      final x = 0;
      final y = 1;
      final z = -2;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: 10)', () {
      final x = 0;
      final y = 1;
      final z = 10;
      final expected = 11;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: -10)', () {
      final x = 0;
      final y = 1;
      final z = -10;
      final expected = -9;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1, z: null)', () {
      final x = 0;
      final y = 1;
      final z = null;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: 1)', () {
      final x = 0;
      final y = 1;
      final expected = 1;
      final actual = optionaltypes.calculate(x, y: y);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 0)', () {
      final x = 0;
      final y = -1;
      final z = 0;
      final expected = -1;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
    test('calculate(0, y: -1, z: 1)', () {
      final x = 0;
      final y = -1;
      final z = 1;
      final expected = 0;
      final actual = optionaltypes.calculate(x, y: y, z: z);
      expect(actual, expected);
    });
  });

  group('formatStatus', () {
    test('formatStatus(ItemStatus.active, uppercase: true)', () {
      final status = ItemStatus.active;
      final uppercase = true;
      final expected = 'ACTIVE';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.active, uppercase: false)', () {
      final status = ItemStatus.active;
      final uppercase = false;
      final expected = 'active';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.active)', () {
      final status = ItemStatus.active;
      final expected = 'active';
      final actual = optionaltypes.formatStatus(status);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive, uppercase: true)', () {
      final status = ItemStatus.inactive;
      final uppercase = true;
      final expected = 'INACTIVE';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive, uppercase: false)', () {
      final status = ItemStatus.inactive;
      final uppercase = false;
      final expected = 'inactive';
      final actual = optionaltypes.formatStatus(status, uppercase: uppercase);
      expect(actual, expected);
    });
    test('formatStatus(ItemStatus.inactive)', () {
      final status = ItemStatus.inactive;
      final expected = 'inactive';
      final actual = optionaltypes.formatStatus(status);
      expect(actual, expected);
    });
  });

  group('processItem', () {
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 0)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 0;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 1)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 1;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -1)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -1;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 2)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 2;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -2)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -2;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: 10)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = 10;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'), multiplier: -10)', () {
      final item = CustomItem(id: 0, name: '');
      final multiplier = -10;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 0, name: \'\'))', () {
      final item = CustomItem(id: 0, name: '');
      final expected = 0;
      final actual = optionaltypes.processItem(item);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 0)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 0;
      final expected = 0;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 1)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 1;
      final expected = 255;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -1)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -1;
      final expected = -255;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 2)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 2;
      final expected = 510;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -2)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -2;
      final expected = -510;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: 10)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = 10;
      final expected = 2550;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'), multiplier: -10)', () {
      final item = CustomItem(id: 255, name: 'test');
      final multiplier = -10;
      final expected = -2550;
      final actual = optionaltypes.processItem(item, multiplier: multiplier);
      expect(actual, expected);
    });
    test('processItem(CustomItem(id: 255, name: \'test\'))', () {
      final item = CustomItem(id: 255, name: 'test');
      final expected = 255;
      final actual = optionaltypes.processItem(item);
      expect(actual, expected);
    });
  });

  group('getAnother', () {
    test('getAnother(0)', () {
      final i = 0;
      final expected = AnotherClass('Title 0', 0.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(1)', () {
      final i = 1;
      final expected = AnotherClass('Title 1', 1.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-1)', () {
      final i = -1;
      final expected = AnotherClass('Title -1', -1.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(2)', () {
      final i = 2;
      final expected = AnotherClass('Title 2', 2.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-2)', () {
      final i = -2;
      final expected = AnotherClass('Title -2', -2.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(10)', () {
      final i = 10;
      final expected = AnotherClass('Title 10', 10.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
    test('getAnother(-10)', () {
      final i = -10;
      final expected = AnotherClass('Title -10', -10.0);
      final actual = optionaltypes.getAnother(i);
      expect(actual, expected);
    });
  });

  group('findId', () {
    test('findId(\'\')', () {
      final name = '';
      final expected = null;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
    test('findId(\'hello\')', () {
      final name = 'hello';
      final expected = null;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
    test('findId(\'  \')', () {
      final name = '  ';
      final expected = null;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
    test('findId(\'admin\')', () {
      final name = 'admin';
      final expected = 1;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
    test('findId(\'guest\')', () {
      final name = 'guest';
      final expected = 0;
      final actual = optionaltypes.findId(name);
      expect(actual, expected);
    });
  });

  group('findItem', () {
    test('findItem(0)', () {
      final id = 0;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(1)', () {
      final id = 1;
      final expected = CustomItem(id: 1, name: 'Item 1');
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(-1)', () {
      final id = -1;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(2)', () {
      final id = 2;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(-2)', () {
      final id = -2;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(10)', () {
      final id = 10;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
    test('findItem(-10)', () {
      final id = -10;
      final expected = null;
      final actual = optionaltypes.findItem(id);
      expect(actual, expected);
    });
  });

}
