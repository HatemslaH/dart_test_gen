import 'log_level.dart';
import 'rgb_color.dart';

/// Набор утилит с разным числом и типами аргументов и возвращаемых значений.
class DataToolbox {
  /// Уровень + код → строка (enum + int).
  String describe(LogLevel level, int code) {
    switch (level) {
      case LogLevel.trace:
        return 'trace:$code';
      case LogLevel.warning:
        return 'warn:$code';
      case LogLevel.fatal:
        return 'fatal:$code';
    }
  }

  /// Взвешенное среднее: список + double.
  double weightedMean(List<int> samples, double weight) {
    if (samples.isEmpty) return 0.0;
    final sum = samples.fold<int>(0, (a, b) => a + b);
    return sum * weight / samples.length;
  }

  /// Линейная смесь цветов, t в [0, 1].
  RgbColor blend(RgbColor a, RgbColor b, double t) {
    final tt = t.clamp(0.0, 1.0);
    int lerp(int x, int y) => (x * (1 - tt) + y * tt).round().clamp(0, 255);
    return RgbColor(lerp(a.r, b.r), lerp(a.g, b.g), lerp(a.b, b.b));
  }

  /// Добавляет [x] в конец, если такого значения ещё нет.
  List<int> appendIfMissing(List<int> items, int x) {
    if (items.contains(x)) return List<int>.from(items);
    return [...items, x];
  }

  /// Длины строк и сумма (String + String → Map).
  Map<String, int> measureStrings(String left, String right) {
    return {'a': left.length, 'b': right.length, 'sum': left.length + right.length};
  }

  /// Критичность по уровню логов.
  bool isUrgent(LogLevel level) => level == LogLevel.fatal;

  /// Без возвращаемого значения, один enum.
  void acknowledge(LogLevel level) {
    if (level == LogLevel.fatal) {
      throw StateError('fatal');
    }
  }
}
