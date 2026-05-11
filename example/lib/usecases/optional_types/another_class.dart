class AnotherClass {
  final String title;
  final double score;
  const AnotherClass(this.title, this.score);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnotherClass && runtimeType == other.runtimeType && title == other.title && score == other.score;

  @override
  int get hashCode => title.hashCode ^ score.hashCode;
}
