import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

const String cliHelpText = '''
dart_test_gen — snapshot-based unit test generator for Dart.

Usage:
  dart run dart_test_gen <path> [path ...] [options]

Arguments:
  <path>                       .dart file under lib/ or a directory under lib/.

Options:
  --class <Name>               pick a specific class (only when targets reduce to 1 file).
  -v, --verbose                verbose log to stderr; progress stays on stdout.
  --strategy <type>            case sampling strategy: full | random | happy_path.
  --max-cases <N>              max successful cases per method (default 200).
  --seed <N>                   seed for the random strategy.
  --use-close-for-double       use expect(actual, closeTo(expected, eps)) for scalar double.
  --double-epsilon <x>         absolute epsilon for closeTo (positive finite number).
  --config <path>              path to config file (default: dart_test_gen.yaml).
  --keep-runner                keep the temporary snapshot runner file on success.
  -h, --help                   show this help and exit.
  --version                    print the package version and exit.
''';

String resolveVersion() {
  try {
    final candidates = <String>[];
    final scriptPath = Platform.script.toFilePath();
    if (scriptPath.isNotEmpty) {
      candidates.add(p.normalize(p.join(p.dirname(scriptPath), '..', 'pubspec.yaml')));
      candidates.add(p.normalize(p.join(p.dirname(scriptPath), 'pubspec.yaml')));
    }
    candidates.add(p.normalize(p.join(Directory.current.path, 'pubspec.yaml')));
    for (final c in candidates) {
      final f = File(c);
      if (!f.existsSync()) continue;
      final yaml = loadYaml(f.readAsStringSync());
      if (yaml is YamlMap) {
        final v = yaml['version'];
        if (v is String && v.trim().isNotEmpty) return v.trim();
      }
    }
  } catch (_) {}
  return 'unknown';
}

/// Returns `true` if an early-exit flag was handled (caller should return).
bool handleEarlyExitFlags(List<String> args) {
  for (final a in args) {
    if (a == '--help' || a == '-h') {
      stdout.write(cliHelpText);
      return true;
    }
    if (a == '--version') {
      stdout.writeln(resolveVersion());
      return true;
    }
  }
  return false;
}
