import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/type_extensions_showcase/type_extensions_showcase.dart';
import 'package:dart_test_gen/usecases/type_extensions_showcase/counter_label.dart';
import 'package:dart_test_gen/usecases/type_extensions_showcase/name_tag.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T14:20:17.759068

void main() {
  final typeextensionsshowcase = TypeExtensionsShowcase();

  group('baseline', () {
    test('baseline(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = 2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = -2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = 10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = -10;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = 2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = 3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = 11;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = -9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = -1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = 0;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = -2;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = 1;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = -3;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
    test('baseline(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = 9;
      final actual = typeextensionsshowcase.baseline(a, b);
      expect(actual, expected);
    });
  });

  group('heavier', () {
    test('heavier(CounterLabel(0, \'\'), CounterLabel(0, \'\'))', () {
      final x = CounterLabel(0, '');
      final y = CounterLabel(0, '');
      final expected = CounterLabel(0, '');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(0, \'\'), CounterLabel(255, \'test\'))', () {
      final x = CounterLabel(0, '');
      final y = CounterLabel(255, 'test');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(255, \'test\'), CounterLabel(0, \'\'))', () {
      final x = CounterLabel(255, 'test');
      final y = CounterLabel(0, '');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
    test('heavier(CounterLabel(255, \'test\'), CounterLabel(255, \'test\'))', () {
      final x = CounterLabel(255, 'test');
      final y = CounterLabel(255, 'test');
      final expected = CounterLabel(255, 'test');
      final actual = typeextensionsshowcase.heavier(x, y);
      expect(actual, expected);
    });
  });

  group('longerName', () {
    test('longerName(NameTag(\'\'), NameTag(\'\'))', () {
      final a = NameTag('');
      final b = NameTag('');
      final expected = NameTag('');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'\'), NameTag(\'test\'))', () {
      final a = NameTag('');
      final b = NameTag('test');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'test\'), NameTag(\'\'))', () {
      final a = NameTag('test');
      final b = NameTag('');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
    test('longerName(NameTag(\'test\'), NameTag(\'test\'))', () {
      final a = NameTag('test');
      final b = NameTag('test');
      final expected = NameTag('test');
      final actual = typeextensionsshowcase.longerName(a, b);
      expect(actual, expected);
    });
  });

  group('pairAsIterable', () {
    test('pairAsIterable(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = [0, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = [0, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = [0, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = [0, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = [0, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = [0, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = [0, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = [1, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = [1, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = [1, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = [1, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = [1, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = [1, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = [1, -10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = [-1, 0];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = [-1, 1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = [-1, -1];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = [-1, 2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = [-1, -2];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
    test('pairAsIterable(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = [-1, 10];
      final actual = typeextensionsshowcase.pairAsIterable(a, b);
      expect(actual, expected);
    });
  });

  group('uniquePair', () {
    test('uniquePair(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = {0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = {0, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = {-1, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = {0, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = {-2, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = {0, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = {-10, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = {0, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = {1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = {-1, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = {1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = {-2, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = {1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = {-10, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = {-1, 0};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = {-1, 1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = {-1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = {-1, 2};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = {-2, -1};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
    test('uniquePair(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = {-1, 10};
      final actual = typeextensionsshowcase.uniquePair(a, b);
      expect(actual, expected);
    });
  });

  group('pairStrings', () {
    test('pairStrings(\'\', \'\')', () {
      final x = '';
      final y = '';
      final expected = ['', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'\', \'hello\')', () {
      final x = '';
      final y = 'hello';
      final expected = ['', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'\', \'  \')', () {
      final x = '';
      final y = '  ';
      final expected = ['', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'\')', () {
      final x = 'hello';
      final y = '';
      final expected = ['hello', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'hello\')', () {
      final x = 'hello';
      final y = 'hello';
      final expected = ['hello', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'hello\', \'  \')', () {
      final x = 'hello';
      final y = '  ';
      final expected = ['hello', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'\')', () {
      final x = '  ';
      final y = '';
      final expected = ['  ', ''];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'hello\')', () {
      final x = '  ';
      final y = 'hello';
      final expected = ['  ', 'hello'];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
    test('pairStrings(\'  \', \'  \')', () {
      final x = '  ';
      final y = '  ';
      final expected = ['  ', '  '];
      final actual = typeextensionsshowcase.pairStrings(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTags', () {
    test('pairNameTags(\'\', \'\')', () {
      final x = '';
      final y = '';
      final expected = [NameTag(''), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'\', \'hello\')', () {
      final x = '';
      final y = 'hello';
      final expected = [NameTag(''), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'\', \'  \')', () {
      final x = '';
      final y = '  ';
      final expected = [NameTag(''), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'\')', () {
      final x = 'hello';
      final y = '';
      final expected = [NameTag('hello'), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'hello\')', () {
      final x = 'hello';
      final y = 'hello';
      final expected = [NameTag('hello'), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'hello\', \'  \')', () {
      final x = 'hello';
      final y = '  ';
      final expected = [NameTag('hello'), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'\')', () {
      final x = '  ';
      final y = '';
      final expected = [NameTag('  '), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'hello\')', () {
      final x = '  ';
      final y = 'hello';
      final expected = [NameTag('  '), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
    test('pairNameTags(\'  \', \'  \')', () {
      final x = '  ';
      final y = '  ';
      final expected = [NameTag('  '), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTags(x, y);
      expect(actual, expected);
    });
  });

  group('uniqueNameTagSet', () {
    test('uniqueNameTagSet(\'\', \'\')', () {
      final x = '';
      final y = '';
      final expected = {NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'\', \'hello\')', () {
      final x = '';
      final y = 'hello';
      final expected = {NameTag(''), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'\', \'  \')', () {
      final x = '';
      final y = '  ';
      final expected = {NameTag('  '), NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'\')', () {
      final x = 'hello';
      final y = '';
      final expected = {NameTag(''), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'hello\')', () {
      final x = 'hello';
      final y = 'hello';
      final expected = {NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'hello\', \'  \')', () {
      final x = 'hello';
      final y = '  ';
      final expected = {NameTag('  '), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'\')', () {
      final x = '  ';
      final y = '';
      final expected = {NameTag('  '), NameTag('')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'hello\')', () {
      final x = '  ';
      final y = 'hello';
      final expected = {NameTag('  '), NameTag('hello')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
    test('uniqueNameTagSet(\'  \', \'  \')', () {
      final x = '  ';
      final y = '  ';
      final expected = {NameTag('  ')};
      final actual = typeextensionsshowcase.uniqueNameTagSet(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTagsIterable', () {
    test('pairNameTagsIterable(\'\', \'\')', () {
      final x = '';
      final y = '';
      final expected = [NameTag(''), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'\', \'hello\')', () {
      final x = '';
      final y = 'hello';
      final expected = [NameTag(''), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'\', \'  \')', () {
      final x = '';
      final y = '  ';
      final expected = [NameTag(''), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'\')', () {
      final x = 'hello';
      final y = '';
      final expected = [NameTag('hello'), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'hello\')', () {
      final x = 'hello';
      final y = 'hello';
      final expected = [NameTag('hello'), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'hello\', \'  \')', () {
      final x = 'hello';
      final y = '  ';
      final expected = [NameTag('hello'), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'\')', () {
      final x = '  ';
      final y = '';
      final expected = [NameTag('  '), NameTag('')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'hello\')', () {
      final x = '  ';
      final y = 'hello';
      final expected = [NameTag('  '), NameTag('hello')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
    test('pairNameTagsIterable(\'  \', \'  \')', () {
      final x = '  ';
      final y = '  ';
      final expected = [NameTag('  '), NameTag('  ')];
      final actual = typeextensionsshowcase.pairNameTagsIterable(x, y);
      expect(actual, expected);
    });
  });

  group('pairNameTagMap', () {
    test('pairNameTagMap(\'\', \'\')', () {
      final x = '';
      final y = '';
      final expected = {'first': NameTag(''), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'\', \'hello\')', () {
      final x = '';
      final y = 'hello';
      final expected = {'first': NameTag(''), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'\', \'  \')', () {
      final x = '';
      final y = '  ';
      final expected = {'first': NameTag(''), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'\')', () {
      final x = 'hello';
      final y = '';
      final expected = {'first': NameTag('hello'), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'hello\')', () {
      final x = 'hello';
      final y = 'hello';
      final expected = {'first': NameTag('hello'), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'hello\', \'  \')', () {
      final x = 'hello';
      final y = '  ';
      final expected = {'first': NameTag('hello'), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'\')', () {
      final x = '  ';
      final y = '';
      final expected = {'first': NameTag('  '), 'second': NameTag('')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'hello\')', () {
      final x = '  ';
      final y = 'hello';
      final expected = {'first': NameTag('  '), 'second': NameTag('hello')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
    test('pairNameTagMap(\'  \', \'  \')', () {
      final x = '  ';
      final y = '  ';
      final expected = {'first': NameTag('  '), 'second': NameTag('  ')};
      final actual = typeextensionsshowcase.pairNameTagMap(x, y);
      expect(actual, expected);
    });
  });

  group('pairCounterLabels', () {
    test('pairCounterLabels(0, 0)', () {
      final a = 0;
      final b = 0;
      final expected = [CounterLabel(0, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 1)', () {
      final a = 0;
      final b = 1;
      final expected = [CounterLabel(0, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -1)', () {
      final a = 0;
      final b = -1;
      final expected = [CounterLabel(0, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 2)', () {
      final a = 0;
      final b = 2;
      final expected = [CounterLabel(0, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -2)', () {
      final a = 0;
      final b = -2;
      final expected = [CounterLabel(0, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, 10)', () {
      final a = 0;
      final b = 10;
      final expected = [CounterLabel(0, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(0, -10)', () {
      final a = 0;
      final b = -10;
      final expected = [CounterLabel(0, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 0)', () {
      final a = 1;
      final b = 0;
      final expected = [CounterLabel(1, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 1)', () {
      final a = 1;
      final b = 1;
      final expected = [CounterLabel(1, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -1)', () {
      final a = 1;
      final b = -1;
      final expected = [CounterLabel(1, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 2)', () {
      final a = 1;
      final b = 2;
      final expected = [CounterLabel(1, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -2)', () {
      final a = 1;
      final b = -2;
      final expected = [CounterLabel(1, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, 10)', () {
      final a = 1;
      final b = 10;
      final expected = [CounterLabel(1, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(1, -10)', () {
      final a = 1;
      final b = -10;
      final expected = [CounterLabel(1, ''), CounterLabel(-10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 0)', () {
      final a = -1;
      final b = 0;
      final expected = [CounterLabel(-1, ''), CounterLabel(0, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 1)', () {
      final a = -1;
      final b = 1;
      final expected = [CounterLabel(-1, ''), CounterLabel(1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, -1)', () {
      final a = -1;
      final b = -1;
      final expected = [CounterLabel(-1, ''), CounterLabel(-1, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 2)', () {
      final a = -1;
      final b = 2;
      final expected = [CounterLabel(-1, ''), CounterLabel(2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, -2)', () {
      final a = -1;
      final b = -2;
      final expected = [CounterLabel(-1, ''), CounterLabel(-2, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
    test('pairCounterLabels(-1, 10)', () {
      final a = -1;
      final b = 10;
      final expected = [CounterLabel(-1, ''), CounterLabel(10, 'test')];
      final actual = typeextensionsshowcase.pairCounterLabels(a, b);
      expect(actual, expected);
    });
  });

  group('sumIterable', () {
    test('sumIterable(<int>[])', () {
      final items = <int>[];
      final expected = 0;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
    test('sumIterable([0])', () {
      final items = [0];
      final expected = 0;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
    test('sumIterable([1, -1, 2])', () {
      final items = [1, -1, 2];
      final expected = 2;
      final actual = typeextensionsshowcase.sumIterable(items);
      expect(actual, expected);
    });
  });

  group('sumFromSet', () {
    test('sumFromSet(<int>{})', () {
      final items = <int>{};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
    test('sumFromSet({0})', () {
      final items = {0};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
    test('sumFromSet({-1, 1})', () {
      final items = {-1, 1};
      final expected = 0;
      final actual = typeextensionsshowcase.sumFromSet(items);
      expect(actual, expected);
    });
  });

  group('firstLength', () {
    test('firstLength(<String>[])', () {
      final rows = <String>[];
      final expected = 0;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
    test('firstLength([\'\'])', () {
      final rows = [''];
      final expected = 0;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
    test('firstLength([\'hello\'])', () {
      final rows = ['hello'];
      final expected = 5;
      final actual = typeextensionsshowcase.firstLength(rows);
      expect(actual, expected);
    });
  });

}
