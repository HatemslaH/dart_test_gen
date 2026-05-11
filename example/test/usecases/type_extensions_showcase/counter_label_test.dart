import 'package:test/test.dart';
import 'package:example/usecases/type_extensions_showcase/counter_label.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-11T21:35:02.780103

void main() {
  final counterlabel = CounterLabel(0, '');

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = counterlabel == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = counterlabel == other;
      expect(actual, expected);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = CounterLabel(0, '');
      final right = CounterLabel(0, '');
      expect(left.hashCode, right.hashCode);
    });
  });

}
