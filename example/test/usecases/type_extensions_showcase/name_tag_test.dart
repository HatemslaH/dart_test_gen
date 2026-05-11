import 'package:test/test.dart';
import 'package:example/usecases/type_extensions_showcase/name_tag.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-11T21:35:02.715045

void main() {
  final nametag = NameTag('');

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = nametag == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = nametag == other;
      expect(actual, expected);
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
