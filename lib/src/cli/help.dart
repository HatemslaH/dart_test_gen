const String cliHelpText = '''
dart_test_gen — snapshot-based unit test generator for Dart.

Usage:
  dart run dart_test_gen <path> [path ...] [options]

Arguments:
  <path>                           .dart file under lib/ or a directory under lib/.

Options:
  --class <Name>                   pick a specific class (only when targets reduce to 1 file).
  -v, --verbose                    verbose log to stderr; progress stays on stdout.
  --strategy <type>                case sampling strategy: full | random | happy_path.
  --max-cases <N>                  max successful cases per method (default 200).
  --seed <N>                       seed for the random strategy.
  --use-close-for-double           use expect(actual, closeTo(expected, eps)) for scalar double.
  --double-epsilon <x>             absolute epsilon for closeTo (positive finite number).
  --expect-matchers-bool-null      emit isTrue / isFalse / isNull for bool and null literals
                                   (default on; overrides YAML).
  --no-expect-matchers-bool-null   emit final expected + expect(actual, expected) for those
                                   literals.
  --config <path>                  path to config file (default: dart_test_gen.yaml).
  --keep-runner                    keep the temporary snapshot runner file on success.
  --dry-run                        run the full pipeline but do not write any test files;
                                   prints the would-be output paths to stdout.
  --check                          run the full pipeline but compare generated content to
                                   existing files instead of writing; exits 1 if any differ.
  -h, --help                       show this help and exit.
  --version                        print the package version and exit.
''';
