import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/optional_types/custom_item.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T14:04:23.695086

void main() {
  final customitem = CustomItem(id: 0, name: '');

  group('toString', () {
    test('toString()', () {

      final expected = 'CustomItem(id: 0, name: )';
      final actual = customitem.toString();
      expect(actual, expected);
    });
  });

}
