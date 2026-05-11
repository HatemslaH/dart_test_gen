import 'counter_label.dart';
import 'name_tag.dart';

/// Песочница для пункта дорожной карты TODO 4: коллекции и обобщения.
///
/// Параметры `Iterable<int>`, `Set<int>`, `List<String>` получают компактные граничные литералы
/// (см. `ParamType` в `test_generator.dart`). Возвраты коллекций с примитивами или с **типами из
/// merge** (`NameTag`, `CounterLabel`) кодируются снимком рекурсивно (`snapshot.dart` /
/// `dartLiteralFromJson`).
class TypeExtensionsShowcase {
  /// Поддерживаемый кейс: гарантирует непустую генерацию для этого класса.
  int baseline(int a, int b) => a + b;

  /// Пользовательские типы из объединённых по зависимостям библиотек (как [RgbColor] в data_toolbox).
  CounterLabel heavier(CounterLabel x, CounterLabel y) => x.count >= y.count ? x : y;

  NameTag longerName(NameTag a, NameTag b) => a.name.length >= b.name.length ? a : b;

  /// Возврат [Iterable<int>] (рантайм — тот же [List], чтобы `expect` совпадал с литералом списка).
  Iterable<int> pairAsIterable(int a, int b) => <int>[a, b];

  /// Возврат [Set<int>] — снимок кодирует как список, в тесте — литерал множества.
  Set<int> uniquePair(int a, int b) => {a, b};

  /// Возврат [List<String>] — граничные строки в аргументах; ожидание в тесте — список литералов.
  List<String> pairStrings(String x, String y) => [x, y];

  /// Возврат [List] с элементами [NameTag] — снимок сериализует каждый элемент как объект с `_type`.
  List<NameTag> pairNameTags(String x, String y) => [NameTag(x), NameTag(y)];

  /// Возврат [Set] с элементами [NameTag]; при одинаковых строках множество из одного элемента.
  Set<NameTag> uniqueNameTagSet(String x, String y) => {NameTag(x), NameTag(y)};

  /// Возврат [Iterable] с элементами [NameTag] (рантайм — [List], как для `pairAsIterable`).
  Iterable<NameTag> pairNameTagsIterable(String x, String y) => <NameTag>[NameTag(x), NameTag(y)];

  /// Возврат [Map] со значениями [NameTag]; ключи фиксированы для стабильного снимка.
  Map<String, NameTag> pairNameTagMap(String x, String y) => {'first': NameTag(x), 'second': NameTag(y)};

  /// Возврат [List] с элементами [CounterLabel]; аргументы — граничные `int` из генератора.
  List<CounterLabel> pairCounterLabels(int a, int b) => [CounterLabel(a, ''), CounterLabel(b, 'test')];

  /// Сумма элементов; аргумент — [Iterable<int>] с граничными литералами.
  int sumIterable(Iterable<int> items) => items.fold<int>(0, (a, b) => a + b);

  /// Сумма элементов; аргумент — [Set<int>] с граничными литералами.
  int sumFromSet(Set<int> items) => items.fold<int>(0, (a, b) => a + b);

  /// Длина первой строки; аргумент — [List<String>] с граничными литералами (в т.ч. `[]` → `0`).
  int firstLength(List<String> rows) => rows.isEmpty ? 0 : rows.first.length;
}
