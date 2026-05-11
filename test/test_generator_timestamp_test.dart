import 'package:test/test.dart';
import 'package:dart_test_gen/test_generator.dart';

void main() {
  group('stripGeneratedTimestamp', () {
    test('strips the // Generated: line', () {
      const input = '// Auto-generated\n// Generated: 2026-05-11T18:00:00.000\nvoid main() {}\n';
      expect(stripGeneratedTimestamp(input), '// Auto-generated\nvoid main() {}\n');
    });

    test('strips the legacy // Сгенерировано: line', () {
      const input = '// Auto-generated\n// Сгенерировано: 2026-01-01T00:00:00.000\nvoid main() {}\n';
      expect(stripGeneratedTimestamp(input), '// Auto-generated\nvoid main() {}\n');
    });

    test('is a no-op when no timestamp line is present', () {
      const input = '// Auto-generated\nvoid main() {}\n';
      expect(stripGeneratedTimestamp(input), input);
    });

    test('is idempotent', () {
      const input = '// Auto-generated\n// Generated: 2026-05-11T18:00:00.000\nvoid main() {}\n';
      final once = stripGeneratedTimestamp(input);
      expect(stripGeneratedTimestamp(once), once);
    });

    test('only removes the timestamp line, preserves all others', () {
      const input = 'import \'package:test/test.dart\';\n'
          '\n'
          '// Auto-generated — do not edit manually\n'
          '// Generated: 2026-05-11T12:00:00.000000\n'
          '\n'
          'void main() {}\n';
      const expected = 'import \'package:test/test.dart\';\n'
          '\n'
          '// Auto-generated — do not edit manually\n'
          '\n'
          'void main() {}\n';
      expect(stripGeneratedTimestamp(input), expected);
    });
  });
}
