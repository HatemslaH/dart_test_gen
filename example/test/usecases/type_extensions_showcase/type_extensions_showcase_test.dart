import 'package:test/test.dart';
import 'package:example/usecases/type_extensions_showcase/type_extensions_showcase.dart';
import 'package:example/usecases/type_extensions_showcase/counter_label.dart';
import 'package:example/usecases/type_extensions_showcase/name_tag.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:13:26.131613

void main() {
  final typeextensionsshowcase = TypeExtensionsShowcase();

  group('baseline', () {
    test('baseline(0, 0) returns 0', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 1) returns 1', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -1) returns -1', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 2) returns 2', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -2) returns -2', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 10) returns 10', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -10) returns -10', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 0) returns 1', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 1) returns 2', () {
      final a = 1;
      final b = 1;
      final expected = 2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -1) returns 0', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 2) returns 3', () {
      final a = 1;
      final b = 2;
      final expected = 3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -2) returns -1', () {
      final a = 1;
      final b = -2;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 10) returns 11', () {
      final a = 1;
      final b = 10;
      final expected = 11;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -10) returns -9', () {
      final a = 1;
      final b = -10;
      final expected = -9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 0) returns -1', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 1) returns 0', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, -1) returns -2', () {
      final a = -1;
      final b = -1;
      final expected = -2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 2) returns 1', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, -2) returns -3', () {
      final a = -1;
      final b = -2;
      final expected = -3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 10) returns 9', () {
      final a = -1;
      final b = 10;
      final expected = 9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, -10) returns -11', () {
      final a = -1;
      final b = -10;
      final expected = -11;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, 0) returns 2', () {
      final a = 2;
      final b = 0;
      final expected = 2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, 1) returns 3', () {
      final a = 2;
      final b = 1;
      final expected = 3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, -1) returns 1', () {
      final a = 2;
      final b = -1;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, 2) returns 4', () {
      final a = 2;
      final b = 2;
      final expected = 4;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, -2) returns 0', () {
      final a = 2;
      final b = -2;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, 10) returns 12', () {
      final a = 2;
      final b = 10;
      final expected = 12;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(2, -10) returns -8', () {
      final a = 2;
      final b = -10;
      final expected = -8;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, 0) returns -2', () {
      final a = -2;
      final b = 0;
      final expected = -2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, 1) returns -1', () {
      final a = -2;
      final b = 1;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, -1) returns -3', () {
      final a = -2;
      final b = -1;
      final expected = -3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, 2) returns 0', () {
      final a = -2;
      final b = 2;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, -2) returns -4', () {
      final a = -2;
      final b = -2;
      final expected = -4;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, 10) returns 8', () {
      final a = -2;
      final b = 10;
      final expected = 8;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-2, -10) returns -12', () {
      final a = -2;
      final b = -10;
      final expected = -12;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, 0) returns 10', () {
      final a = 10;
      final b = 0;
      final expected = 10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, 1) returns 11', () {
      final a = 10;
      final b = 1;
      final expected = 11;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, -1) returns 9', () {
      final a = 10;
      final b = -1;
      final expected = 9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, 2) returns 12', () {
      final a = 10;
      final b = 2;
      final expected = 12;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, -2) returns 8', () {
      final a = 10;
      final b = -2;
      final expected = 8;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, 10) returns 20', () {
      final a = 10;
      final b = 10;
      final expected = 20;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(10, -10) returns 0', () {
      final a = 10;
      final b = -10;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, 0) returns -10', () {
      final a = -10;
      final b = 0;
      final expected = -10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, 1) returns -9', () {
      final a = -10;
      final b = 1;
      final expected = -9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, -1) returns -11', () {
      final a = -10;
      final b = -1;
      final expected = -11;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, 2) returns -8', () {
      final a = -10;
      final b = 2;
      final expected = -8;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, -2) returns -12', () {
      final a = -10;
      final b = -2;
      final expected = -12;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, 10) returns 0', () {
      final a = -10;
      final b = 10;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-10, -10) returns -20', () {
      final a = -10;
      final b = -10;
      final expected = -20;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
  });

  group('heavier', () {
    test('heavier(CounterLabel(0, \'\'), CounterLabel(0, \'\')) returns CounterLabel(0, \'\')', () {
      final x = CounterLabel(0, '');
      final y = CounterLabel(0, '');
      final expected = CounterLabel(0, '');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(0, \'\'), CounterLabel(255, \'test\')) returns CounterLabel(255, \'test\')', () {
      final x = CounterLabel(0, '');
      final y = CounterLabel(255, 'test');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(255, \'test\'), CounterLabel(0, \'\')) returns CounterLabel(255, \'test\')', () {
      final x = CounterLabel(255, 'test');
      final y = CounterLabel(0, '');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(255, \'test\'), CounterLabel(255, \'test\')) returns CounterLabel(255, \'test\')', () {
      final x = CounterLabel(255, 'test');
      final y = CounterLabel(255, 'test');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
  });

  group('longerName', () {
    test('longerName(NameTag(\'\'), NameTag(\'\')) returns NameTag(\'\')', () {
      final a = NameTag('');
      final b = NameTag('');
      final expected = NameTag('');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'\'), NameTag(\'test\')) returns NameTag(\'test\')', () {
      final a = NameTag('');
      final b = NameTag('test');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'test\'), NameTag(\'\')) returns NameTag(\'test\')', () {
      final a = NameTag('test');
      final b = NameTag('');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'test\'), NameTag(\'test\')) returns NameTag(\'test\')', () {
      final a = NameTag('test');
      final b = NameTag('test');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
  });

  group('pairAsIterable', () {
    test('pairAsIterable(0, 0) returns [0, 0]', () {
      final a = 0;
      final b = 0;
      final expected = [0, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 1) returns [0, 1]', () {
      final a = 0;
      final b = 1;
      final expected = [0, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -1) returns [0, -1]', () {
      final a = 0;
      final b = -1;
      final expected = [0, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 2) returns [0, 2]', () {
      final a = 0;
      final b = 2;
      final expected = [0, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -2) returns [0, -2]', () {
      final a = 0;
      final b = -2;
      final expected = [0, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 10) returns [0, 10]', () {
      final a = 0;
      final b = 10;
      final expected = [0, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -10) returns [0, -10]', () {
      final a = 0;
      final b = -10;
      final expected = [0, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 0) returns [1, 0]', () {
      final a = 1;
      final b = 0;
      final expected = [1, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 1) returns [1, 1]', () {
      final a = 1;
      final b = 1;
      final expected = [1, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -1) returns [1, -1]', () {
      final a = 1;
      final b = -1;
      final expected = [1, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 2) returns [1, 2]', () {
      final a = 1;
      final b = 2;
      final expected = [1, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -2) returns [1, -2]', () {
      final a = 1;
      final b = -2;
      final expected = [1, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 10) returns [1, 10]', () {
      final a = 1;
      final b = 10;
      final expected = [1, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -10) returns [1, -10]', () {
      final a = 1;
      final b = -10;
      final expected = [1, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 0) returns [-1, 0]', () {
      final a = -1;
      final b = 0;
      final expected = [-1, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 1) returns [-1, 1]', () {
      final a = -1;
      final b = 1;
      final expected = [-1, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, -1) returns [-1, -1]', () {
      final a = -1;
      final b = -1;
      final expected = [-1, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 2) returns [-1, 2]', () {
      final a = -1;
      final b = 2;
      final expected = [-1, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, -2) returns [-1, -2]', () {
      final a = -1;
      final b = -2;
      final expected = [-1, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 10) returns [-1, 10]', () {
      final a = -1;
      final b = 10;
      final expected = [-1, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, -10) returns [-1, -10]', () {
      final a = -1;
      final b = -10;
      final expected = [-1, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, 0) returns [2, 0]', () {
      final a = 2;
      final b = 0;
      final expected = [2, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, 1) returns [2, 1]', () {
      final a = 2;
      final b = 1;
      final expected = [2, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, -1) returns [2, -1]', () {
      final a = 2;
      final b = -1;
      final expected = [2, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, 2) returns [2, 2]', () {
      final a = 2;
      final b = 2;
      final expected = [2, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, -2) returns [2, -2]', () {
      final a = 2;
      final b = -2;
      final expected = [2, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, 10) returns [2, 10]', () {
      final a = 2;
      final b = 10;
      final expected = [2, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(2, -10) returns [2, -10]', () {
      final a = 2;
      final b = -10;
      final expected = [2, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, 0) returns [-2, 0]', () {
      final a = -2;
      final b = 0;
      final expected = [-2, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, 1) returns [-2, 1]', () {
      final a = -2;
      final b = 1;
      final expected = [-2, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, -1) returns [-2, -1]', () {
      final a = -2;
      final b = -1;
      final expected = [-2, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, 2) returns [-2, 2]', () {
      final a = -2;
      final b = 2;
      final expected = [-2, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, -2) returns [-2, -2]', () {
      final a = -2;
      final b = -2;
      final expected = [-2, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, 10) returns [-2, 10]', () {
      final a = -2;
      final b = 10;
      final expected = [-2, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-2, -10) returns [-2, -10]', () {
      final a = -2;
      final b = -10;
      final expected = [-2, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, 0) returns [10, 0]', () {
      final a = 10;
      final b = 0;
      final expected = [10, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, 1) returns [10, 1]', () {
      final a = 10;
      final b = 1;
      final expected = [10, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, -1) returns [10, -1]', () {
      final a = 10;
      final b = -1;
      final expected = [10, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, 2) returns [10, 2]', () {
      final a = 10;
      final b = 2;
      final expected = [10, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, -2) returns [10, -2]', () {
      final a = 10;
      final b = -2;
      final expected = [10, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, 10) returns [10, 10]', () {
      final a = 10;
      final b = 10;
      final expected = [10, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(10, -10) returns [10, -10]', () {
      final a = 10;
      final b = -10;
      final expected = [10, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, 0) returns [-10, 0]', () {
      final a = -10;
      final b = 0;
      final expected = [-10, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, 1) returns [-10, 1]', () {
      final a = -10;
      final b = 1;
      final expected = [-10, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, -1) returns [-10, -1]', () {
      final a = -10;
      final b = -1;
      final expected = [-10, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, 2) returns [-10, 2]', () {
      final a = -10;
      final b = 2;
      final expected = [-10, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, -2) returns [-10, -2]', () {
      final a = -10;
      final b = -2;
      final expected = [-10, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, 10) returns [-10, 10]', () {
      final a = -10;
      final b = 10;
      final expected = [-10, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-10, -10) returns [-10, -10]', () {
      final a = -10;
      final b = -10;
      final expected = [-10, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
  });

  group('uniquePair', () {
    test('uniquePair(0, 0) returns {0}', () {
      final a = 0;
      final b = 0;
      final expected = {0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 1) returns {0, 1}', () {
      final a = 0;
      final b = 1;
      final expected = {0, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -1) returns {-1, 0}', () {
      final a = 0;
      final b = -1;
      final expected = {-1, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 2) returns {0, 2}', () {
      final a = 0;
      final b = 2;
      final expected = {0, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -2) returns {-2, 0}', () {
      final a = 0;
      final b = -2;
      final expected = {-2, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 10) returns {0, 10}', () {
      final a = 0;
      final b = 10;
      final expected = {0, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -10) returns {-10, 0}', () {
      final a = 0;
      final b = -10;
      final expected = {-10, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 0) returns {0, 1}', () {
      final a = 1;
      final b = 0;
      final expected = {0, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 1) returns {1}', () {
      final a = 1;
      final b = 1;
      final expected = {1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -1) returns {-1, 1}', () {
      final a = 1;
      final b = -1;
      final expected = {-1, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 2) returns {1, 2}', () {
      final a = 1;
      final b = 2;
      final expected = {1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -2) returns {-2, 1}', () {
      final a = 1;
      final b = -2;
      final expected = {-2, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 10) returns {1, 10}', () {
      final a = 1;
      final b = 10;
      final expected = {1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -10) returns {-10, 1}', () {
      final a = 1;
      final b = -10;
      final expected = {-10, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 0) returns {-1, 0}', () {
      final a = -1;
      final b = 0;
      final expected = {-1, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 1) returns {-1, 1}', () {
      final a = -1;
      final b = 1;
      final expected = {-1, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, -1) returns {-1}', () {
      final a = -1;
      final b = -1;
      final expected = {-1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 2) returns {-1, 2}', () {
      final a = -1;
      final b = 2;
      final expected = {-1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, -2) returns {-2, -1}', () {
      final a = -1;
      final b = -2;
      final expected = {-2, -1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 10) returns {-1, 10}', () {
      final a = -1;
      final b = 10;
      final expected = {-1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, -10) returns {-10, -1}', () {
      final a = -1;
      final b = -10;
      final expected = {-10, -1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, 0) returns {0, 2}', () {
      final a = 2;
      final b = 0;
      final expected = {0, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, 1) returns {1, 2}', () {
      final a = 2;
      final b = 1;
      final expected = {1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, -1) returns {-1, 2}', () {
      final a = 2;
      final b = -1;
      final expected = {-1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, 2) returns {2}', () {
      final a = 2;
      final b = 2;
      final expected = {2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, -2) returns {-2, 2}', () {
      final a = 2;
      final b = -2;
      final expected = {-2, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, 10) returns {2, 10}', () {
      final a = 2;
      final b = 10;
      final expected = {2, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(2, -10) returns {-10, 2}', () {
      final a = 2;
      final b = -10;
      final expected = {-10, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, 0) returns {-2, 0}', () {
      final a = -2;
      final b = 0;
      final expected = {-2, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, 1) returns {-2, 1}', () {
      final a = -2;
      final b = 1;
      final expected = {-2, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, -1) returns {-2, -1}', () {
      final a = -2;
      final b = -1;
      final expected = {-2, -1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, 2) returns {-2, 2}', () {
      final a = -2;
      final b = 2;
      final expected = {-2, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, -2) returns {-2}', () {
      final a = -2;
      final b = -2;
      final expected = {-2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, 10) returns {-2, 10}', () {
      final a = -2;
      final b = 10;
      final expected = {-2, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-2, -10) returns {-10, -2}', () {
      final a = -2;
      final b = -10;
      final expected = {-10, -2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, 0) returns {0, 10}', () {
      final a = 10;
      final b = 0;
      final expected = {0, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, 1) returns {1, 10}', () {
      final a = 10;
      final b = 1;
      final expected = {1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, -1) returns {-1, 10}', () {
      final a = 10;
      final b = -1;
      final expected = {-1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, 2) returns {2, 10}', () {
      final a = 10;
      final b = 2;
      final expected = {2, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, -2) returns {-2, 10}', () {
      final a = 10;
      final b = -2;
      final expected = {-2, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, 10) returns {10}', () {
      final a = 10;
      final b = 10;
      final expected = {10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(10, -10) returns {-10, 10}', () {
      final a = 10;
      final b = -10;
      final expected = {-10, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, 0) returns {-10, 0}', () {
      final a = -10;
      final b = 0;
      final expected = {-10, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, 1) returns {-10, 1}', () {
      final a = -10;
      final b = 1;
      final expected = {-10, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, -1) returns {-10, -1}', () {
      final a = -10;
      final b = -1;
      final expected = {-10, -1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, 2) returns {-10, 2}', () {
      final a = -10;
      final b = 2;
      final expected = {-10, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, -2) returns {-10, -2}', () {
      final a = -10;
      final b = -2;
      final expected = {-10, -2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, 10) returns {-10, 10}', () {
      final a = -10;
      final b = 10;
      final expected = {-10, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-10, -10) returns {-10}', () {
      final a = -10;
      final b = -10;
      final expected = {-10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
  });

  group('pairStrings', () {
    test('pairStrings(\'\', \'\') returns [\'\', \'\']', () {
      final x = '';
      final y = '';
      final expected = ['', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'\', \'hello\') returns [\'\', \'hello\']', () {
      final x = '';
      final y = 'hello';
      final expected = ['', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'\', \'  \') returns [\'\', \'  \']', () {
      final x = '';
      final y = '  ';
      final expected = ['', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'\') returns [\'hello\', \'\']', () {
      final x = 'hello';
      final y = '';
      final expected = ['hello', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'hello\') returns [\'hello\', \'hello\']', () {
      final x = 'hello';
      final y = 'hello';
      final expected = ['hello', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'  \') returns [\'hello\', \'  \']', () {
      final x = 'hello';
      final y = '  ';
      final expected = ['hello', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'\') returns [\'  \', \'\']', () {
      final x = '  ';
      final y = '';
      final expected = ['  ', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'hello\') returns [\'  \', \'hello\']', () {
      final x = '  ';
      final y = 'hello';
      final expected = ['  ', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'  \') returns [\'  \', \'  \']', () {
      final x = '  ';
      final y = '  ';
      final expected = ['  ', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTags', () {
    test('pairNameTags(\'\', \'\') returns [NameTag(\'\'), NameTag(\'\')]', () {
      final x = '';
      final y = '';
      final expected = [NameTag(''), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'\', \'hello\') returns [NameTag(\'\'), NameTag(\'hello\')]', () {
      final x = '';
      final y = 'hello';
      final expected = [NameTag(''), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'\', \'  \') returns [NameTag(\'\'), NameTag(\'  \')]', () {
      final x = '';
      final y = '  ';
      final expected = [NameTag(''), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'\') returns [NameTag(\'hello\'), NameTag(\'\')]', () {
      final x = 'hello';
      final y = '';
      final expected = [NameTag('hello'), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'hello\') returns [NameTag(\'hello\'), NameTag(\'hello\')]', () {
      final x = 'hello';
      final y = 'hello';
      final expected = [NameTag('hello'), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'  \') returns [NameTag(\'hello\'), NameTag(\'  \')]', () {
      final x = 'hello';
      final y = '  ';
      final expected = [NameTag('hello'), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'\') returns [NameTag(\'  \'), NameTag(\'\')]', () {
      final x = '  ';
      final y = '';
      final expected = [NameTag('  '), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'hello\') returns [NameTag(\'  \'), NameTag(\'hello\')]', () {
      final x = '  ';
      final y = 'hello';
      final expected = [NameTag('  '), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'  \') returns [NameTag(\'  \'), NameTag(\'  \')]', () {
      final x = '  ';
      final y = '  ';
      final expected = [NameTag('  '), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
  });

  group('uniqueNameTagSet', () {
    test('uniqueNameTagSet(\'\', \'\') returns {NameTag(\'\')}', () {
      final x = '';
      final y = '';
      final expected = {NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'\', \'hello\') returns {NameTag(\'\'), NameTag(\'hello\')}', () {
      final x = '';
      final y = 'hello';
      final expected = {NameTag(''), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'\', \'  \') returns {NameTag(\'  \'), NameTag(\'\')}', () {
      final x = '';
      final y = '  ';
      final expected = {NameTag('  '), NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'\') returns {NameTag(\'\'), NameTag(\'hello\')}', () {
      final x = 'hello';
      final y = '';
      final expected = {NameTag(''), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'hello\') returns {NameTag(\'hello\')}', () {
      final x = 'hello';
      final y = 'hello';
      final expected = {NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'  \') returns {NameTag(\'  \'), NameTag(\'hello\')}', () {
      final x = 'hello';
      final y = '  ';
      final expected = {NameTag('  '), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'\') returns {NameTag(\'  \'), NameTag(\'\')}', () {
      final x = '  ';
      final y = '';
      final expected = {NameTag('  '), NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'hello\') returns {NameTag(\'  \'), NameTag(\'hello\')}', () {
      final x = '  ';
      final y = 'hello';
      final expected = {NameTag('  '), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'  \') returns {NameTag(\'  \')}', () {
      final x = '  ';
      final y = '  ';
      final expected = {NameTag('  ')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTagsIterable', () {
    test('pairNameTagsIterable(\'\', \'\') returns [NameTag(\'\'), NameTag(\'\')]', () {
      final x = '';
      final y = '';
      final expected = [NameTag(''), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'\', \'hello\') returns [NameTag(\'\'), NameTag(\'hello\')]', () {
      final x = '';
      final y = 'hello';
      final expected = [NameTag(''), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'\', \'  \') returns [NameTag(\'\'), NameTag(\'  \')]', () {
      final x = '';
      final y = '  ';
      final expected = [NameTag(''), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'\') returns [NameTag(\'hello\'), NameTag(\'\')]', () {
      final x = 'hello';
      final y = '';
      final expected = [NameTag('hello'), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'hello\') returns [NameTag(\'hello\'), NameTag(\'hello\')]', () {
      final x = 'hello';
      final y = 'hello';
      final expected = [NameTag('hello'), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'  \') returns [NameTag(\'hello\'), NameTag(\'  \')]', () {
      final x = 'hello';
      final y = '  ';
      final expected = [NameTag('hello'), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'\') returns [NameTag(\'  \'), NameTag(\'\')]', () {
      final x = '  ';
      final y = '';
      final expected = [NameTag('  '), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'hello\') returns [NameTag(\'  \'), NameTag(\'hello\')]', () {
      final x = '  ';
      final y = 'hello';
      final expected = [NameTag('  '), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'  \') returns [NameTag(\'  \'), NameTag(\'  \')]', () {
      final x = '  ';
      final y = '  ';
      final expected = [NameTag('  '), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTagMap', () {
    test('pairNameTagMap(\'\', \'\') returns {\'first\': NameTag(\'\'), \'second\': NameTag(\'\')}', () {
      final x = '';
      final y = '';
      final expected = {'first': NameTag(''), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'\', \'hello\') returns {\'first\': NameTag(\'\'), \'second\': NameTag(\'hello\')}', () {
      final x = '';
      final y = 'hello';
      final expected = {'first': NameTag(''), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'\', \'  \') returns {\'first\': NameTag(\'\'), \'second\': NameTag(\'  \')}', () {
      final x = '';
      final y = '  ';
      final expected = {'first': NameTag(''), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'\') returns {\'first\': NameTag(\'hello\'), \'second\': NameTag(\'\')}', () {
      final x = 'hello';
      final y = '';
      final expected = {'first': NameTag('hello'), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'hello\') returns {\'first\': NameTag(\'hello\'), \'second\': NameTag(\'hello\')}', () {
      final x = 'hello';
      final y = 'hello';
      final expected = {'first': NameTag('hello'), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'  \') returns {\'first\': NameTag(\'hello\'), \'second\': NameTag(\'  \')}', () {
      final x = 'hello';
      final y = '  ';
      final expected = {'first': NameTag('hello'), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'\') returns {\'first\': NameTag(\'  \'), \'second\': NameTag(\'\')}', () {
      final x = '  ';
      final y = '';
      final expected = {'first': NameTag('  '), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'hello\') returns {\'first\': NameTag(\'  \'), \'second\': NameTag(\'hello\')}', () {
      final x = '  ';
      final y = 'hello';
      final expected = {'first': NameTag('  '), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'  \') returns {\'first\': NameTag(\'  \'), \'second\': NameTag(\'  \')}', () {
      final x = '  ';
      final y = '  ';
      final expected = {'first': NameTag('  '), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
  });

  group('pairCounterLabels', () {
    test('pairCounterLabels(0, 0) returns [CounterLabel(0, \'\'), CounterLabel(0, \'test\')]', () {
      final a = 0;
      final b = 0;
      final expected = [CounterLabel(0, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 1) returns [CounterLabel(0, \'\'), CounterLabel(1, \'test\')]', () {
      final a = 0;
      final b = 1;
      final expected = [CounterLabel(0, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -1) returns [CounterLabel(0, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = 0;
      final b = -1;
      final expected = [CounterLabel(0, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 2) returns [CounterLabel(0, \'\'), CounterLabel(2, \'test\')]', () {
      final a = 0;
      final b = 2;
      final expected = [CounterLabel(0, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -2) returns [CounterLabel(0, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = 0;
      final b = -2;
      final expected = [CounterLabel(0, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 10) returns [CounterLabel(0, \'\'), CounterLabel(10, \'test\')]', () {
      final a = 0;
      final b = 10;
      final expected = [CounterLabel(0, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -10) returns [CounterLabel(0, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = 0;
      final b = -10;
      final expected = [CounterLabel(0, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 0) returns [CounterLabel(1, \'\'), CounterLabel(0, \'test\')]', () {
      final a = 1;
      final b = 0;
      final expected = [CounterLabel(1, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 1) returns [CounterLabel(1, \'\'), CounterLabel(1, \'test\')]', () {
      final a = 1;
      final b = 1;
      final expected = [CounterLabel(1, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -1) returns [CounterLabel(1, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = 1;
      final b = -1;
      final expected = [CounterLabel(1, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 2) returns [CounterLabel(1, \'\'), CounterLabel(2, \'test\')]', () {
      final a = 1;
      final b = 2;
      final expected = [CounterLabel(1, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -2) returns [CounterLabel(1, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = 1;
      final b = -2;
      final expected = [CounterLabel(1, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 10) returns [CounterLabel(1, \'\'), CounterLabel(10, \'test\')]', () {
      final a = 1;
      final b = 10;
      final expected = [CounterLabel(1, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -10) returns [CounterLabel(1, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = 1;
      final b = -10;
      final expected = [CounterLabel(1, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 0) returns [CounterLabel(-1, \'\'), CounterLabel(0, \'test\')]', () {
      final a = -1;
      final b = 0;
      final expected = [CounterLabel(-1, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 1) returns [CounterLabel(-1, \'\'), CounterLabel(1, \'test\')]', () {
      final a = -1;
      final b = 1;
      final expected = [CounterLabel(-1, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, -1) returns [CounterLabel(-1, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = -1;
      final b = -1;
      final expected = [CounterLabel(-1, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 2) returns [CounterLabel(-1, \'\'), CounterLabel(2, \'test\')]', () {
      final a = -1;
      final b = 2;
      final expected = [CounterLabel(-1, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, -2) returns [CounterLabel(-1, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = -1;
      final b = -2;
      final expected = [CounterLabel(-1, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 10) returns [CounterLabel(-1, \'\'), CounterLabel(10, \'test\')]', () {
      final a = -1;
      final b = 10;
      final expected = [CounterLabel(-1, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, -10) returns [CounterLabel(-1, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = -1;
      final b = -10;
      final expected = [CounterLabel(-1, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, 0) returns [CounterLabel(2, \'\'), CounterLabel(0, \'test\')]', () {
      final a = 2;
      final b = 0;
      final expected = [CounterLabel(2, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, 1) returns [CounterLabel(2, \'\'), CounterLabel(1, \'test\')]', () {
      final a = 2;
      final b = 1;
      final expected = [CounterLabel(2, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, -1) returns [CounterLabel(2, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = 2;
      final b = -1;
      final expected = [CounterLabel(2, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, 2) returns [CounterLabel(2, \'\'), CounterLabel(2, \'test\')]', () {
      final a = 2;
      final b = 2;
      final expected = [CounterLabel(2, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, -2) returns [CounterLabel(2, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = 2;
      final b = -2;
      final expected = [CounterLabel(2, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, 10) returns [CounterLabel(2, \'\'), CounterLabel(10, \'test\')]', () {
      final a = 2;
      final b = 10;
      final expected = [CounterLabel(2, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(2, -10) returns [CounterLabel(2, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = 2;
      final b = -10;
      final expected = [CounterLabel(2, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, 0) returns [CounterLabel(-2, \'\'), CounterLabel(0, \'test\')]', () {
      final a = -2;
      final b = 0;
      final expected = [CounterLabel(-2, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, 1) returns [CounterLabel(-2, \'\'), CounterLabel(1, \'test\')]', () {
      final a = -2;
      final b = 1;
      final expected = [CounterLabel(-2, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, -1) returns [CounterLabel(-2, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = -2;
      final b = -1;
      final expected = [CounterLabel(-2, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, 2) returns [CounterLabel(-2, \'\'), CounterLabel(2, \'test\')]', () {
      final a = -2;
      final b = 2;
      final expected = [CounterLabel(-2, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, -2) returns [CounterLabel(-2, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = -2;
      final b = -2;
      final expected = [CounterLabel(-2, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, 10) returns [CounterLabel(-2, \'\'), CounterLabel(10, \'test\')]', () {
      final a = -2;
      final b = 10;
      final expected = [CounterLabel(-2, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-2, -10) returns [CounterLabel(-2, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = -2;
      final b = -10;
      final expected = [CounterLabel(-2, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, 0) returns [CounterLabel(10, \'\'), CounterLabel(0, \'test\')]', () {
      final a = 10;
      final b = 0;
      final expected = [CounterLabel(10, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, 1) returns [CounterLabel(10, \'\'), CounterLabel(1, \'test\')]', () {
      final a = 10;
      final b = 1;
      final expected = [CounterLabel(10, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, -1) returns [CounterLabel(10, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = 10;
      final b = -1;
      final expected = [CounterLabel(10, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, 2) returns [CounterLabel(10, \'\'), CounterLabel(2, \'test\')]', () {
      final a = 10;
      final b = 2;
      final expected = [CounterLabel(10, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, -2) returns [CounterLabel(10, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = 10;
      final b = -2;
      final expected = [CounterLabel(10, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, 10) returns [CounterLabel(10, \'\'), CounterLabel(10, \'test\')]', () {
      final a = 10;
      final b = 10;
      final expected = [CounterLabel(10, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(10, -10) returns [CounterLabel(10, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = 10;
      final b = -10;
      final expected = [CounterLabel(10, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, 0) returns [CounterLabel(-10, \'\'), CounterLabel(0, \'test\')]', () {
      final a = -10;
      final b = 0;
      final expected = [CounterLabel(-10, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, 1) returns [CounterLabel(-10, \'\'), CounterLabel(1, \'test\')]', () {
      final a = -10;
      final b = 1;
      final expected = [CounterLabel(-10, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, -1) returns [CounterLabel(-10, \'\'), CounterLabel(-1, \'test\')]', () {
      final a = -10;
      final b = -1;
      final expected = [CounterLabel(-10, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, 2) returns [CounterLabel(-10, \'\'), CounterLabel(2, \'test\')]', () {
      final a = -10;
      final b = 2;
      final expected = [CounterLabel(-10, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, -2) returns [CounterLabel(-10, \'\'), CounterLabel(-2, \'test\')]', () {
      final a = -10;
      final b = -2;
      final expected = [CounterLabel(-10, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, 10) returns [CounterLabel(-10, \'\'), CounterLabel(10, \'test\')]', () {
      final a = -10;
      final b = 10;
      final expected = [CounterLabel(-10, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-10, -10) returns [CounterLabel(-10, \'\'), CounterLabel(-10, \'test\')]', () {
      final a = -10;
      final b = -10;
      final expected = [CounterLabel(-10, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
  });

  group('sumIterable', () {
    test('sumIterable(<int>[]) returns 0', () {
      final items = <int>[];
      final expected = 0;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
    test('sumIterable([0]) returns 0', () {
      final items = [0];
      final expected = 0;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
    test('sumIterable([1, -1, 2]) returns 2', () {
      final items = [1, -1, 2];
      final expected = 2;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
  });

  group('sumFromSet', () {
    test('sumFromSet(<int>{}) returns 0', () {
      final items = <int>{};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
    test('sumFromSet({0}) returns 0', () {
      final items = {0};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
    test('sumFromSet({-1, 1}) returns 0', () {
      final items = {-1, 1};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
  });

  group('firstLength', () {
    test('firstLength(<String>[]) returns 0', () {
      final rows = <String>[];
      final expected = 0;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
    test('firstLength([\'\']) returns 0', () {
      final rows = [''];
      final expected = 0;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
    test('firstLength([\'hello\']) returns 5', () {
      final rows = ['hello'];
      final expected = 5;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
  });

}
