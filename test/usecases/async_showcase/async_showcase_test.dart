import 'package:test/test.dart';
import 'package:dart_test_gen/usecases/async_showcase/async_showcase.dart';
import 'package:dart_test_gen/usecases/async_showcase/priority.dart';
import 'package:dart_test_gen/usecases/async_showcase/task_result.dart';

// AUTO-GENERATED — не редактировать вручную
// Сгенерировано: 2026-05-11T16:52:44.738408

void main() {
  final asyncshowcase = AsyncShowcase();

  group('computeScore', () {
    test('computeScore(0, Priority.low)', () async {
      final base = 0;
      final priority = Priority.low;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.normal)', () async {
      final base = 0;
      final priority = Priority.normal;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.high)', () async {
      final base = 0;
      final priority = Priority.high;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.critical)', () async {
      final base = 0;
      final priority = Priority.critical;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.low)', () async {
      final base = 1;
      final priority = Priority.low;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.normal)', () async {
      final base = 1;
      final priority = Priority.normal;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.high)', () async {
      final base = 1;
      final priority = Priority.high;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.critical)', () async {
      final base = 1;
      final priority = Priority.critical;
      final expected = 4;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.low)', () async {
      final base = -1;
      final priority = Priority.low;
      final expected = -1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.normal)', () async {
      final base = -1;
      final priority = Priority.normal;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.high)', () async {
      final base = -1;
      final priority = Priority.high;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.critical)', () async {
      final base = -1;
      final priority = Priority.critical;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.low)', () async {
      final base = 2;
      final priority = Priority.low;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.normal)', () async {
      final base = 2;
      final priority = Priority.normal;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.high)', () async {
      final base = 2;
      final priority = Priority.high;
      final expected = 4;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.critical)', () async {
      final base = 2;
      final priority = Priority.critical;
      final expected = 5;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.low)', () async {
      final base = -2;
      final priority = Priority.low;
      final expected = -2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.normal)', () async {
      final base = -2;
      final priority = Priority.normal;
      final expected = -1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.high)', () async {
      final base = -2;
      final priority = Priority.high;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.critical)', () async {
      final base = -2;
      final priority = Priority.critical;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
  });

  group('isHighPriority', () {
    test('isHighPriority(Priority.low)', () async {
      final priority = Priority.low;
      final expected = false;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, expected);
    });
    test('isHighPriority(Priority.normal)', () async {
      final priority = Priority.normal;
      final expected = false;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, expected);
    });
    test('isHighPriority(Priority.high)', () async {
      final priority = Priority.high;
      final expected = true;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, expected);
    });
    test('isHighPriority(Priority.critical)', () async {
      final priority = Priority.critical;
      final expected = true;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, expected);
    });
  });

  group('describeTask', () {
    test('describeTask(TaskResult(\'\', 0))', () async {
      final task = TaskResult('', 0);
      final expected = ':0';
      final actual = await asyncshowcase.describeTask(task);
      expect(actual, expected);
    });
    test('describeTask(TaskResult(\'test\', 255))', () async {
      final task = TaskResult('test', 255);
      final expected = 'test:255';
      final actual = await asyncshowcase.describeTask(task);
      expect(actual, expected);
    });
  });

  group('buildTask', () {
    test('buildTask(\'\', 0)', () async {
      final title = '';
      final score = 0;
      final expected = TaskResult('', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 1)', () async {
      final title = '';
      final score = 1;
      final expected = TaskResult('', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -1)', () async {
      final title = '';
      final score = -1;
      final expected = TaskResult('', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 2)', () async {
      final title = '';
      final score = 2;
      final expected = TaskResult('', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -2)', () async {
      final title = '';
      final score = -2;
      final expected = TaskResult('', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 10)', () async {
      final title = '';
      final score = 10;
      final expected = TaskResult('', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -10)', () async {
      final title = '';
      final score = -10;
      final expected = TaskResult('', -10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 0)', () async {
      final title = 'hello';
      final score = 0;
      final expected = TaskResult('hello', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 1)', () async {
      final title = 'hello';
      final score = 1;
      final expected = TaskResult('hello', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -1)', () async {
      final title = 'hello';
      final score = -1;
      final expected = TaskResult('hello', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 2)', () async {
      final title = 'hello';
      final score = 2;
      final expected = TaskResult('hello', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -2)', () async {
      final title = 'hello';
      final score = -2;
      final expected = TaskResult('hello', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 10)', () async {
      final title = 'hello';
      final score = 10;
      final expected = TaskResult('hello', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -10)', () async {
      final title = 'hello';
      final score = -10;
      final expected = TaskResult('hello', -10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 0)', () async {
      final title = '  ';
      final score = 0;
      final expected = TaskResult('  ', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 1)', () async {
      final title = '  ';
      final score = 1;
      final expected = TaskResult('  ', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', -1)', () async {
      final title = '  ';
      final score = -1;
      final expected = TaskResult('  ', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 2)', () async {
      final title = '  ';
      final score = 2;
      final expected = TaskResult('  ', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', -2)', () async {
      final title = '  ';
      final score = -2;
      final expected = TaskResult('  ', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 10)', () async {
      final title = '  ';
      final score = 10;
      final expected = TaskResult('  ', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
  });

  group('validateScore', () {
    test('validateScore(-1) throws RangeError', () async {
      final score = -1;
      await expectLater(asyncshowcase.validateScore(score), throwsA(isA<RangeError>()));
    });
    test('validateScore(-2) throws RangeError', () async {
      final score = -2;
      await expectLater(asyncshowcase.validateScore(score), throwsA(isA<RangeError>()));
    });
    test('validateScore(-10) throws RangeError', () async {
      final score = -10;
      await expectLater(asyncshowcase.validateScore(score), throwsA(isA<RangeError>()));
    });
    test('validateScore(101) throws RangeError', () async {
      final score = 101;
      await expectLater(asyncshowcase.validateScore(score), throwsA(isA<RangeError>()));
    });
    test('validateScore(0) runs without error', () async {
      final score = 0;
      await asyncshowcase.validateScore(score);
    });
    test('validateScore(1) runs without error', () async {
      final score = 1;
      await asyncshowcase.validateScore(score);
    });
    test('validateScore(2) runs without error', () async {
      final score = 2;
      await asyncshowcase.validateScore(score);
    });
    test('validateScore(10) runs without error', () async {
      final score = 10;
      await asyncshowcase.validateScore(score);
    });
    test('validateScore(100) runs without error', () async {
      final score = 100;
      await asyncshowcase.validateScore(score);
    });
    test('validateScore(99) runs without error', () async {
      final score = 99;
      await asyncshowcase.validateScore(score);
    });
  });

  group('rangeList', () {
    test('rangeList(0, -1) throws RangeError', () async {
      final start = 0;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(0, -2) throws RangeError', () async {
      final start = 0;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(0, -10) throws RangeError', () async {
      final start = 0;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(1, -1) throws RangeError', () async {
      final start = 1;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(1, -2) throws RangeError', () async {
      final start = 1;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(1, -10) throws RangeError', () async {
      final start = 1;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-1, -1) throws RangeError', () async {
      final start = -1;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-1, -2) throws RangeError', () async {
      final start = -1;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-1, -10) throws RangeError', () async {
      final start = -1;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(2, -1) throws RangeError', () async {
      final start = 2;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(2, -2) throws RangeError', () async {
      final start = 2;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(2, -10) throws RangeError', () async {
      final start = 2;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-2, -1) throws RangeError', () async {
      final start = -2;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-2, -2) throws RangeError', () async {
      final start = -2;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-2, -10) throws RangeError', () async {
      final start = -2;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(10, -1) throws RangeError', () async {
      final start = 10;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(10, -2) throws RangeError', () async {
      final start = 10;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(10, -10) throws RangeError', () async {
      final start = 10;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-10, -1) throws RangeError', () async {
      final start = -10;
      final count = -1;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-10, -2) throws RangeError', () async {
      final start = -10;
      final count = -2;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(-10, -10) throws RangeError', () async {
      final start = -10;
      final count = -10;
      await expectLater(asyncshowcase.rangeList(start, count), throwsA(isA<RangeError>()));
    });
    test('rangeList(0, 0)', () async {
      final start = 0;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 1)', () async {
      final start = 0;
      final count = 1;
      final expected = [0];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 2)', () async {
      final start = 0;
      final count = 2;
      final expected = [0, 1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 10)', () async {
      final start = 0;
      final count = 10;
      final expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 0)', () async {
      final start = 1;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 1)', () async {
      final start = 1;
      final count = 1;
      final expected = [1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 2)', () async {
      final start = 1;
      final count = 2;
      final expected = [1, 2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 10)', () async {
      final start = 1;
      final count = 10;
      final expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 0)', () async {
      final start = -1;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 1)', () async {
      final start = -1;
      final count = 1;
      final expected = [-1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 2)', () async {
      final start = -1;
      final count = 2;
      final expected = [-1, 0];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 10)', () async {
      final start = -1;
      final count = 10;
      final expected = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 0)', () async {
      final start = 2;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 1)', () async {
      final start = 2;
      final count = 1;
      final expected = [2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 2)', () async {
      final start = 2;
      final count = 2;
      final expected = [2, 3];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 10)', () async {
      final start = 2;
      final count = 10;
      final expected = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 0)', () async {
      final start = -2;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 1)', () async {
      final start = -2;
      final count = 1;
      final expected = [-2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 2)', () async {
      final start = -2;
      final count = 2;
      final expected = [-2, -1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 10)', () async {
      final start = -2;
      final count = 10;
      final expected = [-2, -1, 0, 1, 2, 3, 4, 5, 6, 7];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
  });

  group('countdown', () {
    test('countdown(0)', () async {
      final from = 0;
      final expected = [0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(1)', () async {
      final from = 1;
      final expected = [1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-1)', () async {
      final from = -1;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(2)', () async {
      final from = 2;
      final expected = [2, 1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-2)', () async {
      final from = -2;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(10)', () async {
      final from = 10;
      final expected = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-10)', () async {
      final from = -10;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
  });

  group('tagScores', () {
    test('tagScores(\'\', 0)', () async {
      final tag = '';
      final base = 0;
      final expected = {'': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 1)', () async {
      final tag = '';
      final base = 1;
      final expected = {'': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -1)', () async {
      final tag = '';
      final base = -1;
      final expected = {'': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 2)', () async {
      final tag = '';
      final base = 2;
      final expected = {'': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -2)', () async {
      final tag = '';
      final base = -2;
      final expected = {'': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 10)', () async {
      final tag = '';
      final base = 10;
      final expected = {'': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -10)', () async {
      final tag = '';
      final base = -10;
      final expected = {'': -10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 0)', () async {
      final tag = 'hello';
      final base = 0;
      final expected = {'hello': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 1)', () async {
      final tag = 'hello';
      final base = 1;
      final expected = {'hello': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -1)', () async {
      final tag = 'hello';
      final base = -1;
      final expected = {'hello': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 2)', () async {
      final tag = 'hello';
      final base = 2;
      final expected = {'hello': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -2)', () async {
      final tag = 'hello';
      final base = -2;
      final expected = {'hello': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 10)', () async {
      final tag = 'hello';
      final base = 10;
      final expected = {'hello': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -10)', () async {
      final tag = 'hello';
      final base = -10;
      final expected = {'hello': -10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 0)', () async {
      final tag = '  ';
      final base = 0;
      final expected = {'  ': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 1)', () async {
      final tag = '  ';
      final base = 1;
      final expected = {'  ': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', -1)', () async {
      final tag = '  ';
      final base = -1;
      final expected = {'  ': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 2)', () async {
      final tag = '  ';
      final base = 2;
      final expected = {'  ': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', -2)', () async {
      final tag = '  ';
      final base = -2;
      final expected = {'  ': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 10)', () async {
      final tag = '  ';
      final base = 10;
      final expected = {'  ': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
  });

}
