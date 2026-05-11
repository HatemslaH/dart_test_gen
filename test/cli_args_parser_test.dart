import 'package:test/test.dart';
import 'package:dart_test_gen/generate_pipeline.dart';

void main() {
  group('parseCliArgs — all flags', () {
    test('parses every documented flag into the correct record field', () {
      final result = parseCliArgs([
        'lib/foo.dart',
        '--class', 'Foo',
        '-v',
        '--strategy', 'random',
        '--max-cases', '5',
        '--seed', '7',
        '--use-close-for-double',
        '--double-epsilon', '1e-6',
        '--config', 'cfg.yaml',
        '--keep-runner',
      ]);
      expect(result.inputs, ['lib/foo.dart']);
      expect(result.className, 'Foo');
      expect(result.verbose, isTrue);
      expect(result.strategy, 'random');
      expect(result.maxCases, 5);
      expect(result.seed, 7);
      expect(result.useCloseForDouble, isTrue);
      expect(result.doubleEpsilon, closeTo(1e-6, 1e-18));
      expect(result.configPath, 'cfg.yaml');
      expect(result.keepRunner, isTrue);
    });

    test('--verbose long form sets verbose = true', () {
      final result = parseCliArgs(['lib/foo.dart', '--verbose']);
      expect(result.verbose, isTrue);
    });
  });

  group('parseCliArgs — defaults when flags absent', () {
    test('optional fields are null or false when not provided', () {
      final result = parseCliArgs(['lib/foo.dart']);
      expect(result.inputs, ['lib/foo.dart']);
      expect(result.className, isNull);
      expect(result.verbose, isFalse);
      expect(result.strategy, isNull);
      expect(result.maxCases, isNull);
      expect(result.seed, isNull);
      expect(result.useCloseForDouble, isNull);
      expect(result.doubleEpsilon, isNull);
      expect(result.configPath, isNull);
      expect(result.keepRunner, isNull);
    });
  });

  group('parseCliArgs — multiple inputs', () {
    test('collects all non-flag args as inputs', () {
      final result = parseCliArgs(['lib/a.dart', 'lib/b.dart', 'lib/c.dart']);
      expect(result.inputs, ['lib/a.dart', 'lib/b.dart', 'lib/c.dart']);
    });

    test('inputs and flags can be interleaved', () {
      final result = parseCliArgs(['lib/a.dart', '--strategy', 'full', 'lib/b.dart']);
      expect(result.inputs, ['lib/a.dart', 'lib/b.dart']);
      expect(result.strategy, 'full');
    });
  });
}
