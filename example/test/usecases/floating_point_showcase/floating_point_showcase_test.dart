import 'package:test/test.dart';
import 'package:example/usecases/floating_point_showcase/floating_point_showcase.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:57:11.003253

void main() {
  final floatingpointshowcase = FloatingPointShowcase();

  group('sumTenths', () {
    test('sumTenths(0) returns 0.0', () {
      final iterations = 0;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(1) returns 0.1', () {
      final iterations = 1;
      final expected = 0.1;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(-1) returns 0.0', () {
      final iterations = -1;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(2) returns 0.2', () {
      final iterations = 2;
      final expected = 0.2;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(-2) returns 0.0', () {
      final iterations = -2;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(10) returns 0.9999999999999999', () {
      final iterations = 10;
      final expected = 0.9999999999999999;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
    test('sumTenths(-10) returns 0.0', () {
      final iterations = -10;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, expected);
    });
  });

  group('slideToward', () {
    test('slideToward(0.0, 0.0, 0.0) returns 0.0', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.0, 1.0) returns 0.0', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.0, -1.0) returns 0.0', () {
      final from = 0.0;
      final toward = 0.0;
      final t = -1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.0, 0.5) returns 0.0', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.0, -0.5) returns 0.0', () {
      final from = 0.0;
      final toward = 0.0;
      final t = -0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 1.0, 0.0) returns 0.0', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 1.0, 1.0) returns 1.0', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 1.0, -1.0) returns -1.0', () {
      final from = 0.0;
      final toward = 1.0;
      final t = -1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 1.0, 0.5) returns 0.5', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 1.0, -0.5) returns -0.5', () {
      final from = 0.0;
      final toward = 1.0;
      final t = -0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -1.0, 0.0) returns 0.0', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -1.0, 1.0) returns -1.0', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -1.0, -1.0) returns 1.0', () {
      final from = 0.0;
      final toward = -1.0;
      final t = -1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -1.0, 0.5) returns -0.5', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -1.0, -0.5) returns 0.5', () {
      final from = 0.0;
      final toward = -1.0;
      final t = -0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.5, 0.0) returns 0.0', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.5, 1.0) returns 0.5', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.5, -1.0) returns -0.5', () {
      final from = 0.0;
      final toward = 0.5;
      final t = -1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.5, 0.5) returns 0.25', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, 0.5, -0.5) returns -0.25', () {
      final from = 0.0;
      final toward = 0.5;
      final t = -0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -0.5, 0.0) returns 0.0', () {
      final from = 0.0;
      final toward = -0.5;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -0.5, 1.0) returns -0.5', () {
      final from = 0.0;
      final toward = -0.5;
      final t = 1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -0.5, -1.0) returns 0.5', () {
      final from = 0.0;
      final toward = -0.5;
      final t = -1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -0.5, 0.5) returns -0.25', () {
      final from = 0.0;
      final toward = -0.5;
      final t = 0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.0, -0.5, -0.5) returns 0.25', () {
      final from = 0.0;
      final toward = -0.5;
      final t = -0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.0, 0.0) returns 1.0', () {
      final from = 1.0;
      final toward = 0.0;
      final t = 0.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.0, 1.0) returns 0.0', () {
      final from = 1.0;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.0, -1.0) returns 2.0', () {
      final from = 1.0;
      final toward = 0.0;
      final t = -1.0;
      final expected = 2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.0, 0.5) returns 0.5', () {
      final from = 1.0;
      final toward = 0.0;
      final t = 0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.0, -0.5) returns 1.5', () {
      final from = 1.0;
      final toward = 0.0;
      final t = -0.5;
      final expected = 1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 1.0, 0.0) returns 1.0', () {
      final from = 1.0;
      final toward = 1.0;
      final t = 0.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 1.0, 1.0) returns 1.0', () {
      final from = 1.0;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 1.0, -1.0) returns 1.0', () {
      final from = 1.0;
      final toward = 1.0;
      final t = -1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 1.0, 0.5) returns 1.0', () {
      final from = 1.0;
      final toward = 1.0;
      final t = 0.5;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 1.0, -0.5) returns 1.0', () {
      final from = 1.0;
      final toward = 1.0;
      final t = -0.5;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -1.0, 0.0) returns 1.0', () {
      final from = 1.0;
      final toward = -1.0;
      final t = 0.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -1.0, 1.0) returns -1.0', () {
      final from = 1.0;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -1.0, -1.0) returns 3.0', () {
      final from = 1.0;
      final toward = -1.0;
      final t = -1.0;
      final expected = 3.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -1.0, 0.5) returns 0.0', () {
      final from = 1.0;
      final toward = -1.0;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -1.0, -0.5) returns 2.0', () {
      final from = 1.0;
      final toward = -1.0;
      final t = -0.5;
      final expected = 2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.5, 0.0) returns 1.0', () {
      final from = 1.0;
      final toward = 0.5;
      final t = 0.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.5, 1.0) returns 0.5', () {
      final from = 1.0;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.5, -1.0) returns 1.5', () {
      final from = 1.0;
      final toward = 0.5;
      final t = -1.0;
      final expected = 1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.5, 0.5) returns 0.75', () {
      final from = 1.0;
      final toward = 0.5;
      final t = 0.5;
      final expected = 0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, 0.5, -0.5) returns 1.25', () {
      final from = 1.0;
      final toward = 0.5;
      final t = -0.5;
      final expected = 1.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -0.5, 0.0) returns 1.0', () {
      final from = 1.0;
      final toward = -0.5;
      final t = 0.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -0.5, 1.0) returns -0.5', () {
      final from = 1.0;
      final toward = -0.5;
      final t = 1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -0.5, -1.0) returns 2.5', () {
      final from = 1.0;
      final toward = -0.5;
      final t = -1.0;
      final expected = 2.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -0.5, 0.5) returns 0.25', () {
      final from = 1.0;
      final toward = -0.5;
      final t = 0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(1.0, -0.5, -0.5) returns 1.75', () {
      final from = 1.0;
      final toward = -0.5;
      final t = -0.5;
      final expected = 1.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.0, 0.0) returns -1.0', () {
      final from = -1.0;
      final toward = 0.0;
      final t = 0.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.0, 1.0) returns 0.0', () {
      final from = -1.0;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.0, -1.0) returns -2.0', () {
      final from = -1.0;
      final toward = 0.0;
      final t = -1.0;
      final expected = -2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.0, 0.5) returns -0.5', () {
      final from = -1.0;
      final toward = 0.0;
      final t = 0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.0, -0.5) returns -1.5', () {
      final from = -1.0;
      final toward = 0.0;
      final t = -0.5;
      final expected = -1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 1.0, 0.0) returns -1.0', () {
      final from = -1.0;
      final toward = 1.0;
      final t = 0.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 1.0, 1.0) returns 1.0', () {
      final from = -1.0;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 1.0, -1.0) returns -3.0', () {
      final from = -1.0;
      final toward = 1.0;
      final t = -1.0;
      final expected = -3.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 1.0, 0.5) returns 0.0', () {
      final from = -1.0;
      final toward = 1.0;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 1.0, -0.5) returns -2.0', () {
      final from = -1.0;
      final toward = 1.0;
      final t = -0.5;
      final expected = -2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -1.0, 0.0) returns -1.0', () {
      final from = -1.0;
      final toward = -1.0;
      final t = 0.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -1.0, 1.0) returns -1.0', () {
      final from = -1.0;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -1.0, -1.0) returns -1.0', () {
      final from = -1.0;
      final toward = -1.0;
      final t = -1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -1.0, 0.5) returns -1.0', () {
      final from = -1.0;
      final toward = -1.0;
      final t = 0.5;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -1.0, -0.5) returns -1.0', () {
      final from = -1.0;
      final toward = -1.0;
      final t = -0.5;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.5, 0.0) returns -1.0', () {
      final from = -1.0;
      final toward = 0.5;
      final t = 0.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.5, 1.0) returns 0.5', () {
      final from = -1.0;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.5, -1.0) returns -2.5', () {
      final from = -1.0;
      final toward = 0.5;
      final t = -1.0;
      final expected = -2.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.5, 0.5) returns -0.25', () {
      final from = -1.0;
      final toward = 0.5;
      final t = 0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, 0.5, -0.5) returns -1.75', () {
      final from = -1.0;
      final toward = 0.5;
      final t = -0.5;
      final expected = -1.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -0.5, 0.0) returns -1.0', () {
      final from = -1.0;
      final toward = -0.5;
      final t = 0.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -0.5, 1.0) returns -0.5', () {
      final from = -1.0;
      final toward = -0.5;
      final t = 1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -0.5, -1.0) returns -1.5', () {
      final from = -1.0;
      final toward = -0.5;
      final t = -1.0;
      final expected = -1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -0.5, 0.5) returns -0.75', () {
      final from = -1.0;
      final toward = -0.5;
      final t = 0.5;
      final expected = -0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-1.0, -0.5, -0.5) returns -1.25', () {
      final from = -1.0;
      final toward = -0.5;
      final t = -0.5;
      final expected = -1.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.0, 0.0) returns 0.5', () {
      final from = 0.5;
      final toward = 0.0;
      final t = 0.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.0, 1.0) returns 0.0', () {
      final from = 0.5;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.0, -1.0) returns 1.0', () {
      final from = 0.5;
      final toward = 0.0;
      final t = -1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.0, 0.5) returns 0.25', () {
      final from = 0.5;
      final toward = 0.0;
      final t = 0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.0, -0.5) returns 0.75', () {
      final from = 0.5;
      final toward = 0.0;
      final t = -0.5;
      final expected = 0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 1.0, 0.0) returns 0.5', () {
      final from = 0.5;
      final toward = 1.0;
      final t = 0.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 1.0, 1.0) returns 1.0', () {
      final from = 0.5;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 1.0, -1.0) returns 0.0', () {
      final from = 0.5;
      final toward = 1.0;
      final t = -1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 1.0, 0.5) returns 0.75', () {
      final from = 0.5;
      final toward = 1.0;
      final t = 0.5;
      final expected = 0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 1.0, -0.5) returns 0.25', () {
      final from = 0.5;
      final toward = 1.0;
      final t = -0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -1.0, 0.0) returns 0.5', () {
      final from = 0.5;
      final toward = -1.0;
      final t = 0.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -1.0, 1.0) returns -1.0', () {
      final from = 0.5;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -1.0, -1.0) returns 2.0', () {
      final from = 0.5;
      final toward = -1.0;
      final t = -1.0;
      final expected = 2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -1.0, 0.5) returns -0.25', () {
      final from = 0.5;
      final toward = -1.0;
      final t = 0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -1.0, -0.5) returns 1.25', () {
      final from = 0.5;
      final toward = -1.0;
      final t = -0.5;
      final expected = 1.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.5, 0.0) returns 0.5', () {
      final from = 0.5;
      final toward = 0.5;
      final t = 0.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.5, 1.0) returns 0.5', () {
      final from = 0.5;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.5, -1.0) returns 0.5', () {
      final from = 0.5;
      final toward = 0.5;
      final t = -1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.5, 0.5) returns 0.5', () {
      final from = 0.5;
      final toward = 0.5;
      final t = 0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, 0.5, -0.5) returns 0.5', () {
      final from = 0.5;
      final toward = 0.5;
      final t = -0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -0.5, 0.0) returns 0.5', () {
      final from = 0.5;
      final toward = -0.5;
      final t = 0.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -0.5, 1.0) returns -0.5', () {
      final from = 0.5;
      final toward = -0.5;
      final t = 1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -0.5, -1.0) returns 1.5', () {
      final from = 0.5;
      final toward = -0.5;
      final t = -1.0;
      final expected = 1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -0.5, 0.5) returns 0.0', () {
      final from = 0.5;
      final toward = -0.5;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(0.5, -0.5, -0.5) returns 1.0', () {
      final from = 0.5;
      final toward = -0.5;
      final t = -0.5;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.0, 0.0) returns -0.5', () {
      final from = -0.5;
      final toward = 0.0;
      final t = 0.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.0, 1.0) returns 0.0', () {
      final from = -0.5;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.0, -1.0) returns -1.0', () {
      final from = -0.5;
      final toward = 0.0;
      final t = -1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.0, 0.5) returns -0.25', () {
      final from = -0.5;
      final toward = 0.0;
      final t = 0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.0, -0.5) returns -0.75', () {
      final from = -0.5;
      final toward = 0.0;
      final t = -0.5;
      final expected = -0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 1.0, 0.0) returns -0.5', () {
      final from = -0.5;
      final toward = 1.0;
      final t = 0.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 1.0, 1.0) returns 1.0', () {
      final from = -0.5;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 1.0, -1.0) returns -2.0', () {
      final from = -0.5;
      final toward = 1.0;
      final t = -1.0;
      final expected = -2.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 1.0, 0.5) returns 0.25', () {
      final from = -0.5;
      final toward = 1.0;
      final t = 0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 1.0, -0.5) returns -1.25', () {
      final from = -0.5;
      final toward = 1.0;
      final t = -0.5;
      final expected = -1.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -1.0, 0.0) returns -0.5', () {
      final from = -0.5;
      final toward = -1.0;
      final t = 0.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -1.0, 1.0) returns -1.0', () {
      final from = -0.5;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -1.0, -1.0) returns 0.0', () {
      final from = -0.5;
      final toward = -1.0;
      final t = -1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -1.0, 0.5) returns -0.75', () {
      final from = -0.5;
      final toward = -1.0;
      final t = 0.5;
      final expected = -0.75;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -1.0, -0.5) returns -0.25', () {
      final from = -0.5;
      final toward = -1.0;
      final t = -0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.5, 0.0) returns -0.5', () {
      final from = -0.5;
      final toward = 0.5;
      final t = 0.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.5, 1.0) returns 0.5', () {
      final from = -0.5;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.5, -1.0) returns -1.5', () {
      final from = -0.5;
      final toward = 0.5;
      final t = -1.0;
      final expected = -1.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.5, 0.5) returns 0.0', () {
      final from = -0.5;
      final toward = 0.5;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, 0.5, -0.5) returns -1.0', () {
      final from = -0.5;
      final toward = 0.5;
      final t = -0.5;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -0.5, 0.0) returns -0.5', () {
      final from = -0.5;
      final toward = -0.5;
      final t = 0.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -0.5, 1.0) returns -0.5', () {
      final from = -0.5;
      final toward = -0.5;
      final t = 1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -0.5, -1.0) returns -0.5', () {
      final from = -0.5;
      final toward = -0.5;
      final t = -1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -0.5, 0.5) returns -0.5', () {
      final from = -0.5;
      final toward = -0.5;
      final t = 0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
    test('slideToward(-0.5, -0.5, -0.5) returns -0.5', () {
      final from = -0.5;
      final toward = -0.5;
      final t = -0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, expected);
    });
  });

  group('asyncSum', () {
    test('asyncSum(0.0, 0.0) returns 0.0', () async {
      final x = 0.0;
      final y = 0.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.0, 1.0) returns 1.0', () async {
      final x = 0.0;
      final y = 1.0;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.0, -1.0) returns -1.0', () async {
      final x = 0.0;
      final y = -1.0;
      final expected = -1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.0, 0.5) returns 0.5', () async {
      final x = 0.0;
      final y = 0.5;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.0, -0.5) returns -0.5', () async {
      final x = 0.0;
      final y = -0.5;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(1.0, 0.0) returns 1.0', () async {
      final x = 1.0;
      final y = 0.0;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(1.0, 1.0) returns 2.0', () async {
      final x = 1.0;
      final y = 1.0;
      final expected = 2.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(1.0, -1.0) returns 0.0', () async {
      final x = 1.0;
      final y = -1.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(1.0, 0.5) returns 1.5', () async {
      final x = 1.0;
      final y = 0.5;
      final expected = 1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(1.0, -0.5) returns 0.5', () async {
      final x = 1.0;
      final y = -0.5;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-1.0, 0.0) returns -1.0', () async {
      final x = -1.0;
      final y = 0.0;
      final expected = -1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-1.0, 1.0) returns 0.0', () async {
      final x = -1.0;
      final y = 1.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-1.0, -1.0) returns -2.0', () async {
      final x = -1.0;
      final y = -1.0;
      final expected = -2.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-1.0, 0.5) returns -0.5', () async {
      final x = -1.0;
      final y = 0.5;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-1.0, -0.5) returns -1.5', () async {
      final x = -1.0;
      final y = -0.5;
      final expected = -1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.5, 0.0) returns 0.5', () async {
      final x = 0.5;
      final y = 0.0;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.5, 1.0) returns 1.5', () async {
      final x = 0.5;
      final y = 1.0;
      final expected = 1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.5, -1.0) returns -0.5', () async {
      final x = 0.5;
      final y = -1.0;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.5, 0.5) returns 1.0', () async {
      final x = 0.5;
      final y = 0.5;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(0.5, -0.5) returns 0.0', () async {
      final x = 0.5;
      final y = -0.5;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-0.5, 0.0) returns -0.5', () async {
      final x = -0.5;
      final y = 0.0;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-0.5, 1.0) returns 0.5', () async {
      final x = -0.5;
      final y = 1.0;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-0.5, -1.0) returns -1.5', () async {
      final x = -0.5;
      final y = -1.0;
      final expected = -1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-0.5, 0.5) returns 0.0', () async {
      final x = -0.5;
      final y = 0.5;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
    test('asyncSum(-0.5, -0.5) returns -1.0', () async {
      final x = -0.5;
      final y = -0.5;
      final expected = -1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, expected);
    });
  });

}
