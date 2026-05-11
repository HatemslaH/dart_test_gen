import 'package:test/test.dart';
import 'package:example/usecases/async_showcase/task_result.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T20:31:51.891239

void main() {
  final taskresult = TaskResult('', 0);

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = taskresult == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = taskresult == other;
      expect(actual, expected);
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
