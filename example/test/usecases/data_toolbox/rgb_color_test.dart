import 'package:test/test.dart';
import 'package:example/usecases/data_toolbox/rgb_color.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-11T21:35:02.812710

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
