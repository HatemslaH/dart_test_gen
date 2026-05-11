/// Нагрузочный файл для dart_test_gen.
/// Каждый метод намеренно содержит нетривиальную логику:
/// скрытые константы, граничные ветки, побочные эффекты на состояние,
/// рекурсию, работу со строками и коллекциями.
class StressShowcase {
  // Внутреннее состояние — влияет на результаты методов
  int _callCount = 0;
  final List<String> _history = [];

  // ─────────────────────────────────────────────
  // 1. Арифметика со скрытой константой и особым случаем нуля
  //
  // Выглядит как простое деление, но:
  //   • делитель 0 → возвращает -1 (не бросает)
  //   • результат всегда смещён на +7 (магическая константа)
  //   • целочисленное деление, не double
  // Генератор, скорее всего, выведет ожидание divide(10, 2) == 5,
  // тогда как реальный результат == 12.
  // ─────────────────────────────────────────────
  int divide(int a, int b) {
    if (b == 0) return -1;
    return (a ~/ b) + 7;
  }

  // ─────────────────────────────────────────────
  // 2. Нормализация строки: цепочка трансформаций
  //
  // Сложность:
  //   • trim → lowercase → убрать все пробелы внутри
  //   • если после этого пустая строка → вернуть "__empty__"
  //   • если длина > 10 → обрезать до 10 символов + добавить "…"
  //   • каждый вызов инкрементирует _callCount (побочный эффект)
  // Снимок поймает результат, но не заметит побочный эффект на _callCount.
  // ─────────────────────────────────────────────
  String normalize(String input) {
    _callCount++;
    final trimmed = input.trim().toLowerCase().replaceAll(' ', '');
    if (trimmed.isEmpty) return '__empty__';
    if (trimmed.length > 10) return '${trimmed.substring(0, 10)}…';
    return trimmed;
  }

  // ─────────────────────────────────────────────
  // 3. Обработка списка: фильтр + трансформация + агрегация
  //
  // Сложность:
  //   • убрать дубли (через Set), затем отсортировать
  //   • отфильтровать чётные
  //   • умножить каждый на его индекс в результирующем списке (не в исходном)
  //   • если список пуст → вернуть [0]
  // Порядок операций критичен; перестановка даст другой результат.
  // ─────────────────────────────────────────────
  List<int> processInts(List<int> values) {
    if (values.isEmpty) return [0];
    final unique = values.toSet().toList()..sort();
    final odds = unique.where((x) => x.isOdd).toList();
    if (odds.isEmpty) return [0];
    return List.generate(odds.length, (i) => odds[i] * i);
  }

  // ─────────────────────────────────────────────
  // 4. Рекурсия с мемоизацией на инстансе
  //
  // Числа Трибоначчи (не Фибоначчи!): T(n) = T(n-1) + T(n-2) + T(n-3)
  // Базовые случаи: T(0)=0, T(1)=1, T(2)=1.
  // Кэш хранится в _history (как строки) — это намеренно странное решение,
  // которое делает повторные вызовы быстрее, но связывает состояние объекта.
  //
  // Генератор не знает про Трибоначчи, снимок зафиксирует правильные числа,
  // но при этом не заметит что _history мутируется.
  // ─────────────────────────────────────────────
  int tribonacci(int n) {
    if (n < 0) throw ArgumentError('n must be >= 0, got $n');
    if (n == 0) return 0;
    if (n == 1 || n == 2) return 1;

    final cacheKey = 'trib_$n';
    final cached = _history.where((e) => e.startsWith(cacheKey)).firstOrNull;
    if (cached != null) {
      return int.parse(cached.split('=').last);
    }

    final result = tribonacci(n - 1) + tribonacci(n - 2) + tribonacci(n - 3);
    _history.add('$cacheKey=$result');
    return result;
  }

  // ─────────────────────────────────────────────
  // 5. Кодирование строки: Run-Length Encoding
  //
  // "aaabbc" → "a3b2c1"
  // Сложность:
  //   • пустая строка → ""
  //   • одиночные символы всё равно получают суффикс "1"
  //   • регистр сохраняется ("AAAaaa" → "A3a3")
  //   • unicode: один кодпоинт — один символ (emoji считается как 1)
  //
  // Граничный кейс с emoji ("😀😀😀b") скорее всего сломает наивный
  // генератор, который итерирует по code units, а не code points.
  // ─────────────────────────────────────────────
  String runLengthEncode(String s) {
    if (s.isEmpty) return '';
    final buffer = StringBuffer();
    final runes = s.runes.toList();
    int i = 0;
    while (i < runes.length) {
      final current = runes[i];
      int count = 1;
      while (i + count < runes.length && runes[i + count] == current) {
        count++;
      }
      buffer.write(String.fromCharCode(current));
      buffer.write(count);
      i += count;
    }
    return buffer.toString();
  }

  /// Вспомогательный геттер — сколько раз вызывался normalize().
  /// Генератор (пока) не умеет тестировать геттеры.
  int get callCount => _callCount;
}
