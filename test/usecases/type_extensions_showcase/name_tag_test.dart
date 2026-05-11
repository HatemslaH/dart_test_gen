import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/type_extensions_showcase/name_tag.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T16:52:44.502870

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
