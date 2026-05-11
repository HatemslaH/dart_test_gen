import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/data_toolbox/data_toolbox.dart';
import 'package:dart_test_gen/usecases/data_toolbox/log_level.dart';
import 'package:dart_test_gen/usecases/data_toolbox/rgb_color.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T16:52:44.699302

void main() {
  final datatoolbox = DataToolbox();

  group('describe', () {
    test('describe(LogLevel.trace, 0)', () {
      final level = LogLevel.trace;
      final code = 0;
      final expected = 'trace:0';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, 1)', () {
      final level = LogLevel.trace;
      final code = 1;
      final expected = 'trace:1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, -1)', () {
      final level = LogLevel.trace;
      final code = -1;
      final expected = 'trace:-1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, 2)', () {
      final level = LogLevel.trace;
      final code = 2;
      final expected = 'trace:2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, -2)', () {
      final level = LogLevel.trace;
      final code = -2;
      final expected = 'trace:-2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, 10)', () {
      final level = LogLevel.trace;
      final code = 10;
      final expected = 'trace:10';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.trace, -10)', () {
      final level = LogLevel.trace;
      final code = -10;
      final expected = 'trace:-10';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, 0)', () {
      final level = LogLevel.warning;
      final code = 0;
      final expected = 'warn:0';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, 1)', () {
      final level = LogLevel.warning;
      final code = 1;
      final expected = 'warn:1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, -1)', () {
      final level = LogLevel.warning;
      final code = -1;
      final expected = 'warn:-1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, 2)', () {
      final level = LogLevel.warning;
      final code = 2;
      final expected = 'warn:2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, -2)', () {
      final level = LogLevel.warning;
      final code = -2;
      final expected = 'warn:-2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, 10)', () {
      final level = LogLevel.warning;
      final code = 10;
      final expected = 'warn:10';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.warning, -10)', () {
      final level = LogLevel.warning;
      final code = -10;
      final expected = 'warn:-10';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, 0)', () {
      final level = LogLevel.fatal;
      final code = 0;
      final expected = 'fatal:0';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, 1)', () {
      final level = LogLevel.fatal;
      final code = 1;
      final expected = 'fatal:1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, -1)', () {
      final level = LogLevel.fatal;
      final code = -1;
      final expected = 'fatal:-1';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, 2)', () {
      final level = LogLevel.fatal;
      final code = 2;
      final expected = 'fatal:2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, -2)', () {
      final level = LogLevel.fatal;
      final code = -2;
      final expected = 'fatal:-2';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
    test('describe(LogLevel.fatal, 10)', () {
      final level = LogLevel.fatal;
      final code = 10;
      final expected = 'fatal:10';
      final actual = datatoolbox.describe(level, code);
      expect(actual, expected);
    });
  });

  group('weightedMean', () {
    test('weightedMean(<int>[], 0.0)', () {
      final samples = <int>[];
      final weight = 0.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean(<int>[], 1.0)', () {
      final samples = <int>[];
      final weight = 1.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean(<int>[], -1.0)', () {
      final samples = <int>[];
      final weight = -1.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean(<int>[], 0.5)', () {
      final samples = <int>[];
      final weight = 0.5;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean(<int>[], -0.5)', () {
      final samples = <int>[];
      final weight = -0.5;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([0], 0.0)', () {
      final samples = [0];
      final weight = 0.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([0], 1.0)', () {
      final samples = [0];
      final weight = 1.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([0], -1.0)', () {
      final samples = [0];
      final weight = -1.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([0], 0.5)', () {
      final samples = [0];
      final weight = 0.5;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([0], -0.5)', () {
      final samples = [0];
      final weight = -0.5;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([1, -1, 2], 0.0)', () {
      final samples = [1, -1, 2];
      final weight = 0.0;
      final expected = 0.0;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([1, -1, 2], 1.0)', () {
      final samples = [1, -1, 2];
      final weight = 1.0;
      final expected = 0.6666666666666666;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([1, -1, 2], -1.0)', () {
      final samples = [1, -1, 2];
      final weight = -1.0;
      final expected = -0.6666666666666666;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([1, -1, 2], 0.5)', () {
      final samples = [1, -1, 2];
      final weight = 0.5;
      final expected = 0.3333333333333333;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
    test('weightedMean([1, -1, 2], -0.5)', () {
      final samples = [1, -1, 2];
      final weight = -0.5;
      final expected = -0.3333333333333333;
      final actual = datatoolbox.weightedMean(samples, weight);
      expect(actual, expected);
    });
  });

  group('blend', () {
    test('blend(RgbColor(0, 0, 0), RgbColor(0, 0, 0), 0.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(0, 0, 0);
      final t = 0.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(0, 0, 0), 1.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(0, 0, 0);
      final t = 1.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(0, 0, 0), -1.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(0, 0, 0);
      final t = -1.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(0, 0, 0), 0.5)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(0, 0, 0);
      final t = 0.5;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(0, 0, 0), -0.5)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(0, 0, 0);
      final t = -0.5;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(255, 255, 255), 0.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(255, 255, 255);
      final t = 0.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(255, 255, 255), 1.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(255, 255, 255);
      final t = 1.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(255, 255, 255), -1.0)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(255, 255, 255);
      final t = -1.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(255, 255, 255), 0.5)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(255, 255, 255);
      final t = 0.5;
      final expected = RgbColor(128, 128, 128);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(0, 0, 0), RgbColor(255, 255, 255), -0.5)', () {
      final a = RgbColor(0, 0, 0);
      final b = RgbColor(255, 255, 255);
      final t = -0.5;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(0, 0, 0), 0.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(0, 0, 0);
      final t = 0.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(0, 0, 0), 1.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(0, 0, 0);
      final t = 1.0;
      final expected = RgbColor(0, 0, 0);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(0, 0, 0), -1.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(0, 0, 0);
      final t = -1.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(0, 0, 0), 0.5)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(0, 0, 0);
      final t = 0.5;
      final expected = RgbColor(128, 128, 128);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(0, 0, 0), -0.5)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(0, 0, 0);
      final t = -0.5;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(255, 255, 255), 0.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(255, 255, 255);
      final t = 0.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(255, 255, 255), 1.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(255, 255, 255);
      final t = 1.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(255, 255, 255), -1.0)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(255, 255, 255);
      final t = -1.0;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(255, 255, 255), 0.5)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(255, 255, 255);
      final t = 0.5;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
    test('blend(RgbColor(255, 255, 255), RgbColor(255, 255, 255), -0.5)', () {
      final a = RgbColor(255, 255, 255);
      final b = RgbColor(255, 255, 255);
      final t = -0.5;
      final expected = RgbColor(255, 255, 255);
      final actual = datatoolbox.blend(a, b, t);
      expect(actual, expected);
    });
  });

  group('appendIfMissing', () {
    test('appendIfMissing(<int>[], 0)', () {
      final items = <int>[];
      final x = 0;
      final expected = [0];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], 1)', () {
      final items = <int>[];
      final x = 1;
      final expected = [1];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], -1)', () {
      final items = <int>[];
      final x = -1;
      final expected = [-1];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], 2)', () {
      final items = <int>[];
      final x = 2;
      final expected = [2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], -2)', () {
      final items = <int>[];
      final x = -2;
      final expected = [-2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], 10)', () {
      final items = <int>[];
      final x = 10;
      final expected = [10];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing(<int>[], -10)', () {
      final items = <int>[];
      final x = -10;
      final expected = [-10];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], 0)', () {
      final items = [0];
      final x = 0;
      final expected = [0];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], 1)', () {
      final items = [0];
      final x = 1;
      final expected = [0, 1];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], -1)', () {
      final items = [0];
      final x = -1;
      final expected = [0, -1];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], 2)', () {
      final items = [0];
      final x = 2;
      final expected = [0, 2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], -2)', () {
      final items = [0];
      final x = -2;
      final expected = [0, -2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], 10)', () {
      final items = [0];
      final x = 10;
      final expected = [0, 10];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([0], -10)', () {
      final items = [0];
      final x = -10;
      final expected = [0, -10];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], 0)', () {
      final items = [1, -1, 2];
      final x = 0;
      final expected = [1, -1, 2, 0];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], 1)', () {
      final items = [1, -1, 2];
      final x = 1;
      final expected = [1, -1, 2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], -1)', () {
      final items = [1, -1, 2];
      final x = -1;
      final expected = [1, -1, 2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], 2)', () {
      final items = [1, -1, 2];
      final x = 2;
      final expected = [1, -1, 2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], -2)', () {
      final items = [1, -1, 2];
      final x = -2;
      final expected = [1, -1, 2, -2];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
    test('appendIfMissing([1, -1, 2], 10)', () {
      final items = [1, -1, 2];
      final x = 10;
      final expected = [1, -1, 2, 10];
      final actual = datatoolbox.appendIfMissing(items, x);
      expect(actual, expected);
    });
  });

  group('measureStrings', () {
    test('measureStrings(\'\', \'\')', () {
      final left = '';
      final right = '';
      final expected = {'a': 0, 'b': 0, 'sum': 0};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'\', \'hello\')', () {
      final left = '';
      final right = 'hello';
      final expected = {'a': 0, 'b': 5, 'sum': 5};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'\', \'  \')', () {
      final left = '';
      final right = '  ';
      final expected = {'a': 0, 'b': 2, 'sum': 2};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'hello\', \'\')', () {
      final left = 'hello';
      final right = '';
      final expected = {'a': 5, 'b': 0, 'sum': 5};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'hello\', \'hello\')', () {
      final left = 'hello';
      final right = 'hello';
      final expected = {'a': 5, 'b': 5, 'sum': 10};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'hello\', \'  \')', () {
      final left = 'hello';
      final right = '  ';
      final expected = {'a': 5, 'b': 2, 'sum': 7};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'  \', \'\')', () {
      final left = '  ';
      final right = '';
      final expected = {'a': 2, 'b': 0, 'sum': 2};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'  \', \'hello\')', () {
      final left = '  ';
      final right = 'hello';
      final expected = {'a': 2, 'b': 5, 'sum': 7};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
    test('measureStrings(\'  \', \'  \')', () {
      final left = '  ';
      final right = '  ';
      final expected = {'a': 2, 'b': 2, 'sum': 4};
      final actual = datatoolbox.measureStrings(left, right);
      expect(actual, expected);
    });
  });

  group('isUrgent', () {
    test('isUrgent(LogLevel.trace)', () {
      final level = LogLevel.trace;
      final expected = false;
      final actual = datatoolbox.isUrgent(level);
      expect(actual, expected);
    });
    test('isUrgent(LogLevel.warning)', () {
      final level = LogLevel.warning;
      final expected = false;
      final actual = datatoolbox.isUrgent(level);
      expect(actual, expected);
    });
    test('isUrgent(LogLevel.fatal)', () {
      final level = LogLevel.fatal;
      final expected = true;
      final actual = datatoolbox.isUrgent(level);
      expect(actual, expected);
    });
  });

  group('acknowledge', () {
    test('acknowledge(LogLevel.fatal) throws StateError', () {
      final level = LogLevel.fatal;
      expect(() => datatoolbox.acknowledge(level), throwsA(isA<StateError>()));
    });
    test('acknowledge(LogLevel.trace) runs without error', () {
      final level = LogLevel.trace;
      expect(() => datatoolbox.acknowledge(level), returnsNormally);
    });
    test('acknowledge(LogLevel.warning) runs without error', () {
      final level = LogLevel.warning;
      expect(() => datatoolbox.acknowledge(level), returnsNormally);
    });
  });

}
