import 'package:test/test.dart';
import 'package:example/usecases/type_extensions_showcase/name_tag.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T16:44:45.057045

void main() {
  final nametag = NameTag('');

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final actual = nametag == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final actual = nametag == other;
      expect(actual, isFalse);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = NameTag('');
      final right = NameTag('');
      expect(left.hashCode, right.hashCode);
    });
  });

}
