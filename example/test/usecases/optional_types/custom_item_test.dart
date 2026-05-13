import 'package:test/test.dart';
import 'package:example/usecases/optional_types/custom_item.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:57:10.784148

void main() {
  final customitem = CustomItem(id: 0, name: '');

  group('toString', () {
    test('toString returns \'CustomItem(id: 0, name: )\'', () {

      final expected = 'CustomItem(id: 0, name: )';
      final actual = customitem.toString();
      expect(actual, expected);
    });
  });

  group('operator ==', () {
    test('operator ==(0) returns false', () {
      final other = 0;
      final actual = customitem == other;
      expect(actual, isFalse);
    });
    test('operator ==(\'str\') returns false', () {
      final other = 'str';
      final actual = customitem == other;
      expect(actual, isFalse);
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
