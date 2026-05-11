import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/stress_showcase.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T19:15:32.423942

void main() {
  final stressshowcase = StressShowcase();

  group('divide', () {
    test('divide(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = -1;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = -1;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 8;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 6;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 6;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = 8;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
    test('divide(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 7;
      final actual = stressshowcase.divide(a, b);
      expect(actual, expected);
    });
  });

  group('normalize', () {
    test('normalize(\'\')', () {
      final input = '';
      final expected = '__empty__';
      final actual = stressshowcase.normalize(input);
      expect(actual, expected);
    });
    test('normalize(\'hello\')', () {
      final input = 'hello';
      final expected = 'hello';
      final actual = stressshowcase.normalize(input);
      expect(actual, expected);
    });
    test('normalize(\'  \')', () {
      final input = '  ';
      final expected = '__empty__';
      final actual = stressshowcase.normalize(input);
      expect(actual, expected);
    });
  });

  group('processInts', () {
    test('processInts(<int>[])', () {
      final values = <int>[];
      final expected = [0];
      final actual = stressshowcase.processInts(values);
      expect(actual, expected);
    });
    test('processInts([0])', () {
      final values = [0];
      final expected = [0];
      final actual = stressshowcase.processInts(values);
      expect(actual, expected);
    });
    test('processInts([1, -1, 2])', () {
      final values = [1, -1, 2];
      final expected = [0, 1];
      final actual = stressshowcase.processInts(values);
      expect(actual, expected);
    });
  });

  group('tribonacci', () {
    test('tribonacci(-1) throws ArgumentError', () {
      final n = -1;
      expect(() => stressshowcase.tribonacci(n), throwsA(isA<ArgumentError>()));
    });
    test('tribonacci(-2) throws ArgumentError', () {
      final n = -2;
      expect(() => stressshowcase.tribonacci(n), throwsA(isA<ArgumentError>()));
    });
    test('tribonacci(-10) throws ArgumentError', () {
      final n = -10;
      expect(() => stressshowcase.tribonacci(n), throwsA(isA<ArgumentError>()));
    });
    test('tribonacci(0)', () {
      final n = 0;
      final expected = 0;
      final actual = stressshowcase.tribonacci(n);
      expect(actual, expected);
    });
    test('tribonacci(1)', () {
      final n = 1;
      final expected = 1;
      final actual = stressshowcase.tribonacci(n);
      expect(actual, expected);
    });
    test('tribonacci(2)', () {
      final n = 2;
      final expected = 1;
      final actual = stressshowcase.tribonacci(n);
      expect(actual, expected);
    });
    test('tribonacci(10)', () {
      final n = 10;
      final expected = 149;
      final actual = stressshowcase.tribonacci(n);
      expect(actual, expected);
    });
  });

  group('runLengthEncode', () {
    test('runLengthEncode(\'\')', () {
      final s = '';
      final expected = '';
      final actual = stressshowcase.runLengthEncode(s);
      expect(actual, expected);
    });
    test('runLengthEncode(\'hello\')', () {
      final s = 'hello';
      final expected = 'h1e1l2o1';
      final actual = stressshowcase.runLengthEncode(s);
      expect(actual, expected);
    });
    test('runLengthEncode(\'  \')', () {
      final s = '  ';
      final expected = ' 2';
      final actual = stressshowcase.runLengthEncode(s);
      expect(actual, expected);
    });
  });

  group('getter callCount', () {
    test('getter callCount', () {

      final expected = 3;
      final actual = stressshowcase.callCount;
      expect(actual, expected);
    });
  });

}
