class Calculator {
  /// Умножает два числа
  int mul(int a, int b) => a * b;

  /// Складывает два числа
  int add(int a, int b) => a + b;

  /// Вычитает b из a
  int sub(int a, int b) => a - b;

  /// Делит a на b. Бросает ArgumentError если b == 0
  double divide(int a, int b) {
    if (b == 0) throw ArgumentError('Division by zero');
    return a / b;
  }

  /// Целочисленное деление
  int intDivide(int a, int b) {
    if (b == 0) throw ArgumentError('Division by zero');
    return a ~/ b;
  }

  /// Остаток от деления
  int mod(int a, int b) {
    if (b == 0) throw ArgumentError('Modulo by zero');
    return a % b;
  }

  /// Возводит base в степень exp (exp >= 0)
  int pow(int base, int exp) {
    if (exp < 0) throw ArgumentError('Negative exponent not supported');
    int result = 1;
    for (int i = 0; i < exp; i++) {
      result *= base;
    }
    return result;
  }

  /// Абсолютное значение числа
  int abs(int a) => a < 0 ? -a : a;

  /// Максимум из двух чисел
  int max(int a, int b) => a > b ? a : b;

  /// Минимум из двух чисел
  int min(int a, int b) => a < b ? a : b;

  /// Проверяет, является ли число чётным
  bool isEven(int a) => a % 2 == 0;

  /// Проверяет, является ли число нечётным
  bool isOdd(int a) => a % 2 != 0;

  /// Вычисляет факториал числа n (n >= 0)
  int factorial(int n) {
    if (n < 0) throw ArgumentError('Factorial of negative number');
    if (n == 0 || n == 1) return 1;
    return n * factorial(n - 1);
  }

  /// Зажимает значение в диапазон [min, max]
  int clamp(int value, int min, int max) {
    if (min > max) throw ArgumentError('min must be <= max');
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}
