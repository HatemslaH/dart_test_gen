import 'package:test/test.dart';
import 'package:example/usecases/exception_throws_showcase.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:13:25.946066

void main() {
  final exceptionthrowsshowcase = ExceptionThrowsShowcase();

  group('needPositive', () {
    test('needPositive(0) throws Exception', () {
      final x = 0;
      expect(() => exceptionthrowsshowcase.needPositive(x), throwsA(isA<Exception>()));
    });
    test('needPositive(-1) throws Exception', () {
      final x = -1;
      expect(() => exceptionthrowsshowcase.needPositive(x), throwsA(isA<Exception>()));
    });
    test('needPositive(-2) throws Exception', () {
      final x = -2;
      expect(() => exceptionthrowsshowcase.needPositive(x), throwsA(isA<Exception>()));
    });
    test('needPositive(-10) throws Exception', () {
      final x = -10;
      expect(() => exceptionthrowsshowcase.needPositive(x), throwsA(isA<Exception>()));
    });
    test('needPositive(1) returns 1', () {
      final x = 1;
      final expected = 1;
      final actual = exceptionthrowsshowcase.needPositive(x);
      expect(actual, expected);
    });
    test('needPositive(2) returns 2', () {
      final x = 2;
      final expected = 2;
      final actual = exceptionthrowsshowcase.needPositive(x);
      expect(actual, expected);
    });
    test('needPositive(10) returns 10', () {
      final x = 10;
      final expected = 10;
      final actual = exceptionthrowsshowcase.needPositive(x);
      expect(actual, expected);
    });
  });

  group('needNonZero', () {
    test('needNonZero(0) throws ArgumentError', () {
      final x = 0;
      expect(() => exceptionthrowsshowcase.needNonZero(x), throwsA(isA<ArgumentError>()));
    });
    test('needNonZero(1) returns 1', () {
      final x = 1;
      final expected = 1;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
    test('needNonZero(-1) returns -1', () {
      final x = -1;
      final expected = -1;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
    test('needNonZero(2) returns 2', () {
      final x = 2;
      final expected = 2;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
    test('needNonZero(-2) returns -2', () {
      final x = -2;
      final expected = -2;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
    test('needNonZero(10) returns 10', () {
      final x = 10;
      final expected = 10;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
    test('needNonZero(-10) returns -10', () {
      final x = -10;
      final expected = -10;
      final actual = exceptionthrowsshowcase.needNonZero(x);
      expect(actual, expected);
    });
  });

  group('requireOpen', () {
    test('requireOpen(false) throws StateError', () {
      final open = false;
      expect(() => exceptionthrowsshowcase.requireOpen(open), throwsA(isA<StateError>()));
    });
    test('requireOpen(true) returns \'open\'', () {
      final open = true;
      final expected = 'open';
      final actual = exceptionthrowsshowcase.requireOpen(open);
      expect(actual, expected);
    });
  });

  group('parseHex', () {
    test('parseHex(\'\') throws FormatException', () {
      final s = '';
      expect(() => exceptionthrowsshowcase.parseHex(s), throwsA(isA<FormatException>()));
    });
    test('parseHex(\'hello\') throws FormatException', () {
      final s = 'hello';
      expect(() => exceptionthrowsshowcase.parseHex(s), throwsA(isA<FormatException>()));
    });
    test('parseHex(\'  \') throws FormatException', () {
      final s = '  ';
      expect(() => exceptionthrowsshowcase.parseHex(s), throwsA(isA<FormatException>()));
    });
  });

  group('requireEven', () {
    test('requireEven(1) throws AssertionError', () {
      final x = 1;
      expect(() => exceptionthrowsshowcase.requireEven(x), throwsA(isA<AssertionError>()));
    });
    test('requireEven(-1) throws AssertionError', () {
      final x = -1;
      expect(() => exceptionthrowsshowcase.requireEven(x), throwsA(isA<AssertionError>()));
    });
    test('requireEven(0) returns 0', () {
      final x = 0;
      final expected = 0;
      final actual = exceptionthrowsshowcase.requireEven(x);
      expect(actual, expected);
    });
    test('requireEven(2) returns 2', () {
      final x = 2;
      final expected = 2;
      final actual = exceptionthrowsshowcase.requireEven(x);
      expect(actual, expected);
    });
    test('requireEven(-2) returns -2', () {
      final x = -2;
      final expected = -2;
      final actual = exceptionthrowsshowcase.requireEven(x);
      expect(actual, expected);
    });
    test('requireEven(10) returns 10', () {
      final x = 10;
      final expected = 10;
      final actual = exceptionthrowsshowcase.requireEven(x);
      expect(actual, expected);
    });
    test('requireEven(-10) returns -10', () {
      final x = -10;
      final expected = -10;
      final actual = exceptionthrowsshowcase.requireEven(x);
      expect(actual, expected);
    });
  });

}
