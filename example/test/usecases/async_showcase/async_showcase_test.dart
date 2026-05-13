import 'package:test/test.dart';
import 'package:example/usecases/async_showcase/async_showcase.dart';
import 'package:example/usecases/async_showcase/priority.dart';
import 'package:example/usecases/async_showcase/task_result.dart';

// Auto-generated — do not edit manually
// Generated: 2026-05-13T17:13:26.054791

void main() {
  final asyncshowcase = AsyncShowcase();

  group('computeScore', () {
    test('computeScore(0, Priority.low) returns 0', () async {
      final base = 0;
      final priority = Priority.low;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.normal) returns 1', () async {
      final base = 0;
      final priority = Priority.normal;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.high) returns 2', () async {
      final base = 0;
      final priority = Priority.high;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(0, Priority.critical) returns 3', () async {
      final base = 0;
      final priority = Priority.critical;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.low) returns 1', () async {
      final base = 1;
      final priority = Priority.low;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.normal) returns 2', () async {
      final base = 1;
      final priority = Priority.normal;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.high) returns 3', () async {
      final base = 1;
      final priority = Priority.high;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(1, Priority.critical) returns 4', () async {
      final base = 1;
      final priority = Priority.critical;
      final expected = 4;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.low) returns -1', () async {
      final base = -1;
      final priority = Priority.low;
      final expected = -1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.normal) returns 0', () async {
      final base = -1;
      final priority = Priority.normal;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.high) returns 1', () async {
      final base = -1;
      final priority = Priority.high;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-1, Priority.critical) returns 2', () async {
      final base = -1;
      final priority = Priority.critical;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.low) returns 2', () async {
      final base = 2;
      final priority = Priority.low;
      final expected = 2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.normal) returns 3', () async {
      final base = 2;
      final priority = Priority.normal;
      final expected = 3;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.high) returns 4', () async {
      final base = 2;
      final priority = Priority.high;
      final expected = 4;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(2, Priority.critical) returns 5', () async {
      final base = 2;
      final priority = Priority.critical;
      final expected = 5;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.low) returns -2', () async {
      final base = -2;
      final priority = Priority.low;
      final expected = -2;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.normal) returns -1', () async {
      final base = -2;
      final priority = Priority.normal;
      final expected = -1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.high) returns 0', () async {
      final base = -2;
      final priority = Priority.high;
      final expected = 0;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-2, Priority.critical) returns 1', () async {
      final base = -2;
      final priority = Priority.critical;
      final expected = 1;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(10, Priority.low) returns 10', () async {
      final base = 10;
      final priority = Priority.low;
      final expected = 10;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(10, Priority.normal) returns 11', () async {
      final base = 10;
      final priority = Priority.normal;
      final expected = 11;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(10, Priority.high) returns 12', () async {
      final base = 10;
      final priority = Priority.high;
      final expected = 12;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(10, Priority.critical) returns 13', () async {
      final base = 10;
      final priority = Priority.critical;
      final expected = 13;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-10, Priority.low) returns -10', () async {
      final base = -10;
      final priority = Priority.low;
      final expected = -10;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-10, Priority.normal) returns -9', () async {
      final base = -10;
      final priority = Priority.normal;
      final expected = -9;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-10, Priority.high) returns -8', () async {
      final base = -10;
      final priority = Priority.high;
      final expected = -8;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
    test('computeScore(-10, Priority.critical) returns -7', () async {
      final base = -10;
      final priority = Priority.critical;
      final expected = -7;
      final actual = await asyncshowcase.computeScore(base, priority);
      expect(actual, expected);
    });
  });

  group('isHighPriority', () {
    test('isHighPriority(Priority.low) returns false', () async {
      final priority = Priority.low;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, isFalse);
    });
    test('isHighPriority(Priority.normal) returns false', () async {
      final priority = Priority.normal;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, isFalse);
    });
    test('isHighPriority(Priority.high) returns true', () async {
      final priority = Priority.high;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, isTrue);
    });
    test('isHighPriority(Priority.critical) returns true', () async {
      final priority = Priority.critical;
      final actual = await asyncshowcase.isHighPriority(priority);
      expect(actual, isTrue);
    });
  });

  group('describeTask', () {
    test('describeTask(TaskResult(\'\', 0)) returns \':0\'', () async {
      final task = TaskResult('', 0);
      final expected = ':0';
      final actual = await asyncshowcase.describeTask(task);
      expect(actual, expected);
    });
    test('describeTask(TaskResult(\'test\', 255)) returns \'test:255\'', () async {
      final task = TaskResult('test', 255);
      final expected = 'test:255';
      final actual = await asyncshowcase.describeTask(task);
      expect(actual, expected);
    });
  });

  group('buildTask', () {
    test('buildTask(\'\', 0) returns TaskResult(\'\', 0)', () async {
      final title = '';
      final score = 0;
      final expected = TaskResult('', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 1) returns TaskResult(\'\', 1)', () async {
      final title = '';
      final score = 1;
      final expected = TaskResult('', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -1) returns TaskResult(\'\', -1)', () async {
      final title = '';
      final score = -1;
      final expected = TaskResult('', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 2) returns TaskResult(\'\', 2)', () async {
      final title = '';
      final score = 2;
      final expected = TaskResult('', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -2) returns TaskResult(\'\', -2)', () async {
      final title = '';
      final score = -2;
      final expected = TaskResult('', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', 10) returns TaskResult(\'\', 10)', () async {
      final title = '';
      final score = 10;
      final expected = TaskResult('', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'\', -10) returns TaskResult(\'\', -10)', () async {
      final title = '';
      final score = -10;
      final expected = TaskResult('', -10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 0) returns TaskResult(\'hello\', 0)', () async {
      final title = 'hello';
      final score = 0;
      final expected = TaskResult('hello', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 1) returns TaskResult(\'hello\', 1)', () async {
      final title = 'hello';
      final score = 1;
      final expected = TaskResult('hello', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -1) returns TaskResult(\'hello\', -1)', () async {
      final title = 'hello';
      final score = -1;
      final expected = TaskResult('hello', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 2) returns TaskResult(\'hello\', 2)', () async {
      final title = 'hello';
      final score = 2;
      final expected = TaskResult('hello', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -2) returns TaskResult(\'hello\', -2)', () async {
      final title = 'hello';
      final score = -2;
      final expected = TaskResult('hello', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', 10) returns TaskResult(\'hello\', 10)', () async {
      final title = 'hello';
      final score = 10;
      final expected = TaskResult('hello', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'hello\', -10) returns TaskResult(\'hello\', -10)', () async {
      final title = 'hello';
      final score = -10;
      final expected = TaskResult('hello', -10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 0) returns TaskResult(\'  \', 0)', () async {
      final title = '  ';
      final score = 0;
      final expected = TaskResult('  ', 0);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 1) returns TaskResult(\'  \', 1)', () async {
      final title = '  ';
      final score = 1;
      final expected = TaskResult('  ', 1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', -1) returns TaskResult(\'  \', -1)', () async {
      final title = '  ';
      final score = -1;
      final expected = TaskResult('  ', -1);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 2) returns TaskResult(\'  \', 2)', () async {
      final title = '  ';
      final score = 2;
      final expected = TaskResult('  ', 2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', -2) returns TaskResult(\'  \', -2)', () async {
      final title = '  ';
      final score = -2;
      final expected = TaskResult('  ', -2);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', 10) returns TaskResult(\'  \', 10)', () async {
      final title = '  ';
      final score = 10;
      final expected = TaskResult('  ', 10);
      final actual = await asyncshowcase.buildTask(title, score);
      expect(actual, expected);
    });
    test('buildTask(\'  \', -10) returns TaskResult(\'  \', -10)', () async {
      final title = '  ';
      final score = -10;
      final expected = TaskResult('  ', -10);
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
    test('rangeList(0, 0) returns []', () async {
      final start = 0;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 1) returns [0]', () async {
      final start = 0;
      final count = 1;
      final expected = [0];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 2) returns [0, 1]', () async {
      final start = 0;
      final count = 2;
      final expected = [0, 1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(0, 10) returns [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]', () async {
      final start = 0;
      final count = 10;
      final expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 0) returns []', () async {
      final start = 1;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 1) returns [1]', () async {
      final start = 1;
      final count = 1;
      final expected = [1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 2) returns [1, 2]', () async {
      final start = 1;
      final count = 2;
      final expected = [1, 2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(1, 10) returns [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]', () async {
      final start = 1;
      final count = 10;
      final expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 0) returns []', () async {
      final start = -1;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 1) returns [-1]', () async {
      final start = -1;
      final count = 1;
      final expected = [-1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 2) returns [-1, 0]', () async {
      final start = -1;
      final count = 2;
      final expected = [-1, 0];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-1, 10) returns [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8]', () async {
      final start = -1;
      final count = 10;
      final expected = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 0) returns []', () async {
      final start = 2;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 1) returns [2]', () async {
      final start = 2;
      final count = 1;
      final expected = [2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 2) returns [2, 3]', () async {
      final start = 2;
      final count = 2;
      final expected = [2, 3];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(2, 10) returns [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]', () async {
      final start = 2;
      final count = 10;
      final expected = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 0) returns []', () async {
      final start = -2;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 1) returns [-2]', () async {
      final start = -2;
      final count = 1;
      final expected = [-2];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 2) returns [-2, -1]', () async {
      final start = -2;
      final count = 2;
      final expected = [-2, -1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-2, 10) returns [-2, -1, 0, 1, 2, 3, 4, 5, 6, 7]', () async {
      final start = -2;
      final count = 10;
      final expected = [-2, -1, 0, 1, 2, 3, 4, 5, 6, 7];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(10, 0) returns []', () async {
      final start = 10;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(10, 1) returns [10]', () async {
      final start = 10;
      final count = 1;
      final expected = [10];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(10, 2) returns [10, 11]', () async {
      final start = 10;
      final count = 2;
      final expected = [10, 11];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(10, 10) returns [10, 11, 12, 13, 14, 15, 16, 17, 18, 19]', () async {
      final start = 10;
      final count = 10;
      final expected = [10, 11, 12, 13, 14, 15, 16, 17, 18, 19];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-10, 0) returns []', () async {
      final start = -10;
      final count = 0;
      final expected = [];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-10, 1) returns [-10]', () async {
      final start = -10;
      final count = 1;
      final expected = [-10];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-10, 2) returns [-10, -9]', () async {
      final start = -10;
      final count = 2;
      final expected = [-10, -9];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
    test('rangeList(-10, 10) returns [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1]', () async {
      final start = -10;
      final count = 10;
      final expected = [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1];
      final actual = await asyncshowcase.rangeList(start, count);
      expect(actual, expected);
    });
  });

  group('countdown', () {
    test('countdown(0) returns [0]', () async {
      final from = 0;
      final expected = [0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(1) returns [1, 0]', () async {
      final from = 1;
      final expected = [1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-1) returns []', () async {
      final from = -1;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(2) returns [2, 1, 0]', () async {
      final from = 2;
      final expected = [2, 1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-2) returns []', () async {
      final from = -2;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(10) returns [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]', () async {
      final from = 10;
      final expected = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
    test('countdown(-10) returns []', () async {
      final from = -10;
      final expected = [];
      final actual = await asyncshowcase.countdown(from).toList();
      expect(actual, expected);
    });
  });

  group('tagScores', () {
    test('tagScores(\'\', 0) returns {\'\': 0}', () async {
      final tag = '';
      final base = 0;
      final expected = {'': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 1) returns {\'\': 1}', () async {
      final tag = '';
      final base = 1;
      final expected = {'': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -1) returns {\'\': -1}', () async {
      final tag = '';
      final base = -1;
      final expected = {'': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 2) returns {\'\': 2}', () async {
      final tag = '';
      final base = 2;
      final expected = {'': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -2) returns {\'\': -2}', () async {
      final tag = '';
      final base = -2;
      final expected = {'': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', 10) returns {\'\': 10}', () async {
      final tag = '';
      final base = 10;
      final expected = {'': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'\', -10) returns {\'\': -10}', () async {
      final tag = '';
      final base = -10;
      final expected = {'': -10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 0) returns {\'hello\': 0}', () async {
      final tag = 'hello';
      final base = 0;
      final expected = {'hello': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 1) returns {\'hello\': 1}', () async {
      final tag = 'hello';
      final base = 1;
      final expected = {'hello': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -1) returns {\'hello\': -1}', () async {
      final tag = 'hello';
      final base = -1;
      final expected = {'hello': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 2) returns {\'hello\': 2}', () async {
      final tag = 'hello';
      final base = 2;
      final expected = {'hello': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -2) returns {\'hello\': -2}', () async {
      final tag = 'hello';
      final base = -2;
      final expected = {'hello': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', 10) returns {\'hello\': 10}', () async {
      final tag = 'hello';
      final base = 10;
      final expected = {'hello': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'hello\', -10) returns {\'hello\': -10}', () async {
      final tag = 'hello';
      final base = -10;
      final expected = {'hello': -10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 0) returns {\'  \': 0}', () async {
      final tag = '  ';
      final base = 0;
      final expected = {'  ': 0};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 1) returns {\'  \': 1}', () async {
      final tag = '  ';
      final base = 1;
      final expected = {'  ': 1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', -1) returns {\'  \': -1}', () async {
      final tag = '  ';
      final base = -1;
      final expected = {'  ': -1};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 2) returns {\'  \': 2}', () async {
      final tag = '  ';
      final base = 2;
      final expected = {'  ': 2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', -2) returns {\'  \': -2}', () async {
      final tag = '  ';
      final base = -2;
      final expected = {'  ': -2};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', 10) returns {\'  \': 10}', () async {
      final tag = '  ';
      final base = 10;
      final expected = {'  ': 10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
    test('tagScores(\'  \', -10) returns {\'  \': -10}', () async {
      final tag = '  ';
      final base = -10;
      final expected = {'  ': -10};
      final actual = await asyncshowcase.tagScores(tag, base);
      expect(actual, expected);
    });
  });

}
