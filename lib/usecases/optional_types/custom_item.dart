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
