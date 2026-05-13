import 'package:test/test.dart';
import 'package:example/usecases/optional_types/another_class.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T16:44:45.139131

void main() {
  final anotherclass = AnotherClass('', 0.0);

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final actual = anotherclass == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final actual = anotherclass == other;
      expect(actual, isFalse);
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
