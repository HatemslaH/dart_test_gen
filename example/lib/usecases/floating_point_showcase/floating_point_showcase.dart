/// Демонстрация опциональных сравнений `double` через `closeTo` при регенерации тестов.
class FloatingPointShowcase {
  /// Накопление `0.1` в цикле — типичный источник ошибок точности.
  double sumTenths(int iterations) {
    var x = 0.0;
    for (var i = 0; i < iterations; i++) {
      x += 0.1;
    }
    return x;
  }

  /// Линейная интерполяция (без деления на граничных `double` из снимка).
  double slideToward(double from, double toward, double t) {
    return from + (toward - from) * t;
  }

  /// Асинхронный `double` (снимок с `await`).
  Future<double> asyncSum(double x, double y) async {
    await Future<void>.delayed(Duration.zero);
    return x + y;
  }
}
