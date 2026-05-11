import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/floating_point_showcase/floating_point_showcase.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T19:15:32.680742

void main() {
  final floatingpointshowcase = FloatingPointShowcase();

  group('sumTenths', () {
    test('sumTenths(0)', () {
      final iterations = 0;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(1)', () {
      final iterations = 1;
      final expected = 0.1;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(-1)', () {
      final iterations = -1;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(2)', () {
      final iterations = 2;
      final expected = 0.2;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(-2)', () {
      final iterations = -2;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(10)', () {
      final iterations = 10;
      final expected = 0.9999999999999999;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('sumTenths(-10)', () {
      final iterations = -10;
      final expected = 0.0;
      final actual = floatingpointshowcase.sumTenths(iterations);
      expect(actual, closeTo(expected, 1e-7));
    });
  });

  group('slideToward', () {
    test('slideToward(0.0, 0.0, 0.0)', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.0, 1.0)', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.0, -1.0)', () {
      final from = 0.0;
      final toward = 0.0;
      final t = -1.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.0, 0.5)', () {
      final from = 0.0;
      final toward = 0.0;
      final t = 0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.0, -0.5)', () {
      final from = 0.0;
      final toward = 0.0;
      final t = -0.5;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 1.0, 0.0)', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 1.0, 1.0)', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 1.0, -1.0)', () {
      final from = 0.0;
      final toward = 1.0;
      final t = -1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 1.0, 0.5)', () {
      final from = 0.0;
      final toward = 1.0;
      final t = 0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 1.0, -0.5)', () {
      final from = 0.0;
      final toward = 1.0;
      final t = -0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, -1.0, 0.0)', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, -1.0, 1.0)', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 1.0;
      final expected = -1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, -1.0, -1.0)', () {
      final from = 0.0;
      final toward = -1.0;
      final t = -1.0;
      final expected = 1.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, -1.0, 0.5)', () {
      final from = 0.0;
      final toward = -1.0;
      final t = 0.5;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, -1.0, -0.5)', () {
      final from = 0.0;
      final toward = -1.0;
      final t = -0.5;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.5, 0.0)', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 0.0;
      final expected = 0.0;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.5, 1.0)', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 1.0;
      final expected = 0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.5, -1.0)', () {
      final from = 0.0;
      final toward = 0.5;
      final t = -1.0;
      final expected = -0.5;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.5, 0.5)', () {
      final from = 0.0;
      final toward = 0.5;
      final t = 0.5;
      final expected = 0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('slideToward(0.0, 0.5, -0.5)', () {
      final from = 0.0;
      final toward = 0.5;
      final t = -0.5;
      final expected = -0.25;
      final actual = floatingpointshowcase.slideToward(from, toward, t);
      expect(actual, closeTo(expected, 1e-7));
    });
  });

  group('asyncSum', () {
    test('asyncSum(0.0, 0.0)', () async {
      final x = 0.0;
      final y = 0.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.0, 1.0)', () async {
      final x = 0.0;
      final y = 1.0;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.0, -1.0)', () async {
      final x = 0.0;
      final y = -1.0;
      final expected = -1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.0, 0.5)', () async {
      final x = 0.0;
      final y = 0.5;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.0, -0.5)', () async {
      final x = 0.0;
      final y = -0.5;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(1.0, 0.0)', () async {
      final x = 1.0;
      final y = 0.0;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(1.0, 1.0)', () async {
      final x = 1.0;
      final y = 1.0;
      final expected = 2.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(1.0, -1.0)', () async {
      final x = 1.0;
      final y = -1.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(1.0, 0.5)', () async {
      final x = 1.0;
      final y = 0.5;
      final expected = 1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(1.0, -0.5)', () async {
      final x = 1.0;
      final y = -0.5;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(-1.0, 0.0)', () async {
      final x = -1.0;
      final y = 0.0;
      final expected = -1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(-1.0, 1.0)', () async {
      final x = -1.0;
      final y = 1.0;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(-1.0, -1.0)', () async {
      final x = -1.0;
      final y = -1.0;
      final expected = -2.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(-1.0, 0.5)', () async {
      final x = -1.0;
      final y = 0.5;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(-1.0, -0.5)', () async {
      final x = -1.0;
      final y = -0.5;
      final expected = -1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.5, 0.0)', () async {
      final x = 0.5;
      final y = 0.0;
      final expected = 0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.5, 1.0)', () async {
      final x = 0.5;
      final y = 1.0;
      final expected = 1.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.5, -1.0)', () async {
      final x = 0.5;
      final y = -1.0;
      final expected = -0.5;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.5, 0.5)', () async {
      final x = 0.5;
      final y = 0.5;
      final expected = 1.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
    test('asyncSum(0.5, -0.5)', () async {
      final x = 0.5;
      final y = -0.5;
      final expected = 0.0;
      final actual = await floatingpointshowcase.asyncSum(x, y);
      expect(actual, closeTo(expected, 1e-7));
    });
  });

}
