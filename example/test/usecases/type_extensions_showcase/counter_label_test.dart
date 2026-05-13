import 'package:test/test.dart';
import 'package:example/usecases/type_extensions_showcase/counter_label.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:57:10.761470

void main() {
  final counterlabel = CounterLabel(0, '');

  group('operator ==', () {
    test('operator ==(0) returns false', () {
      final other = 0;
      final actual = counterlabel == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\') returns false', () {
      final other = 'str';
      final actual = counterlabel == other;
      expect(actual, isFalse);
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
