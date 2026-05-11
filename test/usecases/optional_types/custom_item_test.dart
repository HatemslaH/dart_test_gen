import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/optional_types/custom_item.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T16:52:44.510386

void main() {
  final customitem = CustomItem(id: 0, name: '');

  group('toString', () {
    test('toString', () {

      final expected = 'CustomItem(id: 0, name: )';
      final actual = customitem.toString();
      expect(actual, expected);
    });
  });

  group('operator ==', () {
    test('operator ==(0)', () {
      final other = 0;
      final expected = false;
      final actual = customitem == other;
      expect(actual, expected);
    });
    test('operator ==(\'str\')', () {
      final other = 'str';
      final expected = false;
      final actual = customitem == other;
      expect(actual, expected);
    });
  });

  group('getter hashCode', () {
    test('getter hashCode', () {
      final left = CustomItem(id: 0, name: '');
      final right = CustomItem(id: 0, name: '');
      expect(left.hashCode, right.hashCode);
    });
  });

}
