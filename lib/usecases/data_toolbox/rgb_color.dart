/// RGB без alpha — для методов с пользовательским типом.
class RgbColor {
  final int r;
  final int g;
  final int b;

  const RgbColor(this.r, this.g, this.b);

  @override
  bool operator ==(Object other) => other is RgbColor && other.r == r && other.g == g && other.b == b;

  @override
  int get hashCode => Object.hash(r, g, b);
}
