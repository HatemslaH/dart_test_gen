import 'package:test/test.dart';
import 'package:example/usecases/async_showcase/task_result.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:13:25.833562

void main() {
  final taskresult = TaskResult('', 0);

  group('operator ==', () {
    test('operator ==(0) returns false', () {
      final other = 0;
      final actual = taskresult == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\') returns false', () {
      final other = 'str';
      final actual = taskresult == other;
      expect(actual, isFalse);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = TaskResult('', 0);
      final right = TaskResult('', 0);
      expect(left.hashCode, right.hashCode);
    });
  });

}
