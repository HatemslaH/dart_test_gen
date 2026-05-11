/// Регрессии для геттеров, сеттеров и операторов в генераторе снимков.
class GettersSettersOperatorsShowcase {
  int _a;

  /// Публичное поле — для сериализации снимка при необходимости.
  final List<int> items;

  GettersSettersOperatorsShowcase({int a = 2})
      : _a = a,
        items = [10, 20, 30];

  int get aValue => _a;

  set aValue(int v) {
    if (v < -1000) throw StateError('too low');
    _a = v;
  }

  static int get defaultSeed => 42;

  int operator +(int n) => _a + n;

  int operator [](int index) =>
      items[index.clamp(0, items.length - 1)];

  void operator []=(int index, int value) {
    final i = index.clamp(0, items.length - 1).toInt();
    if (value < -500) throw ArgumentError('value');
    items[i] = value;
  }

  int operator ~() => ~_a;

  int operator -() => -_a;
}
