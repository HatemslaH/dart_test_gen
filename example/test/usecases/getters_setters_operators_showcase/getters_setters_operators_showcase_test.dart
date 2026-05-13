import 'package:test/test.dart';
import 'package:example/usecases/getters_setters_operators_showcase/getters_setters_operators_showcase.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:13:25.973904

void main() {
  final getterssettersoperatorsshowcase = GettersSettersOperatorsShowcase(a: 0);

  group('getter aValue', () {
    test('getter aValue returns 0', () {

      final expected = 0;
      final actual = getterssettersoperatorsshowcase.aValue;
      expect(actual, expected);
    });
  });

  group('setter aValue', () {
    test('setter aValue(-1001) throws StateError', () {
      final v = -1001;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, throwsA(isA<StateError>()));
    });
    test('setter aValue(0) runs without error', () {
      final v = 0;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(1) runs without error', () {
      final v = 1;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(-1) runs without error', () {
      final v = -1;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(2) runs without error', () {
      final v = 2;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(-2) runs without error', () {
      final v = -2;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(10) runs without error', () {
      final v = 10;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(-10) runs without error', () {
      final v = -10;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(-1000) runs without error', () {
      final v = -1000;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
    test('setter aValue(-999) runs without error', () {
      final v = -999;
      expect(() { getterssettersoperatorsshowcase.aValue = v; }, returnsNormally);
    });
  });

  group('getter defaultSeed', () {
    test('getter defaultSeed returns 42', () {

      final expected = 42;
      final actual = GettersSettersOperatorsShowcase.defaultSeed;
      expect(actual, expected);
    });
  });

  group('operator +', () {
    test('operator +(0) returns -999', () {
      final n = 0;
      final expected = -999;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(1) returns -998', () {
      final n = 1;
      final expected = -998;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(-1) returns -1000', () {
      final n = -1;
      final expected = -1000;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(2) returns -997', () {
      final n = 2;
      final expected = -997;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(-2) returns -1001', () {
      final n = -2;
      final expected = -1001;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(10) returns -989', () {
      final n = 10;
      final expected = -989;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
    test('operator +(-10) returns -1009', () {
      final n = -10;
      final expected = -1009;
      final actual = getterssettersoperatorsshowcase + n;
      expect(actual, expected);
    });
  });

  group('operator []', () {
    test('operator [](0) returns 10', () {
      final index = 0;
      final expected = 10;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](1) returns 20', () {
      final index = 1;
      final expected = 20;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](-1) returns 10', () {
      final index = -1;
      final expected = 10;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](2) returns 30', () {
      final index = 2;
      final expected = 30;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](-2) returns 10', () {
      final index = -2;
      final expected = 10;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](10) returns 30', () {
      final index = 10;
      final expected = 30;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
    test('operator [](-10) returns 10', () {
      final index = -10;
      final expected = 10;
      final actual = getterssettersoperatorsshowcase[index];
      expect(actual, expected);
    });
  });

  group('operator []=', () {
    test('operator []=(0, -501) throws ArgumentError', () {
      final index = 0;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(1, -501) throws ArgumentError', () {
      final index = 1;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(-1, -501) throws ArgumentError', () {
      final index = -1;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(2, -501) throws ArgumentError', () {
      final index = 2;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(-2, -501) throws ArgumentError', () {
      final index = -2;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(10, -501) throws ArgumentError', () {
      final index = 10;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(-10, -501) throws ArgumentError', () {
      final index = -10;
      final value = -501;
      expect(() => getterssettersoperatorsshowcase[index] = value, throwsA(isA<ArgumentError>()));
    });
    test('operator []=(0, 0) runs without error', () {
      final index = 0;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, 1) runs without error', () {
      final index = 0;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, -1) runs without error', () {
      final index = 0;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, 2) runs without error', () {
      final index = 0;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, -2) runs without error', () {
      final index = 0;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, 10) runs without error', () {
      final index = 0;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, -10) runs without error', () {
      final index = 0;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, -500) runs without error', () {
      final index = 0;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(0, -499) runs without error', () {
      final index = 0;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, 0) runs without error', () {
      final index = 1;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, 1) runs without error', () {
      final index = 1;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, -1) runs without error', () {
      final index = 1;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, 2) runs without error', () {
      final index = 1;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, -2) runs without error', () {
      final index = 1;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, 10) runs without error', () {
      final index = 1;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, -10) runs without error', () {
      final index = 1;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, -500) runs without error', () {
      final index = 1;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(1, -499) runs without error', () {
      final index = 1;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, 0) runs without error', () {
      final index = -1;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, 1) runs without error', () {
      final index = -1;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, -1) runs without error', () {
      final index = -1;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, 2) runs without error', () {
      final index = -1;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, -2) runs without error', () {
      final index = -1;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, 10) runs without error', () {
      final index = -1;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, -10) runs without error', () {
      final index = -1;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, -500) runs without error', () {
      final index = -1;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-1, -499) runs without error', () {
      final index = -1;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, 0) runs without error', () {
      final index = 2;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, 1) runs without error', () {
      final index = 2;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, -1) runs without error', () {
      final index = 2;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, 2) runs without error', () {
      final index = 2;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, -2) runs without error', () {
      final index = 2;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, 10) runs without error', () {
      final index = 2;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, -10) runs without error', () {
      final index = 2;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, -500) runs without error', () {
      final index = 2;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(2, -499) runs without error', () {
      final index = 2;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, 0) runs without error', () {
      final index = -2;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, 1) runs without error', () {
      final index = -2;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, -1) runs without error', () {
      final index = -2;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, 2) runs without error', () {
      final index = -2;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, -2) runs without error', () {
      final index = -2;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, 10) runs without error', () {
      final index = -2;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, -10) runs without error', () {
      final index = -2;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, -500) runs without error', () {
      final index = -2;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-2, -499) runs without error', () {
      final index = -2;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, 0) runs without error', () {
      final index = 10;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, 1) runs without error', () {
      final index = 10;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, -1) runs without error', () {
      final index = 10;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, 2) runs without error', () {
      final index = 10;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, -2) runs without error', () {
      final index = 10;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, 10) runs without error', () {
      final index = 10;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, -10) runs without error', () {
      final index = 10;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, -500) runs without error', () {
      final index = 10;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(10, -499) runs without error', () {
      final index = 10;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, 0) runs without error', () {
      final index = -10;
      final value = 0;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, 1) runs without error', () {
      final index = -10;
      final value = 1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, -1) runs without error', () {
      final index = -10;
      final value = -1;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, 2) runs without error', () {
      final index = -10;
      final value = 2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, -2) runs without error', () {
      final index = -10;
      final value = -2;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, 10) runs without error', () {
      final index = -10;
      final value = 10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, -10) runs without error', () {
      final index = -10;
      final value = -10;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, -500) runs without error', () {
      final index = -10;
      final value = -500;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
    test('operator []=(-10, -499) runs without error', () {
      final index = -10;
      final value = -499;
      expect(() => getterssettersoperatorsshowcase[index] = value, returnsNormally);
    });
  });

  group('operator ~', () {
    test('operator ~ returns 998', () {

      final expected = 998;
      final actual = ~getterssettersoperatorsshowcase;
      expect(actual, expected);
    });
  });

  group('operator -', () {
    test('operator - returns 999', () {

      final expected = 999;
      final actual = -getterssettersoperatorsshowcase;
      expect(actual, expected);
    });
  });

}
