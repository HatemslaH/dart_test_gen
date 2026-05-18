import 'dart:math';

import 'package:dart_test_gen/src/domain/models/test_models.dart';

List<TestCaseRow> truncateOptionalRows(List<TestCaseRow> rows, int max) {
  if (rows.length <= max) return rows;
  return rows.take(max).toList();
}

List<TestCaseRow> randomSampleOptionalRows(List<TestCaseRow> rows, int max, int? seed) {
  if (rows.length <= max) return rows;

  final random = Random(seed);
  final indices = List.generate(rows.length, (i) => i);
  indices.shuffle(random);

  final selectedIndices = indices.take(max).toList()..sort();
  return selectedIndices.map((i) => rows[i]).toList();
}
