class ExceptionThrowsShowcase {
  int needPositive(int x) {
    if (x <= 0) throw Exception('non-positive');
    return x;
  }

  int needNonZero(int x) {
    if (x == 0) throw ArgumentError.value(x, 'x', 'must be non-zero');
    return x;
  }

  String requireOpen(bool open) {
    if (!open) throw StateError('closed');
    return 'open';
  }

  int parseHex(String s) {
    return int.parse(s, radix: 16);
  }

  int requireEven(int x) {
    if (x.isOdd) throw AssertionError('odd');
    return x;
  }
}
