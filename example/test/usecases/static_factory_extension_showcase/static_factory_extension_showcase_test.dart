import 'package:test/test.dart';
import 'package:example/usecases/static_factory_extension_showcase/static_factory_extension_showcase.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:57:10.996019

void main() {
  final user = User('', 0);

  group('getDefaultName', () {
    test('getDefaultName returns \'Guest\'', () {

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
    test('calculateBirthYear(0, 0) returns 0', () {
      final currentYear = 0;
      final age = 0;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 1) returns -1', () {
      final currentYear = 0;
      final age = 1;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 2) returns -2', () {
      final currentYear = 0;
      final age = 2;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(0, 10) returns -10', () {
      final currentYear = 0;
      final age = 10;
      final expected = -10;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 0) returns 1', () {
      final currentYear = 1;
      final age = 0;
      final expected = 1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 1) returns 0', () {
      final currentYear = 1;
      final age = 1;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 2) returns -1', () {
      final currentYear = 1;
      final age = 2;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(1, 10) returns -9', () {
      final currentYear = 1;
      final age = 10;
      final expected = -9;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 0) returns -1', () {
      final currentYear = -1;
      final age = 0;
      final expected = -1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 1) returns -2', () {
      final currentYear = -1;
      final age = 1;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 2) returns -3', () {
      final currentYear = -1;
      final age = 2;
      final expected = -3;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-1, 10) returns -11', () {
      final currentYear = -1;
      final age = 10;
      final expected = -11;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 0) returns 2', () {
      final currentYear = 2;
      final age = 0;
      final expected = 2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 1) returns 1', () {
      final currentYear = 2;
      final age = 1;
      final expected = 1;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 2) returns 0', () {
      final currentYear = 2;
      final age = 2;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(2, 10) returns -8', () {
      final currentYear = 2;
      final age = 10;
      final expected = -8;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 0) returns -2', () {
      final currentYear = -2;
      final age = 0;
      final expected = -2;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 1) returns -3', () {
      final currentYear = -2;
      final age = 1;
      final expected = -3;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 2) returns -4', () {
      final currentYear = -2;
      final age = 2;
      final expected = -4;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-2, 10) returns -12', () {
      final currentYear = -2;
      final age = 10;
      final expected = -12;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(10, 0) returns 10', () {
      final currentYear = 10;
      final age = 0;
      final expected = 10;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(10, 1) returns 9', () {
      final currentYear = 10;
      final age = 1;
      final expected = 9;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(10, 2) returns 8', () {
      final currentYear = 10;
      final age = 2;
      final expected = 8;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(10, 10) returns 0', () {
      final currentYear = 10;
      final age = 10;
      final expected = 0;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-10, 0) returns -10', () {
      final currentYear = -10;
      final age = 0;
      final expected = -10;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-10, 1) returns -11', () {
      final currentYear = -10;
      final age = 1;
      final expected = -11;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-10, 2) returns -12', () {
      final currentYear = -10;
      final age = 2;
      final expected = -12;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
    test('calculateBirthYear(-10, 10) returns -20', () {
      final currentYear = -10;
      final age = 10;
      final expected = -20;
      final actual = User.calculateBirthYear(currentYear, age);
      expect(actual, expected);
    });
  });

  group('guest', () {
    test('guest returns User(\'Guest\', 0)', () {

      final expected = User('Guest', 0);
      final actual = User.guest();
      expect(actual, expected);
    });
  });

  group('admin', () {
    test('admin(\'\') returns User(\'Guest\', 0)', () {
      final name = '';
      final expected = User('Guest', 0);
      final actual = User.admin(name);
      expect(actual, expected);
    });
    test('admin(\'hello\') returns User(\'hello\', 99)', () {
      final name = 'hello';
      final expected = User('hello', 99);
      final actual = User.admin(name);
      expect(actual, expected);
    });
    test('admin(\'  \') returns User(\'  \', 99)', () {
      final name = '  ';
      final expected = User('  ', 99);
      final actual = User.admin(name);
      expect(actual, expected);
    });
  });

  group('operator ==', () {
    test('operator ==(0) returns false', () {
      final other = 0;
      final actual = user == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\') returns false', () {
      final other = 'str';
      final actual = user == other;
      expect(actual, isFalse);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = User('', 0);
      final right = User('', 0);
      expect(left.hashCode, right.hashCode);
    });
  });

}
