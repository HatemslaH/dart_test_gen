enum ItemStatus { active, inactive }

class CustomItem {
  final int id;
  final String name;
  const CustomItem({required this.id, required this.name});

  @override
  String toString() => 'CustomItem(id: $id, name: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomItem && runtimeType == other.runtimeType && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

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

class OptionalTypes {
  int sumNullable(int? a, int? b) {
    return (a ?? 0) + (b ?? 0);
  }

  String greet(String name, [String? prefix]) {
    if (prefix != null) return '$prefix $name';
    return 'Hello $name';
  }

  int calculate(int x, {int y = 0, int? z}) {
    return x + y + (z ?? 0);
  }

  String formatStatus(ItemStatus status, {bool uppercase = false}) {
    final s = status.name;
    return uppercase ? s.toUpperCase() : s;
  }

  int processItem(CustomItem item, {int multiplier = 1}) {
    return item.id * multiplier;
  }

  AnotherClass getAnother(int i) {
    return AnotherClass('Title $i', i.toDouble());
  }

  int? findId(String name) {
    if (name == 'admin') return 1;
    if (name == 'guest') return 0;
    return null;
  }

  CustomItem? findItem(int id) {
    if (id == 1) return const CustomItem(id: 1, name: "Item 1");
    return null;
  }
}
