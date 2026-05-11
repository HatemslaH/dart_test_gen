import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/data_toolbox/rgb_color.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T17:24:41.426965

void main() {
  final rgbcolor = RgbColor(0, 0, 0);

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = rgbcolor == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = rgbcolor == other;
      expect(actual, expected);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = RgbColor(0, 0, 0);
      final right = RgbColor(0, 0, 0);
      expect(left.hashCode, right.hashCode);
    });
  });

}
