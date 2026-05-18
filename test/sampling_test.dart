import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:test/test.dart';

TestCaseRow _opt(String label) => TestCaseRow(argLiterals: [label]);
TestCaseRow _mandatory(String label) => TestCaseRow(argLiterals: [label], throwsType: 'Exception');

void main() {
  group('sampleTestCases — full strategy', () {
    test('truncates optional rows to maxCases', () {
      final rows = List.generate(10, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.full, maxCases: 3);
      final result = sampleTestCases(rows, cfg);
      expect(result, hasLength(3));
      expect(result.map((r) => r.argLiterals.first), ['opt0', 'opt1', 'opt2']);
    });

    test('keeps all rows when count <= maxCases', () {
      final rows = List.generate(3, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.full, maxCases: 10);
      expect(sampleTestCases(rows, cfg), hasLength(3));
    });
  });

  group('sampleTestCases — random strategy', () {
    test('result size equals maxCases when input is larger', () {
      final rows = List.generate(20, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.random, maxCases: 5, seed: 42);
      expect(sampleTestCases(rows, cfg), hasLength(5));
    });

    test('deterministic with same seed', () {
      final rows = List.generate(20, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.random, maxCases: 5, seed: 99);
      final first = sampleTestCases(rows, cfg);
      final second = sampleTestCases(rows, cfg);
      expect(
        first.map((r) => r.argLiterals.first),
        second.map((r) => r.argLiterals.first),
      );
    });

    test('keeps all when count <= maxCases', () {
      final rows = List.generate(3, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.random, maxCases: 10, seed: 1);
      expect(sampleTestCases(rows, cfg), hasLength(3));
    });
  });

  group('sampleTestCases — happy_path strategy', () {
    test('keeps exactly 1 optional row', () {
      final rows = List.generate(5, (i) => _opt('opt$i'));
      final cfg = const MethodConfig(strategy: SamplingStrategy.happyPath, maxCases: 200);
      final result = sampleTestCases(rows, cfg);
      expect(result, hasLength(1));
    });

    test('keeps all mandatory rows plus 1 optional', () {
      final rows = [
        _mandatory('throws0'),
        _mandatory('throws1'),
        _opt('opt0'),
        _opt('opt1'),
        _opt('opt2'),
      ];
      final cfg = const MethodConfig(strategy: SamplingStrategy.happyPath, maxCases: 200);
      final result = sampleTestCases(rows, cfg);
      expect(result.where((r) => r.throwsType != null), hasLength(2));
      expect(result.where((r) => r.throwsType == null), hasLength(1));
    });
  });

  group('sampleTestCases — mandatory/optional split', () {
    test('mandatory rows always appear first', () {
      final rows = [_opt('a'), _mandatory('b'), _opt('c'), _mandatory('d')];
      final cfg = const MethodConfig(strategy: SamplingStrategy.full, maxCases: 200);
      final result = sampleTestCases(rows, cfg);
      // mandatory rows come before optional rows
      final mandatoryIndices =
          result.asMap().entries.where((e) => e.value.throwsType != null).map((e) => e.key).toList();
      final optionalIndices =
          result.asMap().entries.where((e) => e.value.throwsType == null).map((e) => e.key).toList();
      if (mandatoryIndices.isNotEmpty && optionalIndices.isNotEmpty) {
        expect(mandatoryIndices.last < optionalIndices.first, isTrue);
      }
    });

    test('all mandatory rows preserved regardless of maxCases', () {
      final rows = [
        _mandatory('m0'),
        _mandatory('m1'),
        ...List.generate(10, (i) => _opt('opt$i')),
      ];
      final cfg = const MethodConfig(strategy: SamplingStrategy.full, maxCases: 1);
      final result = sampleTestCases(rows, cfg);
      expect(result.where((r) => r.throwsType != null), hasLength(2));
    });
  });
}
