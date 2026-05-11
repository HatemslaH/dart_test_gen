/// Простой тип из отдельного файла — попадает в снимок через merge зависимостей.
class CounterLabel {
  final int count;
  final String label;

  const CounterLabel(this.count, this.label);

  @override
  bool operator ==(Object other) =>
      other is CounterLabel && other.count == count && other.label == label;

  @override
  int get hashCode => Object.hash(count, label);
}
