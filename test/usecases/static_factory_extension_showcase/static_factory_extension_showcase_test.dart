import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/static_factory_extension_showcase/static_factory_extension_showcase.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T15:46:24.540329

void main() {
  group('getDefaultName', () {
    test('getDefaultName()', () {

      final expected = 'Guest';
      final actual = User.getDefaultName();
      expect(actual, expected);
    });
  });

  group('calculateBirthYear', () {
    test('calculateBirthYear(0, -1) throws ArgumentError', () {
      final currentYear = 0;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(0, -2) throws ArgumentError', () {
      final currentYear = 0;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(0, -10) throws ArgumentError', () {
      final currentYear = 0;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(1, -1) throws ArgumentError', () {
      final currentYear = 1;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(1, -2) throws ArgumentError', () {
      final currentYear = 1;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(1, -10) throws ArgumentError', () {
      final currentYear = 1;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-1, -1) throws ArgumentError', () {
      final currentYear = -1;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-1, -2) throws ArgumentError', () {
      final currentYear = -1;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-1, -10) throws ArgumentError', () {
      final currentYear = -1;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(2, -1) throws ArgumentError', () {
      final currentYear = 2;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(2, -2) throws ArgumentError', () {
      final currentYear = 2;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(2, -10) throws ArgumentError', () {
      final currentYear = 2;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-2, -1) throws ArgumentError', () {
      final currentYear = -2;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-2, -2) throws ArgumentError', () {
      final currentYear = -2;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-2, -10) throws ArgumentError', () {
      final currentYear = -2;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(10, -1) throws ArgumentError', () {
      final currentYear = 10;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(10, -2) throws ArgumentError', () {
      final currentYear = 10;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(10, -10) throws ArgumentError', () {
      final currentYear = 10;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-10, -1) throws ArgumentError', () {
      final currentYear = -10;
      final age = -1;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-10, -2) throws ArgumentError', () {
      final currentYear = -10;
      final age = -2;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(-10, -10) throws ArgumentError', () {
      final currentYear = -10;
      final age = -10;
      expect(() => User.calculateBirthYear(currentYear, age), throwsA(isA<ArgumentError>()));
    });
    test('calculateBirthYear(0, 0)', () {
      final currentYear = 0;
      final age = 0;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 1)', () {
      final currentYear = 0;
      final age = 1;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 2)', () {
      final currentYear = 0;
      final age = 2;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 10)', () {
      final currentYear = 0;
      final age = 10;
      final expected = -10;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 0)', () {
      final currentYear = 1;
      final age = 0;
      final expected = 1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 1)', () {
      final currentYear = 1;
      final age = 1;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 2)', () {
      final currentYear = 1;
      final age = 2;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 10)', () {
      final currentYear = 1;
      final age = 10;
      final expected = -9;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 0)', () {
      final currentYear = -1;
      final age = 0;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 1)', () {
      final currentYear = -1;
      final age = 1;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 2)', () {
      final currentYear = -1;
      final age = 2;
      final expected = -3;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 10)', () {
      final currentYear = -1;
      final age = 10;
      final expected = -11;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 0)', () {
      final currentYear = 2;
      final age = 0;
      final expected = 2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 1)', () {
      final currentYear = 2;
      final age = 1;
      final expected = 1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 2)', () {
      final currentYear = 2;
      final age = 2;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 10)', () {
      final currentYear = 2;
      final age = 10;
      final expected = -8;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 0)', () {
      final currentYear = -2;
      final age = 0;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 1)', () {
      final currentYear = -2;
      final age = 1;
      final expected = -3;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 2)', () {
      final currentYear = -2;
      final age = 2;
      final expected = -4;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 10)', () {
      final currentYear = -2;
      final age = 10;
      final expected = -12;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
  });

  group('guest', () {
    test('guest()', () {

      final expected = User('Guest', 0);
      final actual = User.guest();
      expect(actual, expected);
    });
  });

  group('admin', () {
    test('admin(\'\')', () {
      final name = '';
      final expected = User('Guest', 0);
      final actual = User.admin(name);
      expect(actual, expected);
    });
    test('admin(\'hello\')', () {
      final name = 'hello';
      final expected = User('hello', 99);
      final actual = User.admin(name);
      expect(actual, expected);
    });
    test('admin(\'  \')', () {
      final name = '  ';
      final expected = User('  ', 99);
      final actual = User.admin(name);
      expect(actual, expected);
    });
  });

}
