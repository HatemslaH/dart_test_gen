import 'dart:math';
import 'gen_config.dart';
import 'test_generator.dart';

/// Returns mandatory rows + sampled optional rows.
List<TestCaseRow> sampleTestCases(
  List<TestCaseRow> rows,
  MethodConfig cfg,
) {
  final mandatory = rows.where((r) => r.throwsType != null).toList();
  final optional = rows.where((r) => r.throwsType == null).toList();

  final selected = switch (cfg.strategy) {
    SamplingStrategy.full => _truncate(optional, cfg.maxCases),
    SamplingStrategy.random => _randomSample(optional, cfg.maxCases, cfg.seed),
    SamplingStrategy.happyPath => optional.take(1).toList(),
  };

  return [...mandatory, ...selected];
}

List<TestCaseRow> _truncate(List<TestCaseRow> rows, int max) {
  if (rows.length <= max) return rows;
  return rows.take(max).toList();
}

List<TestCaseRow> _randomSample(List<TestCaseRow> rows, int max, int? seed) {
  if (rows.length <= max) return rows;

  final random = Random(seed);
  final indices = List.generate(rows.length, (i) => i);
  indices.shuffle(random);

  final selectedIndices = indices.take(max).toList()..sort();
  return selectedIndices.map((i) => rows[i]).toList();
}
