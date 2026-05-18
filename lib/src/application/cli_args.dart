import 'dart:io';

import 'package:dart_test_gen/cli/cli_log.dart';

final class CliArgs {
  CliArgs();

  /// Parses CLI arguments: paths, `--class`, `-v`/`--verbose`, sampling flags, and mode flags.
  static ({
    List<String> inputs,
    String? className,
    bool verbose,
    String? strategy,
    int? maxCases,
    int? seed,
    String? configPath,
    bool? useCloseForDouble,
    double? doubleEpsilon,
    bool? useExpectMatchersBoolNull,
    bool? keepRunner,
    bool? dryRun,
    bool? check,
  }) parseCliArgs(List<String> args) {
    String? className;
    var verbose = false;
    String? strategy;
    int? maxCases;
    int? seed;
    String? configPath;
    bool? useCloseForDouble;
    double? doubleEpsilon;
    bool? useExpectMatchersBoolNull;
    bool? keepRunner;
    bool? dryRun;
    bool? check;

    final rest = <String>[];
    for (var i = 0; i < args.length; i++) {
      final a = args[i];
      if (a == '--class' && i + 1 < args.length) {
        className = args[++i];
      } else if (a == '-v' || a == '--verbose') {
        verbose = true;
      } else if (a == '--strategy' && i + 1 < args.length) {
        strategy = args[++i];
      } else if (a == '--max-cases' && i + 1 < args.length) {
        maxCases = int.tryParse(args[++i]);
      } else if (a == '--seed' && i + 1 < args.length) {
        seed = int.tryParse(args[++i]);
      } else if (a == '--config' && i + 1 < args.length) {
        configPath = args[++i];
      } else if (a == '--use-close-for-double') {
        useCloseForDouble = true;
      } else if (a == '--expect-matchers-bool-null') {
        // If both `--expect-matchers-bool-null` and `--no-expect-matchers-bool-null`
        // appear, the last one on the command line wins.
        useExpectMatchersBoolNull = true;
      } else if (a == '--no-expect-matchers-bool-null') {
        useExpectMatchersBoolNull = false;
      } else if (a == '--keep-runner') {
        keepRunner = true;
      } else if (a == '--dry-run') {
        dryRun = true;
      } else if (a == '--check') {
        check = true;
      } else if (a == '--double-epsilon' && i + 1 < args.length) {
        final raw = args[++i];
        final parsed = double.tryParse(raw);
        if (parsed == null || !parsed.isFinite || parsed <= 0) {
          CliLog.err('--double-epsilon: expected a finite number > 0, got: $raw');
          exit(64);
        }
        doubleEpsilon = parsed;
      } else {
        rest.add(a);
      }
    }
    if (rest.isEmpty) {
      CliLog.err(
        'Usage: dart run dart_test_gen <path> [path …] [options]\n'
        'Options:\n'
        '  --class <Name>                  only when targets reduce to a single .dart file after filtering.\n'
        '  -v, --verbose                   verbose log to stderr; progress stays on stdout.\n'
        '  --strategy <type>               case sampling strategy: full, random, happy_path.\n'
        '  --max-cases <N>                 max successful cases per method (default 200).\n'
        '  --seed <N>                      seed for the random strategy.\n'
        '  --use-close-for-double          for `double`: emit expect(..., closeTo(...)).\n'
        '  --double-epsilon <x>            absolute epsilon for closeTo (overrides YAML).\n'
        '  --expect-matchers-bool-null     for bool/null: isTrue, isFalse, isNull (overrides YAML).\n'
        '  --no-expect-matchers-bool-null  classic final expected + expect(actual, expected).\n'
        '  --config <path>                 path to config file (default: dart_test_gen.yaml).',
      );
      exit(64);
    }
    return (
      inputs: rest,
      className: className,
      verbose: verbose,
      strategy: strategy,
      maxCases: maxCases,
      seed: seed,
      configPath: configPath,
      useCloseForDouble: useCloseForDouble,
      doubleEpsilon: doubleEpsilon,
      useExpectMatchersBoolNull: useExpectMatchersBoolNull,
      keepRunner: keepRunner,
      dryRun: dryRun,
      check: check,
    );
  }
}
