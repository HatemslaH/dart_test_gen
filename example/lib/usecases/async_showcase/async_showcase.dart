import 'priority.dart';
import 'task_result.dart';

class AsyncShowcase {
  Future<int> computeScore(int base, Priority priority) async {
    return base + priority.index;
  }

  Future<bool> isHighPriority(Priority priority) async {
    return priority == Priority.high || priority == Priority.critical;
  }

  Future<String> describeTask(TaskResult task) async {
    return '${task.title}:${task.score}';
  }

  Future<TaskResult> buildTask(String title, int score) async {
    return TaskResult(title, score);
  }

  Future<void> validateScore(int score) async {
    if (score < 0 || score > 100) {
      throw RangeError.range(score, 0, 100);
    }
  }

  Future<List<int>> rangeList(int start, int count) async {
    return List.generate(count, (i) => start + i);
  }

  Stream<int> countdown(int from) async* {
    for (var i = from; i >= 0; i--) {
      yield i;
    }
  }

  Future<Map<String, int>> tagScores(String tag, int base) async {
    return {tag: base};
  }
}
