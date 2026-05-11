import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/calculator.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T20:22:32.816797

void main() {
  final calculator = Calculator();

  group('mul', () {
    test('mul(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 1;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = -1;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 2;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -2;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 10;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -10;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = 0;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = -1;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 1;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = -2;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 2;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
    test('mul(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = -10;
      final actual = calculator.mul(a, b);
      expect(actual, expected);
    });
  });

  group('add', () {
    test('add(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 2;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 3;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 11;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -9;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = -2;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = -3;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
    test('add(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 9;
      final actual = calculator.add(a, b);
      expect(actual, expected);
    });
  });

  group('sub', () {
    test('sub(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = -1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = -2;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 2;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = -10;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 10;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 0;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 2;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = -1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = 3;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = -9;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = 11;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = -2;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 0;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = -3;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 1;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
    test('sub(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = -11;
      final actual = calculator.sub(a, b);
      expect(actual, expected);
    });
  });

  group('divide', () {
    test('divide(0, 0) throws ArgumentError', () {
      final a = 0;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(1, 0) throws ArgumentError', () {
      final a = 1;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(-1, 0) throws ArgumentError', () {
      final a = -1;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(2, 0) throws ArgumentError', () {
      final a = 2;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(-2, 0) throws ArgumentError', () {
      final a = -2;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(10, 0) throws ArgumentError', () {
      final a = 10;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(-10, 0) throws ArgumentError', () {
      final a = -10;
      final b = 0;
      expect(() => calculator.divide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('divide(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 0.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 1.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = -1.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 0.5;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -0.5;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 0.1;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -0.1;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = -1.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 1.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = -0.5;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 0.5;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = -0.1;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(-1, -10)', () {
      final a = -1;
      final b = -10;
      final expected = 0.1;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(2, 1)', () {
      final a = 2;
      final b = 1;
      final expected = 2.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('divide(2, -1)', () {
      final a = 2;
      final b = -1;
      final expected = -2.0;
      final actual = calculator.divide(a, b);
      expect(actual, closeTo(expected, 1e-7));
    });
  });

  group('intDivide', () {
    test('intDivide(0, 0) throws ArgumentError', () {
      final a = 0;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(1, 0) throws ArgumentError', () {
      final a = 1;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(-1, 0) throws ArgumentError', () {
      final a = -1;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(2, 0) throws ArgumentError', () {
      final a = 2;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(-2, 0) throws ArgumentError', () {
      final a = -2;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(10, 0) throws ArgumentError', () {
      final a = 10;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(-10, 0) throws ArgumentError', () {
      final a = -10;
      final b = 0;
      expect(() => calculator.intDivide(a, b), throwsA(isA<ArgumentError>()));
    });
    test('intDivide(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 1;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = -1;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = -1;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 1;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(-1, -10)', () {
      final a = -1;
      final b = -10;
      final expected = 0;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(2, 1)', () {
      final a = 2;
      final b = 1;
      final expected = 2;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
    test('intDivide(2, -1)', () {
      final a = 2;
      final b = -1;
      final expected = -2;
      final actual = calculator.intDivide(a, b);
      expect(actual, expected);
    });
  });

  group('mod', () {
    test('mod(0, 0) throws ArgumentError', () {
      final a = 0;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(1, 0) throws ArgumentError', () {
      final a = 1;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(-1, 0) throws ArgumentError', () {
      final a = -1;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(2, 0) throws ArgumentError', () {
      final a = 2;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(-2, 0) throws ArgumentError', () {
      final a = -2;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(10, 0) throws ArgumentError', () {
      final a = 10;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(-10, 0) throws ArgumentError', () {
      final a = -10;
      final b = 0;
      expect(() => calculator.mod(a, b), throwsA(isA<ArgumentError>()));
    });
    test('mod(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 1;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 9;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(-1, -10)', () {
      final a = -1;
      final b = -10;
      final expected = 9;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(2, 1)', () {
      final a = 2;
      final b = 1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
    test('mod(2, -1)', () {
      final a = 2;
      final b = -1;
      final expected = 0;
      final actual = calculator.mod(a, b);
      expect(actual, expected);
    });
  });

  group('pow', () {
    test('pow(0, -1) throws ArgumentError', () {
      final base = 0;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(0, -2) throws ArgumentError', () {
      final base = 0;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(0, -10) throws ArgumentError', () {
      final base = 0;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(1, -1) throws ArgumentError', () {
      final base = 1;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(1, -2) throws ArgumentError', () {
      final base = 1;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(1, -10) throws ArgumentError', () {
      final base = 1;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-1, -1) throws ArgumentError', () {
      final base = -1;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-1, -2) throws ArgumentError', () {
      final base = -1;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-1, -10) throws ArgumentError', () {
      final base = -1;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(2, -1) throws ArgumentError', () {
      final base = 2;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(2, -2) throws ArgumentError', () {
      final base = 2;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(2, -10) throws ArgumentError', () {
      final base = 2;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-2, -1) throws ArgumentError', () {
      final base = -2;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-2, -2) throws ArgumentError', () {
      final base = -2;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-2, -10) throws ArgumentError', () {
      final base = -2;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(10, -1) throws ArgumentError', () {
      final base = 10;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(10, -2) throws ArgumentError', () {
      final base = 10;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(10, -10) throws ArgumentError', () {
      final base = 10;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-10, -1) throws ArgumentError', () {
      final base = -10;
      final exp = -1;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-10, -2) throws ArgumentError', () {
      final base = -10;
      final exp = -2;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(-10, -10) throws ArgumentError', () {
      final base = -10;
      final exp = -10;
      expect(() => calculator.pow(base, exp), throwsA(isA<ArgumentError>()));
    });
    test('pow(0, 0)', () {
      final base = 0;
      final exp = 0;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(0, 1)', () {
      final base = 0;
      final exp = 1;
      final expected = 0;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(0, 2)', () {
      final base = 0;
      final exp = 2;
      final expected = 0;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(0, 10)', () {
      final base = 0;
      final exp = 10;
      final expected = 0;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(1, 0)', () {
      final base = 1;
      final exp = 0;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(1, 1)', () {
      final base = 1;
      final exp = 1;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(1, 2)', () {
      final base = 1;
      final exp = 2;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(1, 10)', () {
      final base = 1;
      final exp = 10;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-1, 0)', () {
      final base = -1;
      final exp = 0;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-1, 1)', () {
      final base = -1;
      final exp = 1;
      final expected = -1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-1, 2)', () {
      final base = -1;
      final exp = 2;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-1, 10)', () {
      final base = -1;
      final exp = 10;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(2, 0)', () {
      final base = 2;
      final exp = 0;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(2, 1)', () {
      final base = 2;
      final exp = 1;
      final expected = 2;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(2, 2)', () {
      final base = 2;
      final exp = 2;
      final expected = 4;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(2, 10)', () {
      final base = 2;
      final exp = 10;
      final expected = 1024;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-2, 0)', () {
      final base = -2;
      final exp = 0;
      final expected = 1;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-2, 1)', () {
      final base = -2;
      final exp = 1;
      final expected = -2;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-2, 2)', () {
      final base = -2;
      final exp = 2;
      final expected = 4;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
    test('pow(-2, 10)', () {
      final base = -2;
      final exp = 10;
      final expected = 1024;
      final actual = calculator.pow(base, exp);
      expect(actual, expected);
    });
  });

  group('abs', () {
    test('abs(0)', () {
      final a = 0;
      final expected = 0;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(1)', () {
      final a = 1;
      final expected = 1;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(-1)', () {
      final a = -1;
      final expected = 1;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(2)', () {
      final a = 2;
      final expected = 2;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(-2)', () {
      final a = -2;
      final expected = 2;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(10)', () {
      final a = 10;
      final expected = 10;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
    test('abs(-10)', () {
      final a = -10;
      final expected = 10;
      final actual = calculator.abs(a);
      expect(actual, expected);
    });
  });

  group('max', () {
    test('max(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 0;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 0;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 0;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 2;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 10;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = 0;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = -1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 2;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = -1;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
    test('max(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 10;
      final actual = calculator.max(a, b);
      expect(actual, expected);
    });
  });

  group('min', () {
    test('min(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 0;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 0;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 0;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 0;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -2;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -10;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = -2;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
    test('min(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = -1;
      final actual = calculator.min(a, b);
      expect(actual, expected);
    });
  });

  group('isEven', () {
    test('isEven(0)', () {
      final a = 0;
      final expected = true;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(1)', () {
      final a = 1;
      final expected = false;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(-1)', () {
      final a = -1;
      final expected = false;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(2)', () {
      final a = 2;
      final expected = true;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(-2)', () {
      final a = -2;
      final expected = true;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(10)', () {
      final a = 10;
      final expected = true;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
    test('isEven(-10)', () {
      final a = -10;
      final expected = true;
      final actual = calculator.isEven(a);
      expect(actual, expected);
    });
  });

  group('isOdd', () {
    test('isOdd(0)', () {
      final a = 0;
      final expected = false;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(1)', () {
      final a = 1;
      final expected = true;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(-1)', () {
      final a = -1;
      final expected = true;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(2)', () {
      final a = 2;
      final expected = false;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(-2)', () {
      final a = -2;
      final expected = false;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(10)', () {
      final a = 10;
      final expected = false;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
    test('isOdd(-10)', () {
      final a = -10;
      final expected = false;
      final actual = calculator.isOdd(a);
      expect(actual, expected);
    });
  });

  group('factorial', () {
    test('factorial(-1) throws ArgumentError', () {
      final n = -1;
      expect(() => calculator.factorial(n), throwsA(isA<ArgumentError>()));
    });
    test('factorial(-2) throws ArgumentError', () {
      final n = -2;
      expect(() => calculator.factorial(n), throwsA(isA<ArgumentError>()));
    });
    test('factorial(-10) throws ArgumentError', () {
      final n = -10;
      expect(() => calculator.factorial(n), throwsA(isA<ArgumentError>()));
    });
    test('factorial(0)', () {
      final n = 0;
      final expected = 1;
      final actual = calculator.factorial(n);
      expect(actual, expected);
    });
    test('factorial(1)', () {
      final n = 1;
      final expected = 1;
      final actual = calculator.factorial(n);
      expect(actual, expected);
    });
    test('factorial(2)', () {
      final n = 2;
      final expected = 2;
      final actual = calculator.factorial(n);
      expect(actual, expected);
    });
    test('factorial(10)', () {
      final n = 10;
      final expected = 3628800;
      final actual = calculator.factorial(n);
      expect(actual, expected);
    });
  });

  group('clamp', () {
    test('clamp(0, 0, -1) throws ArgumentError', () {
      final value = 0;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 0, -2) throws ArgumentError', () {
      final value = 0;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 0, -10) throws ArgumentError', () {
      final value = 0;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 1, 0) throws ArgumentError', () {
      final value = 0;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 1, -1) throws ArgumentError', () {
      final value = 0;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 1, -2) throws ArgumentError', () {
      final value = 0;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 1, -10) throws ArgumentError', () {
      final value = 0;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, -1, -2) throws ArgumentError', () {
      final value = 0;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, -1, -10) throws ArgumentError', () {
      final value = 0;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 2, 0) throws ArgumentError', () {
      final value = 0;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 2, 1) throws ArgumentError', () {
      final value = 0;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 2, -1) throws ArgumentError', () {
      final value = 0;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 2, -2) throws ArgumentError', () {
      final value = 0;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 2, -10) throws ArgumentError', () {
      final value = 0;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, -2, -10) throws ArgumentError', () {
      final value = 0;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, 0) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, 1) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, -1) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, 2) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, -2) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 10, -10) throws ArgumentError', () {
      final value = 0;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 0, -1) throws ArgumentError', () {
      final value = 1;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 0, -2) throws ArgumentError', () {
      final value = 1;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 0, -10) throws ArgumentError', () {
      final value = 1;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 1, 0) throws ArgumentError', () {
      final value = 1;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 1, -1) throws ArgumentError', () {
      final value = 1;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 1, -2) throws ArgumentError', () {
      final value = 1;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 1, -10) throws ArgumentError', () {
      final value = 1;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, -1, -2) throws ArgumentError', () {
      final value = 1;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, -1, -10) throws ArgumentError', () {
      final value = 1;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 2, 0) throws ArgumentError', () {
      final value = 1;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 2, 1) throws ArgumentError', () {
      final value = 1;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 2, -1) throws ArgumentError', () {
      final value = 1;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 2, -2) throws ArgumentError', () {
      final value = 1;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 2, -10) throws ArgumentError', () {
      final value = 1;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, -2, -10) throws ArgumentError', () {
      final value = 1;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, 0) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, 1) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, -1) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, 2) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, -2) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(1, 10, -10) throws ArgumentError', () {
      final value = 1;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 0, -1) throws ArgumentError', () {
      final value = -1;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 0, -2) throws ArgumentError', () {
      final value = -1;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 0, -10) throws ArgumentError', () {
      final value = -1;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 1, 0) throws ArgumentError', () {
      final value = -1;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 1, -1) throws ArgumentError', () {
      final value = -1;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 1, -2) throws ArgumentError', () {
      final value = -1;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 1, -10) throws ArgumentError', () {
      final value = -1;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, -1, -2) throws ArgumentError', () {
      final value = -1;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, -1, -10) throws ArgumentError', () {
      final value = -1;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 2, 0) throws ArgumentError', () {
      final value = -1;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 2, 1) throws ArgumentError', () {
      final value = -1;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 2, -1) throws ArgumentError', () {
      final value = -1;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 2, -2) throws ArgumentError', () {
      final value = -1;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 2, -10) throws ArgumentError', () {
      final value = -1;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, -2, -10) throws ArgumentError', () {
      final value = -1;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, 0) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, 1) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, -1) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, 2) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, -2) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-1, 10, -10) throws ArgumentError', () {
      final value = -1;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 0, -1) throws ArgumentError', () {
      final value = 2;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 0, -2) throws ArgumentError', () {
      final value = 2;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 0, -10) throws ArgumentError', () {
      final value = 2;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 1, 0) throws ArgumentError', () {
      final value = 2;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 1, -1) throws ArgumentError', () {
      final value = 2;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 1, -2) throws ArgumentError', () {
      final value = 2;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 1, -10) throws ArgumentError', () {
      final value = 2;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, -1, -2) throws ArgumentError', () {
      final value = 2;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, -1, -10) throws ArgumentError', () {
      final value = 2;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 2, 0) throws ArgumentError', () {
      final value = 2;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 2, 1) throws ArgumentError', () {
      final value = 2;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 2, -1) throws ArgumentError', () {
      final value = 2;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 2, -2) throws ArgumentError', () {
      final value = 2;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 2, -10) throws ArgumentError', () {
      final value = 2;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, -2, -10) throws ArgumentError', () {
      final value = 2;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, 0) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, 1) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, -1) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, 2) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, -2) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(2, 10, -10) throws ArgumentError', () {
      final value = 2;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 0, -1) throws ArgumentError', () {
      final value = -2;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 0, -2) throws ArgumentError', () {
      final value = -2;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 0, -10) throws ArgumentError', () {
      final value = -2;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 1, 0) throws ArgumentError', () {
      final value = -2;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 1, -1) throws ArgumentError', () {
      final value = -2;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 1, -2) throws ArgumentError', () {
      final value = -2;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 1, -10) throws ArgumentError', () {
      final value = -2;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, -1, -2) throws ArgumentError', () {
      final value = -2;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, -1, -10) throws ArgumentError', () {
      final value = -2;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 2, 0) throws ArgumentError', () {
      final value = -2;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 2, 1) throws ArgumentError', () {
      final value = -2;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 2, -1) throws ArgumentError', () {
      final value = -2;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 2, -2) throws ArgumentError', () {
      final value = -2;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 2, -10) throws ArgumentError', () {
      final value = -2;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, -2, -10) throws ArgumentError', () {
      final value = -2;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, 0) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, 1) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, -1) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, 2) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, -2) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-2, 10, -10) throws ArgumentError', () {
      final value = -2;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 0, -1) throws ArgumentError', () {
      final value = 10;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 0, -2) throws ArgumentError', () {
      final value = 10;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 0, -10) throws ArgumentError', () {
      final value = 10;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 1, 0) throws ArgumentError', () {
      final value = 10;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 1, -1) throws ArgumentError', () {
      final value = 10;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 1, -2) throws ArgumentError', () {
      final value = 10;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 1, -10) throws ArgumentError', () {
      final value = 10;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, -1, -2) throws ArgumentError', () {
      final value = 10;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, -1, -10) throws ArgumentError', () {
      final value = 10;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 2, 0) throws ArgumentError', () {
      final value = 10;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 2, 1) throws ArgumentError', () {
      final value = 10;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 2, -1) throws ArgumentError', () {
      final value = 10;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 2, -2) throws ArgumentError', () {
      final value = 10;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 2, -10) throws ArgumentError', () {
      final value = 10;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, -2, -10) throws ArgumentError', () {
      final value = 10;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, 0) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, 1) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, -1) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, 2) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, -2) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(10, 10, -10) throws ArgumentError', () {
      final value = 10;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 0, -1) throws ArgumentError', () {
      final value = -10;
      final min = 0;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 0, -2) throws ArgumentError', () {
      final value = -10;
      final min = 0;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 0, -10) throws ArgumentError', () {
      final value = -10;
      final min = 0;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 1, 0) throws ArgumentError', () {
      final value = -10;
      final min = 1;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 1, -1) throws ArgumentError', () {
      final value = -10;
      final min = 1;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 1, -2) throws ArgumentError', () {
      final value = -10;
      final min = 1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 1, -10) throws ArgumentError', () {
      final value = -10;
      final min = 1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, -1, -2) throws ArgumentError', () {
      final value = -10;
      final min = -1;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, -1, -10) throws ArgumentError', () {
      final value = -10;
      final min = -1;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 2, 0) throws ArgumentError', () {
      final value = -10;
      final min = 2;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 2, 1) throws ArgumentError', () {
      final value = -10;
      final min = 2;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 2, -1) throws ArgumentError', () {
      final value = -10;
      final min = 2;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 2, -2) throws ArgumentError', () {
      final value = -10;
      final min = 2;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 2, -10) throws ArgumentError', () {
      final value = -10;
      final min = 2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, -2, -10) throws ArgumentError', () {
      final value = -10;
      final min = -2;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, 0) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = 0;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, 1) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = 1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, -1) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = -1;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, 2) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = 2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, -2) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = -2;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(-10, 10, -10) throws ArgumentError', () {
      final value = -10;
      final min = 10;
      final max = -10;
      expect(() => calculator.clamp(value, min, max), throwsA(isA<ArgumentError>()));
    });
    test('clamp(0, 0, 0)', () {
      final value = 0;
      final min = 0;
      final max = 0;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 0, 1)', () {
      final value = 0;
      final min = 0;
      final max = 1;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 0, 2)', () {
      final value = 0;
      final min = 0;
      final max = 2;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 0, 10)', () {
      final value = 0;
      final min = 0;
      final max = 10;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 1, 1)', () {
      final value = 0;
      final min = 1;
      final max = 1;
      final expected = 1;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 1, 2)', () {
      final value = 0;
      final min = 1;
      final max = 2;
      final expected = 1;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 1, 10)', () {
      final value = 0;
      final min = 1;
      final max = 10;
      final expected = 1;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -1, 0)', () {
      final value = 0;
      final min = -1;
      final max = 0;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -1, 1)', () {
      final value = 0;
      final min = -1;
      final max = 1;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -1, -1)', () {
      final value = 0;
      final min = -1;
      final max = -1;
      final expected = -1;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -1, 2)', () {
      final value = 0;
      final min = -1;
      final max = 2;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -1, 10)', () {
      final value = 0;
      final min = -1;
      final max = 10;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 2, 2)', () {
      final value = 0;
      final min = 2;
      final max = 2;
      final expected = 2;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, 2, 10)', () {
      final value = 0;
      final min = 2;
      final max = 10;
      final expected = 2;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, 0)', () {
      final value = 0;
      final min = -2;
      final max = 0;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, 1)', () {
      final value = 0;
      final min = -2;
      final max = 1;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, -1)', () {
      final value = 0;
      final min = -2;
      final max = -1;
      final expected = -1;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, 2)', () {
      final value = 0;
      final min = -2;
      final max = 2;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, -2)', () {
      final value = 0;
      final min = -2;
      final max = -2;
      final expected = -2;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
    test('clamp(0, -2, 10)', () {
      final value = 0;
      final min = -2;
      final max = 10;
      final expected = 0;
      final actual = calculator.clamp(value, min, max);
      expect(actual, expected);
    });
  });

}
