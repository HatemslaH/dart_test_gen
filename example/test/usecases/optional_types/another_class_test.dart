import 'package:test/test.dart';
import 'package:example/usecases/optional_types/another_class.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-11T21:35:02.826027

void main() {
  final anotherclass = AnotherClass('', 0.0);

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = anotherclass == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = anotherclass == other;
      expect(actual, expected);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = AnotherClass('', 0.0);
      final right = AnotherClass('', 0.0);
      expect(left.hashCode, right.hashCode);
    });
  });

}
