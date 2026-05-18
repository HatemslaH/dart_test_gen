enum SamplingStrategy {
  full, // all possible combinations
  random, // random selection of several combinations
  happyPath; // happy paths only (no exceptions)

  static SamplingStrategy fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'full' => SamplingStrategy.full,
      'random' => SamplingStrategy.random,
      'happy_path' || 'happypath' => SamplingStrategy.happyPath,
      _ => SamplingStrategy.full,
    };
  }
}
