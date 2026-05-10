class TaskResult {
  final String title;
  final int score;

  const TaskResult(this.title, this.score);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskResult && other.title == title && other.score == score;

  @override
  int get hashCode => Object.hash(title, score);
}
