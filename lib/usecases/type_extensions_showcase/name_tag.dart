/// Второй пользовательский тип для сигнатур с несколькими value-объектами.
class NameTag {
  final String name;

  const NameTag(this.name);

  @override
  bool operator ==(Object other) => other is NameTag && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
