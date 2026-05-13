import 'package:test/test.dart';
import 'package:example/usecases/data_toolbox/rgb_color.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T16:44:45.165499

void main() {
  final rgbcolor = RgbColor(0, 0, 0);

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final actual = rgbcolor == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final actual = rgbcolor == other;
      expect(actual, isFalse);
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
