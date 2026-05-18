# Project Structure

- `.\lib\cli\cli.dart`
- `.\lib\cli\cli_help.dart`
- `.\lib\cli\cli_log.dart`
- `.\lib\cli\cli_progress.dart`
- `.\lib\generate_pipeline.dart`
- `.\lib\gen_config.dart`
- `.\lib\resolved_dependencies.dart`
- `.\lib\sampling.dart`
- `.\lib\snapshot.dart`
- `.\lib\source_parser.dart`
- `.\lib\src\application\cli_args.dart`
- `.\lib\src\application\cli_generation_orchestrator.dart`
- `.\lib\src\application\dynamic_input_generator.dart`
- `.\lib\src\application\generation_isolate.dart`
- `.\lib\src\application\generation_single_library.dart`
- `.\lib\src\application\method_logic_analyzer.dart`
- `.\lib\src\application\snapshot_failure_formatting.dart`
- `.\lib\src\application\snapshot_unit_test_generation.dart`
- `.\lib\src\domain\check_failure.dart`
- `.\lib\src\domain\generator_module.dart`
- `.\lib\src\domain\logic_profile.dart`
- `.\lib\src\generators\snapshot_unit_test_generator_module.dart`
- `.\lib\src\infrastructure\io_generation_filesystem.dart`
- `.\lib\src\ports\generation_filesystem.dart`
- `.\lib\src\README.md`
- `.\lib\src\wiring\app_dependencies.dart`
- `.\lib\test_generator.dart`

---

## Файл: .\lib\cli\cli.dart

```dart
export 'cli_help.dart';
export 'cli_log.dart';
export 'cli_progress.dart';

```

## Файл: .\lib\cli\cli_help.dart

```dart
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

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

```

## Файл: .\lib\cli\cli_log.dart

```dart
import 'dart:io';

/// Logging via [Stdout]/[Stderr].[write], without [print].
abstract final class CliLog {
  static void out(String message) => stdout.write('$message\n');

  static void outRaw(String chunk) => stdout.write(chunk);

  static void err(String message) => stderr.write('$message\n');
}

```

## Файл: .\lib\cli\cli_progress.dart

```dart
import 'dart:io';

import 'package:path/path.dart' as p;

/// Progress 0–100% for a set of files: composite `\r`-line or ANSI block of lines.
final class GenerationProgressUi {
  GenerationProgressUi._({
    required this.labels,
    required this.useAnsiBlock,
    required this.labelWidth,
  }) : _pct = {for (final l in labels) l: 0.0};

  final List<String> labels;
  final Map<String, double> _pct;
  final bool useAnsiBlock;
  final int labelWidth;
  var _dirty = false;
  var _blockWritten = false;

  static const _barW = 22;

  factory GenerationProgressUi.create(Iterable<String> displayLabels) {
    final labels = displayLabels.toList()..sort();
    final baseNames = labels.map(p.basename).toList();
    final useAnsi =
        stdout.hasTerminal && (stdout.supportsAnsiEscapes || _windowsVt());
    final w = baseNames.isEmpty
        ? 14
        : baseNames.map((s) => s.length).reduce((a, b) => a > b ? a : b).clamp(8, 28).toInt();
    final ui = GenerationProgressUi._(
      labels: labels,
      useAnsiBlock: useAnsi,
      labelWidth: w,
    );
    ui.drawInitial();
    return ui;
  }

  /// Draws the initial frame immediately (all at 0%).
  void drawInitial() => _redraw();

  static bool _windowsVt() {
    if (!Platform.isWindows) return false;
    return Platform.environment['WT_SESSION'] != null ||
        Platform.environment['TERM'] == 'xterm' ||
        Platform.environment['ANSICON'] != null;
  }

  void setPercent(String label, double percent) {
    if (!labels.contains(label)) return;
    final pv = percent.clamp(0.0, 100.0).toDouble();
    if (_pct[label] != pv) {
      _pct[label] = pv;
      _redraw();
    }
  }

  void _redraw() {
    _dirty = true;
    if (useAnsiBlock) {
      _redrawAnsiBlock();
    } else {
      _redrawSingleCompositeLine();
    }
    // stdout.flush();
  }

  void _redrawAnsiBlock() {
    final n = labels.length;
    if (n == 0) return;
    final buf = StringBuffer();
    if (_blockWritten) {
      buf.write('\x1B[${n}A');
    }
    _blockWritten = true;
    for (final lab in labels) {
      buf.write('\x1B[2K\r');
      buf.writeln(_formatLine(lab, _pct[lab] ?? 0));
    }
    stdout.write(buf.toString());
  }

  void _redrawSingleCompositeLine() {
    final parts = <String>[];
    for (final lab in labels) {
      parts.add(_compactSegment(lab, _pct[lab] ?? 0));
    }
    var line = parts.join(' | ');
    final cols = stdout.hasTerminal ? stdout.terminalColumns : null;
    if (cols != null && cols > 16 && line.length > cols - 1) {
      line = '${line.substring(0, cols - 4)} …';
    }
    stdout.write('\r\x1B[K$line');
  }

  String _compactSegment(String label, double pct) {
    final base = p.basename(label);
    final name = base.length > 20 ? '${base.substring(0, 18)}..' : base;
    final filled = (pct / 100 * _barW).round().clamp(0, _barW);
    final bar = '${'#' * filled}${'-' * (_barW - filled)}';
    return '$name [$bar] ${pct.toStringAsFixed(0)}%';
  }

  String _formatLine(String label, double pct) {
    final base = p.basename(label);
    final trimmed = base.length > labelWidth ? '${base.substring(0, labelWidth - 2)}..' : base;
    final pad = trimmed.padRight(labelWidth);
    final filled = (pct / 100 * _barW).round().clamp(0, _barW);
    final bar = '${'#' * filled}${'-' * (_barW - filled)}';
    return '$pad  [$bar] ${pct.toStringAsFixed(0)}%';
  }

  void finish() {
    if (_dirty) {
      stdout.write('\n');
      // stdout.flush();
    }
    _blockWritten = false;
    _dirty = false;
  }
}

```

## Файл: .\lib\generate_pipeline.dart

```dart
import 'package:dart_test_gen/gen_config.dart';

import 'src/application/cli_generation_orchestrator.dart';
import 'src/application/generation_single_library.dart' as gen_single;
import 'src/application/snapshot_unit_test_generation.dart' as snap;
import 'src/domain/check_failure.dart';
import 'src/domain/generator_module.dart';
import 'src/generators/snapshot_unit_test_generator_module.dart';
import 'src/infrastructure/io_generation_filesystem.dart';
import 'src/ports/generation_filesystem.dart';
import 'src/wiring/app_dependencies.dart';

export 'src/application/cli_args.dart' show parseCliArgs;
export 'src/application/generation_isolate.dart'
    show generationIsolateMain, generationIsolateSpawnMessage, isolateDoneSentinel, isolateResultPrefix;
export 'src/application/snapshot_failure_formatting.dart' show formatSnapshotRunnerFailure;
export 'src/domain/check_failure.dart' show CheckFailure;
export 'src/domain/generator_module.dart'
    show
        EmitGenerationUi,
        GeneratorModule,
        GeneratorRunCheckMismatch,
        GeneratorRunContext,
        GeneratorRunOutcome,
        GeneratorRunSkipped,
        GeneratorRunSuccess,
        kDefaultGeneratorModuleId;

final class GeneratePipeline {
  GeneratePipeline();

  /// All `.dart` files under [dirAbs] (recursive), using the default I/O filesystem.
  static List<String> dartFilesUnderDirectory(String dirAbs) =>
      IoGenerationFilesystem().dartFilesUnderDirectory(dirAbs);

  /// Expands files and directories into a sorted list of absolute `.dart` paths (default I/O).
  static List<String> expandGenerationTargets(String cwd, List<String> inputs) =>
      snap.expandGenerationTargetsWithFs(IoGenerationFilesystem(), cwd, inputs);

  /// `lib/a/b.dart` → `test/a/b_test.dart`
  static String testOutputPathForLib(String packageRoot, String absoluteLibPath) =>
      snap.testOutputPathForLib(packageRoot, absoluteLibPath);

  static String shortLibLabel(String absoluteLibPath, String packageRoot) =>
      snap.shortLibLabel(absoluteLibPath, packageRoot);

  /// Runs generation for a single library file.
  ///
  /// Uses [filesystem] / [generator] when provided; otherwise default I/O and the
  /// built-in snapshot unit-test module.
  static Future<CheckFailure?> generateSingleLibraryFile({
    required String absoluteLibPath,
    required String packageRoot,
    required String packageName,
    required String? className,
    required String displayLabel,
    required bool verbose,
    required GeneratorConfig config,
    required EmitGenerationUi emit,
    GenerationFilesystem? filesystem,
    GeneratorModule? generator,
  }) =>
      gen_single.generateSingleLibraryFile(
        filesystem: filesystem ?? IoGenerationFilesystem(),
        generator: generator ?? const SnapshotUnitTestGeneratorModule(),
        absoluteLibPath: absoluteLibPath,
        packageRoot: packageRoot,
        packageName: packageName,
        className: className,
        displayLabel: displayLabel,
        verbose: verbose,
        config: config,
        emit: emit,
      );

  /// CLI entry: parse args, load config, run registered generator module(s).
  static Future<void> generateFromCli(List<String> args) async {
    await CliGenerationOrchestrator(AppDependencies.production()).run(args);
  }
}

```

## Файл: .\lib\gen_config.dart

```dart
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

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

class MethodConfig {
  final SamplingStrategy strategy;
  final int maxCases;
  final int? seed;

  /// When true, successful `double` expectations use `closeTo` with [doubleEpsilon].
  final bool useCloseForDouble;

  /// Absolute epsilon for `closeTo` (only used when [useCloseForDouble] is true).
  final double doubleEpsilon;

  /// When true, bool/null snapshot literals emit `isTrue` / `isFalse` / `isNull` instead of `expected` locals.
  final bool useExpectMatchersBoolNull;

  const MethodConfig({
    this.strategy = SamplingStrategy.full,
    this.maxCases = 200,
    this.seed,
    this.useCloseForDouble = false,
    this.doubleEpsilon = 1e-9,
    this.useExpectMatchersBoolNull = true,
  });

  factory MethodConfig.fromYaml(YamlMap? yaml, MethodConfig defaults) {
    if (yaml == null) return defaults;

    final useClose = yaml.containsKey('use_close_for_double')
        ? (yaml['use_close_for_double'] as bool? ?? defaults.useCloseForDouble)
        : defaults.useCloseForDouble;

    final epsFromYaml = yaml.containsKey('double_epsilon')
        ? (yamlScalarToPositiveDouble(yaml['double_epsilon']) ?? defaults.doubleEpsilon)
        : defaults.doubleEpsilon;

    final useMatchers = yaml.containsKey('use_expect_matchers_bool_null')
        ? (yaml['use_expect_matchers_bool_null'] as bool? ?? defaults.useExpectMatchersBoolNull)
        : defaults.useExpectMatchersBoolNull;

    return MethodConfig(
      strategy:
          yaml.containsKey('strategy') ? SamplingStrategy.fromString(yaml['strategy'] as String?) : defaults.strategy,
      maxCases: yaml['max_cases'] as int? ?? defaults.maxCases,
      seed: yaml['seed'] as int? ?? defaults.seed,
      useCloseForDouble: useClose,
      doubleEpsilon: epsFromYaml,
      useExpectMatchersBoolNull: useMatchers,
    );
  }

  /// Parses a finite positive `double` from YAML values (`num`, `String`, etc.).
  static double? yamlScalarToPositiveDouble(Object? value) {
    if (value == null) return null;
    if (value is double) {
      if (!value.isFinite || value <= 0) return null;
      return value;
    }
    if (value is int) {
      if (value <= 0) return null;
      return value.toDouble();
    }
    if (value is String) {
      final d = double.tryParse(value.trim());
      if (d == null || !d.isFinite || d <= 0) return null;
      return d;
    }
    return null;
  }

  MethodConfig copyWith({
    SamplingStrategy? strategy,
    int? maxCases,
    int? seed,
    bool? useCloseForDouble,
    double? doubleEpsilon,
    bool? useExpectMatchersBoolNull,
  }) {
    return MethodConfig(
      strategy: strategy ?? this.strategy,
      maxCases: maxCases ?? this.maxCases,
      seed: seed ?? this.seed,
      useCloseForDouble: useCloseForDouble ?? this.useCloseForDouble,
      doubleEpsilon: doubleEpsilon ?? this.doubleEpsilon,
      useExpectMatchersBoolNull: useExpectMatchersBoolNull ?? this.useExpectMatchersBoolNull,
    );
  }
}

class GeneratorConfig {
  final MethodConfig defaults;
  final Map<String, MethodConfig> methods;
  final bool keepRunner;

  /// When true, generation runs but no test files are written; output paths are printed to stdout.
  final bool dryRun;

  /// When true, generated content is compared to the existing file instead of written.
  /// Exits with code 1 if any target differs.
  final bool check;

  const GeneratorConfig({
    this.defaults = const MethodConfig(),
    this.methods = const {},
    this.keepRunner = false,
    this.dryRun = false,
    this.check = false,
  });

  MethodConfig forMethod(String name) => methods[name] ?? defaults;

  static GeneratorConfig load(String packageRoot, {String? configPath}) {
    final path = configPath ?? p.join(packageRoot, 'dart_test_gen.yaml');
    final file = File(path);

    if (!file.existsSync()) {
      return const GeneratorConfig();
    }

    try {
      final yamlString = file.readAsStringSync();
      final yaml = loadYaml(yamlString);

      if (yaml is! YamlMap) {
        return const GeneratorConfig();
      }

      final defaults = MethodConfig.fromYaml(yaml, const MethodConfig());
      final methods = <String, MethodConfig>{};

      if (yaml.containsKey('methods') && yaml['methods'] is YamlMap) {
        final methodsYaml = yaml['methods'] as YamlMap;
        for (final entry in methodsYaml.entries) {
          final methodName = entry.key as String;
          final methodYaml = entry.value as YamlMap?;
          methods[methodName] = MethodConfig.fromYaml(methodYaml, defaults);
        }
      }

      final keepRunner = yaml['keep_runner'] as bool? ?? false;

      return GeneratorConfig(defaults: defaults, methods: methods, keepRunner: keepRunner);
    } catch (e) {
      // Fallback to defaults on error
      return const GeneratorConfig();
    }
  }
}

```

## Файл: .\lib\resolved_dependencies.dart

```dart
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;

import 'source_parser.dart';

/// Collects URIs of libraries referenced by types in method signatures (return types and parameters).
void _collectLibraryUrisFromType(DartType? type, Set<Uri> sink) {
  if (type == null) return;
  if (type is VoidType || type is DynamicType || type is InvalidType) return;

  if (type is NeverType) return;

  if (type is TypeParameterType) {
    _collectLibraryUrisFromType(type.bound, sink);
    return;
  }

  if (type is InterfaceType) {
    sink.add(type.element.library.uri);
    for (final arg in type.typeArguments) {
      _collectLibraryUrisFromType(arg, sink);
    }
    return;
  }

  if (type is FunctionType) {
    _collectLibraryUrisFromType(type.returnType, sink);
    for (final param in type.formalParameters) {
      _collectLibraryUrisFromType(param.type, sink);
    }
    return;
  }

  if (type is RecordType) {
    for (final f in type.positionalFields) {
      _collectLibraryUrisFromType(f.type, sink);
    }
    for (final f in type.namedFields) {
      _collectLibraryUrisFromType(f.type, sink);
    }
  }
}

String? _libAbsolutePathFromLibraryUri(Uri uri, String packageRoot, String packageName) {
  if (uri.scheme == 'file') {
    final fsPath = p.normalize(uri.toFilePath());
    final libRoot = p.normalize(p.join(packageRoot, 'lib'));
    if (!fsPath.startsWith(libRoot)) return null;
    return fsPath;
  }
  if (uri.scheme == 'package') {
    final pathPart = uri.path;
    final slash = pathPart.indexOf('/');
    if (slash <= 0) return null;
    final pkg = pathPart.substring(0, slash);
    if (pkg != packageName) return null;
    final rel = pathPart.substring(slash + 1);
    return p.normalize(p.join(packageRoot, 'lib', rel));
  }
  return null;
}

/// Absolute paths of `.dart` files under `lib/` for libraries that declare types used in the
/// class's method API. Does not include [absoluteLibPath] itself. Result is sorted.
///
/// Returns an empty list on analysis error or if the class is not found.
Future<List<String>> resolveReferencedLibAbsolutePaths({
  required String packageRoot,
  required String packageName,
  required String absoluteLibPath,
  String? className,
}) async {
  final primaryNorm = p.normalize(absoluteLibPath);
  final targetName = targetClassNameForGeneration(absoluteLibPath, className: className);
  if (targetName == null) return const [];

  try {
    final collection = AnalysisContextCollection(
      includedPaths: [packageRoot],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );
    final context = collection.contextFor(primaryNorm);
    final session = context.currentSession;
    final result = await session.getResolvedUnit(primaryNorm);
    if (result is! ResolvedUnitResult) return const [];

    final libEl = result.libraryElement;
    final clsEl = libEl.getClass(targetName);
    if (clsEl == null) return const [];

    final uris = <Uri>{};
    for (final method in clsEl.methods) {
      if (method.isStatic) continue;
      _collectLibraryUrisFromType(method.returnType, uris);
      for (final param in method.formalParameters) {
        _collectLibraryUrisFromType(param.type, uris);
      }
    }

    final paths = <String>{};
    for (final uri in uris) {
      final path = _libAbsolutePathFromLibraryUri(uri, packageRoot, packageName);
      if (path != null && p.normalize(path) != primaryNorm) {
        paths.add(path);
      }
    }
    final list = paths.toList()..sort();
    return list;
  } catch (_) {
    return const [];
  }
}
```

## Файл: .\lib\sampling.dart

```dart
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

```

## Файл: .\lib\snapshot.dart

```dart
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'source_parser.dart';
import 'test_generator.dart';

/// Structured failure of the snapshot subprocess: compile error or unparsable stdout.
class SnapshotRunnerFailure implements Exception {
  /// `'compile'` — the `dart` subprocess exited with a non-zero code.
  /// `'parse'` — the subprocess succeeded but its stdout did not match the expected payload.
  final String stage;
  final String absoluteLibPath;
  final String? className;
  final String? methodName;
  final String runnerPath;
  final String dartStderrTail;
  final int? exitCode;

  SnapshotRunnerFailure({
    required this.stage,
    required this.absoluteLibPath,
    required this.runnerPath,
    required this.dartStderrTail,
    this.className,
    this.methodName,
    this.exitCode,
  });

  @override
  String toString() =>
      'SnapshotRunnerFailure(stage=$stage, lib=$absoluteLibPath, class=$className, method=$methodName, runner=$runnerPath, exit=$exitCode)';
}

String _tailLines(String text, int maxLines) {
  final lines = const LineSplitter().convert(text);
  if (lines.length <= maxLines) return text;
  return lines.sublist(lines.length - maxLines).join('\n');
}

/// One scenario row: argument literals and either the expected return value or the exception type.
class SnapshotRow {
  final List<String> argLiterals;
  final String? expectedDartLiteral;
  final String? throwsExceptionType;

  const SnapshotRow({
    required this.argLiterals,
    this.expectedDartLiteral,
    this.throwsExceptionType,
  });
}

/// Snapshot for one method (row order matches the boundary-combination order).
class MethodSnapshot {
  final String methodName;
  final List<SnapshotRow> rows;

  const MethodSnapshot({required this.methodName, required this.rows});
}

String _escapeDartString(String s) {
  return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
}

/// Normalizes a runtime exception type name to a public Dart identifier.
///
/// Maps known private dart:core names (`_Exception`, `_AssertionError`, etc.)
/// to their public counterparts. For other `_`-prefixed names, falls back to
/// `Error`, `Exception`, or `Object` based on the runtime flags.
String publicExceptionName(
  String runtimeTypeName, {
  bool isError = false,
  bool isException = false,
}) {
  switch (runtimeTypeName) {
    case '_Exception':
      return 'Exception';
    case '_AssertionError':
      return 'AssertionError';
    case '_TypeError':
      return 'TypeError';
    case '_CastError':
      return 'TypeError';
  }
  if (runtimeTypeName.startsWith('_')) {
    if (isError) return 'Error';
    if (isException) return 'Exception';
    return 'Object';
  }
  return runtimeTypeName;
}

void _snapshotVerbose(void Function(String line)? sink, String label, String step, String detail) {
  sink?.call('[$label]\tsnapshot/$step\t$detail\n');
}

/// Runner imports: the target file and [extraPackageImports] (extra `package:` URIs from API resolution).
void _writeSnapshotRunnerImports(
  StringBuffer buf,
  String packageRoot,
  String packageName,
  String absoluteLibPath,
  List<String> extraPackageImports,
) {
  final primaryNorm = p.normalize(absoluteLibPath);
  buf.writeln("import '${packageImportUri(packageRoot, packageName, primaryNorm)}';");
  for (final uri in extraPackageImports) {
    buf.writeln("import '$uri';");
  }
}

String formatArgsForSnapshot(List<Param> params, List<String> argLiterals) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final param = params[i];
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    if (param.isNamed) {
      parts.add('${param.name}: $val');
    } else {
      parts.add(val);
    }
  }
  return parts.join(', ');
}

String _snapshotReceiverPrefix(String className, ParsedMethod m) {
  if (m.isStatic) return className;
  return 'c';
}

String _snapshotOperatorExpression(String recv, String op, List<String> argLiterals) {
  switch (op) {
    case '[]':
      return '$recv[${argLiterals[0]}]';
    case '[]=':
      return '$recv[${argLiterals[0]}] = ${argLiterals[1]}';
    case '~':
      return '~$recv';
    case '-':
      if (argLiterals.isEmpty) return '-$recv';
      return '$recv - ${argLiterals[0]}';
    default:
      if (argLiterals.length != 1) {
        throw StateError('operator $op: expected 1 arg, got ${argLiterals.length}');
      }
      return '$recv $op ${argLiterals[0]}';
  }
}

/// Invocation expression for the snapshot runner (getter / setter / operator / method).
String snapshotInvokeExpression({
  required String className,
  required ParsedMethod m,
  required String argList,
  required List<String> args,
}) {
  final recv = _snapshotReceiverPrefix(className, m);
  switch (m.kind) {
    case MethodKind.getter:
      return '$recv.${m.name}';
    case MethodKind.setter:
      return '$recv.${m.name} = $argList';
    case MethodKind.operator_:
      return _snapshotOperatorExpression(recv, m.name, args);
    case MethodKind.method:
      return '$recv.${m.name}($argList)';
  }
}

/// Generates the runner source, executes it, and returns snapshots per method.
///
/// [onSnapshotFraction] — sub-progress for the snapshot stage only, 0 to 1.
/// [onVerboseLine] — verbose lines (typically only with `-v`).
/// [onRunnerFailed] — output when the `dart run` runner process fails (stderr/stdout).
List<MethodSnapshot> runSnapshots({
  required String packageRoot,
  required String packageName,
  required String absoluteLibPath,
  required ParsedClass parsed,
  List<String> extraPackageImports = const [],
  String logLabel = '',
  void Function(double fraction01)? onSnapshotFraction,
  void Function(String line)? onVerboseLine,
  void Function(String stderrText, String stdoutText)? onRunnerFailed,
  bool keepRunner = false,
}) {
  void sl(String step, String detail) => _snapshotVerbose(onVerboseLine, logLabel, step, detail);

  void frac(double v) => onSnapshotFraction?.call(v.clamp(0.0, 1.0));

  frac(0);

  final runnerDir = Directory(p.join(Directory.systemTemp.path, 'dart_test_gen'));
  runnerDir.createSync(recursive: true);
  final runnerPath = p.join(
    runnerDir.path,
    'snapshot_runner_${parsed.className}_${DateTime.now().microsecondsSinceEpoch}.dart',
  );

  sl('runner', 'writing temporary script…');
  frac(0.08);
  final buf = StringBuffer();
  buf.writeln("// ignore_for_file: unused_local_variable");
  buf.writeln("import 'dart:convert';");
  buf.writeln("import 'dart:io';");
  _writeSnapshotRunnerImports(buf, packageRoot, packageName, absoluteLibPath, extraPackageImports);
  buf.writeln();
  buf.writeln('String _publicExceptionName(Object e) {');
  buf.writeln('  final n = e.runtimeType.toString();');
  buf.writeln('  switch (n) {');
  buf.writeln("    case '_Exception': return 'Exception';");
  buf.writeln("    case '_AssertionError': return 'AssertionError';");
  buf.writeln("    case '_TypeError': return 'TypeError';");
  buf.writeln("    case '_CastError': return 'TypeError';");
  buf.writeln('  }');
  buf.writeln("  if (n.startsWith('_')) {");
  buf.writeln("    if (e is Error) return 'Error';");
  buf.writeln("    if (e is Exception) return 'Exception';");
  buf.writeln("    return 'Object';");
  buf.writeln('  }');
  buf.writeln('  return n;');
  buf.writeln('}');
  buf.writeln();
  buf.writeln('Object? snapshotValue(Object? v) {');
  buf.writeln('  if (v == null || v is num || v is bool || v is String) {');
  buf.writeln('    return v;');
  buf.writeln('  }');
  buf.writeln('  if (v is List) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Set) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Iterable && v is! List && v is! Map && v is! String) {');
  buf.writeln('    return v.map(snapshotValue).toList();');
  buf.writeln('  }');
  buf.writeln('  if (v is Map) {');
  buf.writeln('    final out = <String, Object?>{};');
  buf.writeln('    for (final e in v.entries) {');
  buf.writeln("      out['\${e.key}'] = snapshotValue(e.value);");
  buf.writeln('    }');
  buf.writeln('    return out;');
  buf.writeln('  }');
  buf.writeln('  if (v is Enum) {');
  buf.writeln('    return <String, Object?>{');
  buf.writeln("      '_enumType': v.runtimeType.toString(),");
  buf.writeln("      '_enumName': v.name,");
  buf.writeln('    };');
  buf.writeln('  }');

  for (final cls in parsed.allFileClasses) {
    buf.writeln("  if (v.runtimeType.toString() == '${cls.name}') {");
    buf.writeln("    final dynamic d = v;");
    buf.writeln("    return <String, Object?>{");
    buf.writeln("      '_type': '${cls.name}',");
    for (final field in cls.fields) {
      buf.writeln("      '$field': snapshotValue(d.$field),");
    }
    buf.writeln("    };");
    buf.writeln("  }");
  }

  buf.writeln('  try {');
  buf.writeln('    final dynamic d = v;');
  buf.writeln('    final json = d.toJson();');
  buf.writeln('    if (json is Map<String, dynamic>) {');
  buf.writeln('      return <String, Object?>{');
  buf.writeln("        '_type': v.runtimeType.toString(),");
  buf.writeln('        ...json.map((k, v) => MapEntry(k, snapshotValue(v))),');
  buf.writeln('      };');
  buf.writeln('    }');
  buf.writeln('  } catch (_) {}');

  buf.writeln('  return <String, Object?>{');
  buf.writeln("    '_type': v.runtimeType.toString(),");
  buf.writeln("    '_value': v.toString(),");
  buf.writeln('  };');
  buf.writeln('}');
  buf.writeln();
  buf.writeln('Future<void> main() async {');
  buf.writeln('  final out = <Map<String, Object?>>[];');
  final receiverInfo = parsed.allFileClasses.where((c) => c.name == parsed.className).firstOrNull;
  final receiverExpr =
      receiverInfo != null ? instantiationExpressionForClass(receiverInfo) : '${parsed.className}()';
  buf.writeln('  final c = $receiverExpr;');
  buf.writeln();

  for (final m in parsed.methods) {
    final cases = generateBoundaryCases(m.params);
    for (final args in cases) {
      final argList = formatArgsForSnapshot(m.params, args);
      final argJson = jsonEncode(args);

      String invokeExpr;
      if (m.isFactory) {
        if (m.name.isEmpty) {
          invokeExpr = '${parsed.className}($argList)';
        } else {
          invokeExpr = '${parsed.className}.${m.name}($argList)';
        }
      } else {
        invokeExpr = snapshotInvokeExpression(
          className: parsed.className,
          m: m,
          argList: argList,
          args: args,
        );
      }

      if (m.snapshotReturnType == 'void') {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      await $invokeExpr.toList();');
        } else if (m.isAsync) {
          buf.writeln('      await $invokeExpr;');
        } else {
          buf.writeln('      $invokeExpr;');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': _publicExceptionName(e)});");
        buf.writeln('    }');
        buf.writeln('  }');
      } else {
        buf.writeln('  {');
        buf.writeln("    const method = '${_escapeDartString(m.name)}';");
        buf.writeln('    final args = $argJson as List<dynamic>;');
        buf.writeln('    try {');
        if (m.isStream) {
          buf.writeln('      final v = await $invokeExpr.toList();');
        } else if (m.isAsync) {
          buf.writeln('      final v = await $invokeExpr;');
        } else {
          buf.writeln('      final v = $invokeExpr;');
        }
        buf.writeln("      out.add({'method': method, 'args': args, 'ok': true, 'value': snapshotValue(v)});");
        buf.writeln('    } catch (e) {');
        buf.writeln(
            "      out.add({'method': method, 'args': args, 'ok': false, 'exception': _publicExceptionName(e)});");
        buf.writeln('    }');
        buf.writeln('  }');
      }
    }
    buf.writeln();
  }

  buf.writeln("  stdout.write(jsonEncode(out));");
  buf.writeln('}');

  File(runnerPath).writeAsStringSync(buf.toString());
  sl('runner', runnerPath);
  frac(0.22);

  var success = false;
  try {
    sl('process', 'dart run snapshot runner…');
    frac(0.38);
    final packageConfig = p.join(packageRoot, '.dart_tool', 'package_config.json');
    final result = Process.runSync(
      Platform.resolvedExecutable,
      ['run', '--packages=$packageConfig', runnerPath],
      workingDirectory: packageRoot,
      runInShell: false,
    );
    if (result.exitCode != 0) {
      final se = result.stderr.toString();
      final so = result.stdout.toString();
      onRunnerFailed?.call(se, so);
      throw SnapshotRunnerFailure(
        stage: 'compile',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: _tailLines(se.isNotEmpty ? se : so, 40),
        exitCode: result.exitCode,
      );
    }
    sl('process', 'exit 0, decoding JSON…');
    frac(0.92);
    final raw = result.stdout as String;
    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (e) {
      onRunnerFailed?.call(result.stderr.toString(), raw);
      throw SnapshotRunnerFailure(
        stage: 'parse',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: _tailLines(
          'jsonDecode failed: $e\nstdout (head):\n${raw.length > 4000 ? raw.substring(0, 4000) : raw}',
          40,
        ),
      );
    }
    if (decoded is! List) {
      onRunnerFailed?.call(result.stderr.toString(), raw);
      throw SnapshotRunnerFailure(
        stage: 'parse',
        absoluteLibPath: absoluteLibPath,
        className: parsed.className,
        runnerPath: runnerPath,
        dartStderrTail: _tailLines('expected JSON array, got: $decoded', 40),
      );
    }
    frac(1.0);
    final merged = _mergeDecoded(parsed, decoded);
    success = true;
    return merged;
  } finally {
    if (success && !keepRunner) {
      try {
        File(runnerPath).deleteSync();
      } catch (_) {}
    }
  }
}

List<MethodSnapshot> _mergeDecoded(ParsedClass parsed, List<dynamic> decoded) {
  var idx = 0;
  final snapshots = <MethodSnapshot>[];

  for (final m in parsed.methods) {
    final cases = generateBoundaryCases(m.params);
    final rows = <SnapshotRow>[];
    for (var i = 0; i < cases.length; i++) {
      if (idx >= decoded.length) {
        throw StateError('snapshot: не хватает записей (метод ${m.name})');
      }
      final row = decoded[idx++] as Map<String, dynamic>;
      final name = row['method'] as String;
      if (name != m.name) {
        throw StateError('snapshot: ожидался метод ${m.name}, получено $name');
      }
      final argLiterals = List<String>.from(cases[i]);
      final ok = row['ok'] as bool;
      if (ok) {
        if (m.snapshotReturnType == 'void') {
          rows.add(SnapshotRow(argLiterals: argLiterals));
        } else {
          final lit = dartLiteralFromJson(row['value'], m.snapshotReturnType, parsed.allFileClasses);
          rows.add(SnapshotRow(argLiterals: argLiterals, expectedDartLiteral: lit));
        }
      } else {
        final ex = publicExceptionName(row['exception'] as String);
        rows.add(SnapshotRow(argLiterals: argLiterals, throwsExceptionType: ex));
      }
    }
    snapshots.add(MethodSnapshot(methodName: m.name, rows: rows));
  }

  if (idx != decoded.length) {
    throw StateError('snapshot: лишние записи в JSON');
  }

  return snapshots;
}

/// `List<T>` / `Set<T>` / `Iterable<T>` with a single simple type token `T` (no nested `<` or `,`).
String? _collectionSingleTypeArg(String returnType, String collectionKeyword) {
  var n = returnType.replaceAll(' ', '');
  if (n.endsWith('?')) n = n.substring(0, n.length - 1);
  final prefix = '$collectionKeyword<';
  if (!n.startsWith(prefix) || !n.endsWith('>')) return null;
  final inner = n.substring(prefix.length, n.length - 1);
  if (inner.isEmpty || inner.contains('<') || inner.contains('>') || inner.contains(',')) {
    return null;
  }
  return inner;
}

/// `Map<String, T>` with a single simple value type token `T`.
String? _mapStringValueInnerType(String returnType) {
  var n = returnType.replaceAll(' ', '');
  if (n.endsWith('?')) n = n.substring(0, n.length - 1);
  const prefix = 'Map<String,';
  if (!n.startsWith(prefix) || !n.endsWith('>')) return null;
  final inner = n.substring(prefix.length, n.length - 1);
  if (inner.isEmpty || inner.contains(',') || inner.contains('<') || inner.contains('>')) {
    return null;
  }
  return inner;
}

/// Dart literal from a JSON value (after snapshot).
String dartLiteralFromJson(dynamic value, String returnType, List<ClassInfo> allClasses) {
  if (value is Map) {
    final m = Map<Object?, Object?>.from(value);
    if (m.containsKey('_type')) {
      final type = m['_type'] as String;
      if (m.containsKey('_value')) {
        // Fallback for objects we couldn't decompose
        return m['_value'].toString();
      }

      final cls = allClasses.where((c) => c.name == type).firstOrNull;
      if (cls != null) {
        final args = <String>[];
        for (final p in cls.constructorPositionalParams) {
          args.add(dartLiteralFromJsonLoose(m[p]));
        }
        for (final p in cls.constructorNamedParams) {
          args.add('$p: ${dartLiteralFromJsonLoose(m[p])}');
        }
        return '$type(${args.join(', ')})';
      }

      // Fallback if class info not found (e.g. imported class)
      final fields = <String>[];
      for (final entry in m.entries) {
        final k = entry.key as String;
        if (k == '_type') continue;
        final v = dartLiteralFromJsonLoose(entry.value);
        fields.add('$k: $v');
      }
      return '$type(${fields.join(', ')})';
    }
    if (m['_enumType'] != null && m['_enumName'] != null) {
      return '${m['_enumType']}.${m['_enumName']}';
    }

    final mapInner = _mapStringValueInnerType(returnType);
    if (mapInner != null) {
      final parts = <String>[];
      for (final entry in m.entries) {
        final k = '${entry.key}';
        final vLit = dartLiteralFromJson(entry.value, mapInner, allClasses);
        parts.add("'${_escapeDartString(k)}': $vLit");
      }
      return '{${parts.join(', ')}}';
    }
  }

  final listInner = _collectionSingleTypeArg(returnType, 'List');
  if (listInner != null && value is List) {
    final parts = value.map((dynamic e) => dartLiteralFromJson(e, listInner, allClasses)).toList();
    return '[${parts.join(', ')}]';
  }

  final setInner = _collectionSingleTypeArg(returnType, 'Set');
  if (setInner != null && value is List) {
    if (value.isEmpty) {
      return '<$setInner>{}';
    }
    if (setInner == 'int') {
      final lits = <String>[];
      final nums = <int>[];
      for (final e in value) {
        nums.add((e as num).toInt());
        lits.add(dartLiteralFromJson(e, 'int', allClasses));
      }
      final order = List<int>.generate(value.length, (i) => i);
      order.sort((a, b) => nums[a].compareTo(nums[b]));
      return '{${order.map((i) => lits[i]).join(', ')}}';
    }
    final literals = value.map((dynamic e) => dartLiteralFromJson(e, setInner, allClasses)).toList()..sort();
    return '{${literals.join(', ')}}';
  }

  final iterInner = _collectionSingleTypeArg(returnType, 'Iterable');
  if (iterInner != null && value is List) {
    final parts = value.map((dynamic e) => dartLiteralFromJson(e, iterInner, allClasses)).join(', ');
    return '[$parts]';
  }

  if (returnType == 'bool') {
    if (value is! bool) throw StateError('bool expected, got $value');
    return value ? 'true' : 'false';
  }
  if (returnType == 'int') {
    if (value is int) return '$value';
    if (value is num) return value.toInt().toString();
    throw StateError('int expected, got $value');
  }
  if (returnType == 'double') {
    if (value is! num) throw StateError('double expected, got $value');
    final d = value.toDouble();
    if (d.isNaN || d.isInfinite) return d.toString();
    if (d == d.roundToDouble()) return '${d.toInt()}.0';
    return d.toString();
  }
  if (returnType == 'String') {
    if (value is! String) throw StateError('String expected, got $value');
    return "'${_escapeDartString(value)}'";
  }
  return dartLiteralFromJsonLoose(value);
}

String dartLiteralFromJsonLoose(dynamic value) {
  if (value == null) return 'null';
  if (value is bool) return value ? 'true' : 'false';
  if (value is int) return '$value';
  if (value is double) {
    final d = value;
    if (d.isNaN || d.isInfinite) return d.toString();
    return d.toString();
  }
  if (value is String) return "'${_escapeDartString(value)}'";
  throw StateError('unsupported json value $value');
}

```

## Файл: .\lib\source_parser.dart

```dart
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_test_gen/src/application/dynamic_input_generator.dart';
import 'package:dart_test_gen/src/application/method_logic_analyzer.dart';
import 'package:path/path.dart' as p;

import 'test_generator.dart';

/// Description of a method extracted from source (before snapshotting).
class ParsedMethod {
  final String name;
  final List<Param> params;
  final String returnType;

  /// `true` when the body is `async` / `async*` or the declared type is `Future<…>`.
  final bool isAsync;

  /// `true` when the declared return type is `Stream<…>`.
  final bool isStream;

  /// Unwrapped type for snapshotting and codegen: `Future<T>` → `T`, `Stream<T>` → `List<T>`.
  final String snapshotReturnType;

  final bool isStatic;
  final bool isFactory;
  final MethodKind kind;

  const ParsedMethod({
    required this.name,
    required this.params,
    required this.returnType,
    required this.isAsync,
    required this.isStream,
    required this.snapshotReturnType,
    this.isStatic = false,
    this.isFactory = false,
    this.kind = MethodKind.method,
  });
}

class ClassInfo {
  final String name;
  final List<String> fields;

  /// Field name → type as written in source (e.g. `int`, `int?`).
  final Map<String, String> fieldTypes;
  final List<String> constructorPositionalParams;
  final List<String> constructorNamedParams;
  final bool isExtensionType;

  const ClassInfo(
    this.name,
    this.fields, {
    this.fieldTypes = const {},
    this.constructorPositionalParams = const [],
    this.constructorNamedParams = const [],
    this.isExtensionType = false,
  });
}

/// Result of parsing a single file: class name and its methods.
class ParsedClass {
  final String className;
  final List<ParsedMethod> methods;
  final List<ClassInfo> allFileClasses;

  const ParsedClass({
    required this.className,
    required this.methods,
    required this.allFileClasses,
  });
}

/// Collects `EnumName.variant` literals for every public enum in the file.
Map<String, List<String>> collectEnumLiterals(CompilationUnit unit) {
  final map = <String, List<String>>{};
  for (final d in unit.declarations) {
    if (d is! EnumDeclaration) continue;
    final name = d.name.lexeme;
    if (name.startsWith('_')) continue;
    final values = <String>[];
    for (final ec in d.constants) {
      values.add('$name.${ec.name.lexeme}');
    }
    if (values.isEmpty) continue;
    map[name] = values;
  }
  return map;
}

List<ClassInfo> _collectAllClasses(CompilationUnit unit) {
  final out = <ClassInfo>[];
  for (final d in unit.declarations) {
    if (d is ClassDeclaration) {
      final fields = <String>[];
      final fieldTypes = <String, String>{};
      for (final member in d.members) {
        if (member is FieldDeclaration && !member.isStatic) {
          final typeSource = member.fields.type?.toSource() ?? 'dynamic';
          for (final v in member.fields.variables) {
            final name = v.name.lexeme;
            if (!name.startsWith('_')) {
              fields.add(name);
              fieldTypes[name] = typeSource;
            }
          }
        }
      }

      // Find the primary constructor (unnamed or first suitable).
      final positional = <String>[];
      final named = <String>[];
      ConstructorDeclaration? primary;
      for (final member in d.members) {
        if (member is ConstructorDeclaration && member.factoryKeyword == null) {
          if (member.name == null) {
            primary = member;
            break;
          }
          primary ??= member;
        }
      }

      if (primary != null) {
        for (final p in primary.parameters.parameters) {
          if (p.isNamed) {
            named.add(p.name!.lexeme);
          } else {
            positional.add(p.name!.lexeme);
          }
        }
      }

      out.add(ClassInfo(
        d.name.lexeme,
        fields,
        fieldTypes: fieldTypes,
        constructorPositionalParams: positional,
        constructorNamedParams: named,
      ));
    } else if (d is ExtensionTypeDeclaration) {
      final fields = <String>[];
      final fieldTypes = <String, String>{};
      
      final rep = d.representation;
      final repName = rep.fieldName.lexeme;
      fields.add(repName);
      fieldTypes[repName] = rep.fieldType.toSource();
      
      final positional = <String>[repName];
      final named = <String>[];
      
      out.add(ClassInfo(
        d.name.lexeme,
        fields,
        fieldTypes: fieldTypes,
        constructorPositionalParams: positional,
        constructorNamedParams: named,
        isExtensionType: true,
      ));
    }
  }
  return out;
}

String _sampleLiteralForConstructorField(String typeSource, int diagonalIdx) {
  final t = typeSource.replaceAll(' ', '');
  final base = t.endsWith('?') ? t.substring(0, t.length - 1) : t;
  switch (base) {
    case 'int':
      return diagonalIdx == 0 ? '0' : '255';
    case 'double':
      return diagonalIdx == 0 ? '0.0' : '1.0';
    case 'bool':
      return diagonalIdx == 0 ? 'false' : 'true';
    case 'String':
      return diagonalIdx == 0 ? "''" : "'test'";
    default:
      return '0';
  }
}

/// Constructor call with primitive literals (positional, then named) — for snapshots and boundaries.
String instantiationExpressionForClass(ClassInfo cls, {int diagonalIdx = 0}) {
  final parts = <String>[];
  for (final name in cls.constructorPositionalParams) {
    final typeSrc = cls.fieldTypes[name] ?? 'dynamic';
    parts.add(_sampleLiteralForConstructorField(typeSrc, diagonalIdx));
  }
  for (final name in cls.constructorNamedParams) {
    final typeSrc = cls.fieldTypes[name] ?? 'dynamic';
    parts.add('$name: ${_sampleLiteralForConstructorField(typeSrc, diagonalIdx)}');
  }
  return '${cls.name}(${parts.join(', ')})';
}

/// Two diagonal constructor-call literals using boundary primitives per field type.
List<String>? _sampleLiteralsForCustomClass(ClassInfo cls) {
  if (cls.constructorPositionalParams.isEmpty && cls.constructorNamedParams.isEmpty) {
    return null;
  }
  return [
    instantiationExpressionForClass(cls, diagonalIdx: 0),
    instantiationExpressionForClass(cls, diagonalIdx: 1),
  ];
}

Param _paramFor(
  String paramName,
  TypeAnnotation? t,
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allFileClasses, {
  bool isNullable = false,
  bool isNamed = false,
  bool isOptionalPositional = false,
  String? defaultValueCode,
  List<String>? extraLiterals,
}) {
  Param create(ParamType type, {List<String>? literalValues}) {
    final combined = <String>{};
    if (literalValues != null) combined.addAll(literalValues);
    if (extraLiterals != null) combined.addAll(extraLiterals);

    // For primitive types we want default boundaries PLUS literals found in source.
    // If we return combined here, generateBoundaryCases skips the defaults.
    // So we track whether to merge with defaults — Param has no dedicated flag for that.
    // Easiest fix: put ALL values in Param.literalValues when it's not an enum.

    return Param(
      paramName,
      type,
      literalValues: combined.isEmpty ? null : combined.toList(),
      isNullable: isNullable,
      isNamed: isNamed,
      isOptionalPositional: isOptionalPositional,
      defaultValueCode: defaultValueCode,
    );
  }

  if (t == null) {
    return create(ParamType.dynamic_);
  }
  if (t is NamedType) {
    final base = t.name.lexeme;
    if (_isListOfIntNamedType(t)) {
      return create(ParamType.listInt_);
    }
    if (_isListOfStringNamedType(t)) {
      return create(ParamType.listString_);
    }
    if (_isSetOfIntNamedType(t)) {
      return create(ParamType.setInt_);
    }
    if (_isIterableOfIntNamedType(t)) {
      return create(ParamType.iterableInt_);
    }
    final enumCases = enumLiterals[base];
    if (enumCases != null) {
      return create(ParamType.enum_, literalValues: enumCases);
    }
    switch (base) {
      case 'int':
        return create(ParamType.int_);
      case 'double':
        return create(ParamType.double_);
      case 'bool':
        return create(ParamType.bool_);
      case 'String':
        return create(ParamType.string_);
      // `operator ==(Object other)` and `Object`/`Object?` — literals behave like dynamic.
      case 'Object':
        return create(ParamType.dynamic_);
      default:
        final cls = allFileClasses.where((c) => c.name == base).firstOrNull;
        final customLiterals = cls != null ? _sampleLiteralsForCustomClass(cls) : null;
        return create(ParamType.custom_, literalValues: customLiterals);
    }
  }
  return create(ParamType.dynamic_);
}

bool _isListOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'List') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

bool _isListOfStringNamedType(NamedType t) {
  if (t.name.lexeme != 'List') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'String';
}

bool _isSetOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'Set') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

bool _isIterableOfIntNamedType(NamedType t) {
  if (t.name.lexeme != 'Iterable') return false;
  final args = t.typeArguments?.arguments;
  if (args == null || args.length != 1) return false;
  final inner = args.single;
  return inner is NamedType && inner.name.lexeme == 'int';
}

String _returnTypeString(MethodDeclaration m) {
  final rt = m.returnType;
  if (rt == null) return 'dynamic';
  return rt.toSource();
}

/// For setters the AST often omits return type — semantically this is `void`.
String _returnTypeStringForMember(MethodDeclaration m, MethodKind kind) {
  if (kind == MethodKind.setter) {
    final rt = m.returnType;
    if (rt == null) return 'void';
    return rt.toSource();
  }
  return _returnTypeString(m);
}

String? _futureStreamInner(NamedType rt) {
  final base = rt.name.lexeme;
  if (base != 'Future' && base != 'Stream') return null;
  final args = rt.typeArguments?.arguments;
  if (args == null || args.isEmpty) return 'dynamic';
  if (args.length != 1) return null;
  return args.single.toSource();
}

String _snapshotReturnTypeForMethod(MethodDeclaration m) {
  final rt = m.returnType;
  if (rt is NamedType) {
    final base = rt.name.lexeme;
    if (base == 'Future') {
      return _futureStreamInner(rt) ?? 'dynamic';
    }
    if (base == 'Stream') {
      final inner = _futureStreamInner(rt) ?? 'dynamic';
      return 'List<$inner>';
    }
  }
  return _returnTypeString(m);
}

bool _methodIsStream(MethodDeclaration m) {
  final rt = m.returnType;
  return rt is NamedType && rt.name.lexeme == 'Stream';
}

bool _methodIsAsync(MethodDeclaration m) {
  if (m.body.isAsynchronous) return true;
  final rt = m.returnType;
  return rt is NamedType && rt.name.lexeme == 'Future';
}

bool _isSupportedOperator(String op, FormalParameterList? parameters) {
  final n = parameters?.parameters.length ?? 0;
  switch (op) {
    case '-':
      return n == 0 || n == 1;
    case '~':
      return n == 0;
    case '[]':
      return n == 1;
    case '[]=':
      return n == 2;
    case '+':
    case '*':
    case '/':
    case '%':
    case '~/':
    case '&':
    case '|':
    case '^':
    case '<<':
    case '>>':
    case '>>>':
    case '<':
    case '>':
    case '<=':
    case '>=':
    case '==':
      return n == 1;
    default:
      return false;
  }
}

/// Returns the member kind when supported by the generator; otherwise `null`.
MethodKind? _supportedMemberKind(MethodDeclaration m) {
  if (m.parent is! ClassDeclaration && m.parent is! ExtensionTypeDeclaration) return null;
  if (m.name.lexeme.startsWith('_')) return null;
  if (m.body is EmptyFunctionBody) return null;

  if (m.isGetter) {
    if (m.parameters != null && m.parameters!.parameters.isNotEmpty) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.getter;
  }
  if (m.isSetter) {
    if (m.parameters == null || m.parameters!.parameters.length != 1) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.setter;
  }
  if (m.isOperator) {
    final op = m.name.lexeme;
    if (!_isSupportedOperator(op, m.parameters)) return null;
    if (_hasUnsupportedParameters(m.parameters)) return null;
    return MethodKind.operator_;
  }

  if (m.operatorKeyword != null) return null;
  return MethodKind.method;
}

List<Param> _paramsFromFormalList(
  FormalParameterList? list,
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allFileClasses,
  AstNode? node,
) {
  if (list == null) return const [];

  final paramNames = <String>[];
  for (final fp in list.parameters) {
    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (resolved is SimpleFormalParameter && resolved.name != null) {
      paramNames.add(resolved.name!.lexeme);
    }
  }

  final body = node is MethodDeclaration ? node.body : (node is ConstructorDeclaration ? node.body : null);
  final profile = const MethodLogicAnalyzer().analyze(body, paramNames);

  final out = <Param>[];
  for (final fp in list.parameters) {
    final isNamed = fp.isNamed;
    final isOptionalPositional = fp.isOptionalPositional;
    String? defaultValueCode;

    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (fp is DefaultFormalParameter) {
      defaultValueCode = fp.defaultValue?.toSource();
    }

    if (resolved is SimpleFormalParameter) {
      final paramName = resolved.name;
      if (paramName == null) {
        return const [];
      }

      final type = resolved.type;
      bool isNullable = false;
      if (type == null) {
        isNullable = true;
      } else if (type is NamedType) {
        isNullable = type.question != null;
      } else if (type is GenericFunctionType) {
        isNullable = type.question != null;
      }

      final initialParam = _paramFor(
        paramName.lexeme,
        resolved.type,
        enumLiterals,
        allFileClasses,
        isNullable: isNullable,
        isNamed: isNamed,
        isOptionalPositional: isOptionalPositional,
        defaultValueCode: defaultValueCode,
      );

      // Generate dynamic inputs and merge with Param.literalValues
      final dynamicInputs = const DynamicInputGenerator().generate(profile, [initialParam]);
      final extraLiterals = dynamicInputs[paramName.lexeme];

      out.add(_paramFor(
        paramName.lexeme,
        resolved.type,
        enumLiterals,
        allFileClasses,
        isNullable: isNullable,
        isNamed: isNamed,
        isOptionalPositional: isOptionalPositional,
        defaultValueCode: defaultValueCode,
        extraLiterals: extraLiterals?.toList(),
      ));
    } else {
      return const [];
    }
  }
  return out;
}

bool _hasUnsupportedParameters(FormalParameterList? list) {
  if (list == null) return false;
  for (final fp in list.parameters) {
    final resolved = fp is DefaultFormalParameter ? fp.parameter : fp;
    if (resolved is! SimpleFormalParameter) return true;
  }
  return false;
}

/// Class name selected for generation (same heuristic as parsing without `--class`).
String? targetClassNameForGeneration(String absoluteLibPath, {String? className}) {
  final parsed = parseFile(path: absoluteLibPath, featureSet: FeatureSet.latestLanguageVersion()).unit;
  final cls = _findTargetClassOrExtensionType(parsed, className: className);
  return cls?.name.lexeme;
}

NamedCompilationUnitMember? _findTargetClassOrExtensionType(CompilationUnit unit, {String? className}) {
  final classesAndExtensions = unit.declarations
      .where((d) => d is ClassDeclaration || d is ExtensionTypeDeclaration)
      .cast<NamedCompilationUnitMember>()
      .toList();
  if (classesAndExtensions.isEmpty) return null;

  if (className != null) {
    for (final c in classesAndExtensions) {
      if (c.name.lexeme == className) return c;
    }
    return null;
  }

  NamedCompilationUnitMember? best;
  var bestScore = -1;
  for (final c in classesAndExtensions) {
    if (c.name.lexeme.startsWith('_')) continue;
    var score = 0;
    
    final members = c is ClassDeclaration ? c.members : (c as ExtensionTypeDeclaration).members;
    for (final member in members) {
      if (member is ConstructorDeclaration) {
        if (member.factoryKeyword != null && (member.name == null || !member.name!.lexeme.startsWith('_'))) score++;
      } else if (member is MethodDeclaration) {
        if (_supportedMemberKind(member) == null) continue;
        score++;
      }
    }
    if (score > bestScore) {
      bestScore = score;
      best = c;
    }
  }
  if (best != null) return best;

  for (final c in classesAndExtensions) {
    if (!c.name.lexeme.startsWith('_')) return c;
  }
  return classesAndExtensions.first;
}

/// Extends [enumLiterals] and [allClasses] with declarations from [mergeLibAbsolutePaths].
void _mergeDeclarationsFromLibPaths(
  Map<String, List<String>> enumLiterals,
  List<ClassInfo> allClasses,
  List<String> mergeLibAbsolutePaths,
) {
  for (final rawPath in mergeLibAbsolutePaths) {
    final path = p.normalize(rawPath);
    try {
      final unit = parseFile(path: path, featureSet: FeatureSet.latestLanguageVersion()).unit;
      enumLiterals.addAll(collectEnumLiterals(unit));
      for (final info in _collectAllClasses(unit)) {
        final i = allClasses.indexWhere((c) => c.name == info.name);
        if (i < 0) {
          allClasses.add(info);
        } else {
          allClasses[i] = info;
        }
      }
    } catch (_) {}
  }
}

/// Parses [absoluteLibPath] (a file under `lib/`).
///
/// Returns `null` when [className] is `null` and the file is not suitable:
/// no [ClassDeclaration] (e.g. enum-only file), or the target class has no supported instance methods.
///
/// When [className] is set but the class is missing or has no supported methods — throws [StateError].
ParsedClass? parseLibraryClassOptional(
  String absoluteLibPath, {
  String? className,
  List<String> mergeLibAbsolutePaths = const [],
}) {
  final parsed = parseFile(path: absoluteLibPath, featureSet: FeatureSet.latestLanguageVersion()).unit;
  final cls = _findTargetClassOrExtensionType(parsed, className: className);
  if (cls == null) {
    if (className != null) {
      throw StateError('Не найден класс $className в файле: $absoluteLibPath');
    }
    return null;
  }

  final enumLiterals = Map<String, List<String>>.from(collectEnumLiterals(parsed));
  final allClasses = List<ClassInfo>.from(_collectAllClasses(parsed));
  _mergeDeclarationsFromLibPaths(enumLiterals, allClasses, mergeLibAbsolutePaths);

  final methods = <ParsedMethod>[];
  final members = cls is ClassDeclaration ? cls.members : (cls as ExtensionTypeDeclaration).members;
  for (final member in members) {
    if (member is MethodDeclaration) {
      final m = member;
      final kind = _supportedMemberKind(m);
      if (kind == null) continue;

      final params = _paramsFromFormalList(m.parameters, enumLiterals, allClasses, m);
      final returnType = _returnTypeStringForMember(m, kind);
      final snapshotRt = kind == MethodKind.setter ? 'void' : _snapshotReturnTypeForMethod(m);
      methods.add(
        ParsedMethod(
          name: m.name.lexeme,
          params: params,
          returnType: returnType,
          isAsync: _methodIsAsync(m),
          isStream: _methodIsStream(m),
          snapshotReturnType: snapshotRt,
          isStatic: m.isStatic,
          kind: kind,
        ),
      );
    } else if (member is ConstructorDeclaration) {
      if (member.factoryKeyword != null) {
        if (member.name?.lexeme.startsWith('_') == true) continue;
        if (_hasUnsupportedParameters(member.parameters)) continue;

        final params = _paramsFromFormalList(member.parameters, enumLiterals, allClasses, member);
        methods.add(
          ParsedMethod(
            name: member.name?.lexeme ?? '',
            params: params,
            returnType: cls.name.lexeme,
            isAsync: false,
            isStream: false,
            snapshotReturnType: cls.name.lexeme,
            isFactory: true,
            kind: MethodKind.method,
          ),
        );
      }
    }
  }

  if (methods.isEmpty) {
    if (className != null) {
      throw StateError(
        'В классе ${cls.name.lexeme} нет поддерживаемых методов: $absoluteLibPath',
      );
    }
    return null;
  }

  return ParsedClass(
    className: cls.name.lexeme,
    methods: methods,
    allFileClasses: allClasses,
  );
}

/// Like [parseLibraryClassOptional], but never returns `null`: throws [StateError] if there is nothing to generate.
ParsedClass parseLibraryClass(
  String absoluteLibPath, {
  String? className,
  List<String> mergeLibAbsolutePaths = const [],
}) {
  final r = parseLibraryClassOptional(
    absoluteLibPath,
    className: className,
    mergeLibAbsolutePaths: mergeLibAbsolutePaths,
  );
  if (r == null) {
    throw StateError('Нет класса с поддерживаемыми методами: $absoluteLibPath');
  }
  return r;
}

/// Package root: directory containing `pubspec.yaml` for the given file path.
String findPackageRootForFile(String absoluteFilePath) {
  var dir = p.dirname(p.normalize(absoluteFilePath));
  while (true) {
    if (File(p.join(dir, 'pubspec.yaml')).existsSync()) {
      return dir;
    }
    final parent = p.dirname(dir);
    if (parent == dir) {
      throw StateError('pubspec.yaml не найден выше по дереву от $absoluteFilePath');
    }
    dir = parent;
  }
}

/// `lib/foo.dart` → `package:<name>/foo.dart`
String packageImportUri(String packageRoot, String packageName, String absoluteLibPath) {
  final libRoot = p.join(packageRoot, 'lib');
  final rel = p.relative(absoluteLibPath, from: libRoot);
  if (rel.startsWith('..')) {
    throw StateError('Файл должен находиться в $libRoot, получено: $absoluteLibPath');
  }
  final posix = rel.replaceAll(r'\', '/');
  return 'package:$packageName/$posix';
}

String readPackageName(String packageRoot) {
  final pubspec = p.join(packageRoot, 'pubspec.yaml');
  final text = File(pubspec).readAsStringSync();
  for (final line in text.split('\n')) {
    final trimmed = line.trimLeft();
    if (trimmed.startsWith('name:')) {
      return trimmed.substring('name:'.length).trim();
    }
  }
  throw StateError('Имя пакета не найдено в $pubspec');
}

```

## Файл: .\lib\src\application\cli_args.dart

```dart
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

```

## Файл: .\lib\src\application\cli_generation_orchestrator.dart

```dart
import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dart_test_gen/cli/cli_log.dart';
import 'package:dart_test_gen/cli/cli_progress.dart';
import 'package:dart_test_gen/gen_config.dart';
import 'package:dart_test_gen/snapshot.dart';
import 'package:dart_test_gen/source_parser.dart';
import 'package:path/path.dart' as p;

import '../domain/check_failure.dart';
import '../domain/generator_module.dart';
import '../wiring/app_dependencies.dart';
import 'cli_args.dart';
import 'generation_isolate.dart';
import 'generation_single_library.dart';
import 'snapshot_failure_formatting.dart';
import 'snapshot_unit_test_generation.dart';

EmitGenerationUi _mainThreadEmit({
  required GenerationProgressUi progressUi,
  required String displayLabel,
  required bool verbose,
}) {
  return ({double? progress, String? line, bool? error}) {
    final isErr = error == true;
    if (progress != null) {
      progressUi.setPercent(displayLabel, progress);
    }
    if (line != null && line.isNotEmpty) {
      if (isErr) {
        CliLog.err(line.endsWith('\n') ? line : '$line\n');
      } else if (verbose) {
        CliLog.err(line.endsWith('\n') ? line : '$line\n');
      }
    }
  };
}

bool _isDartUnderLib(String absoluteFile, String packageRoot) {
  final libRoot = p.normalize(p.join(packageRoot, 'lib'));
  final file = p.normalize(absoluteFile);
  return p.isWithin(libRoot, file);
}

/// CLI orchestration: resolve targets, config, then single-thread or isolate fan-out.
final class CliGenerationOrchestrator {
  CliGenerationOrchestrator(this._deps);

  final AppDependencies _deps;

  Future<void> run(List<String> args) async {
    final parsedArgs = CliArgs.parseCliArgs(args);
    final cwd = _deps.filesystem.currentWorkingDirectory;
    var targets = expandGenerationTargetsWithFs(_deps.filesystem, cwd, parsedArgs.inputs);

    if (targets.isEmpty) {
      CliLog.err('No .dart files found.');
      exit(1);
    }

    final packageRoots = targets.map(findPackageRootForFile).toSet();
    if (packageRoots.length != 1) {
      CliLog.err(
        'All paths must belong to the same package (one pubspec).\n'
        'Found package roots: ${packageRoots.join(", ")}',
      );
      exit(1);
    }
    final packageRoot = packageRoots.first;

    final before = targets.length;
    targets = targets.where((t) => _isDartUnderLib(t, packageRoot)).toList();
    if (targets.isEmpty) {
      CliLog.err(
        'After filtering, no files remain under $packageRoot${p.separator}lib '
        '(candidates before filter: $before).',
      );
      exit(1);
    }

    if (parsedArgs.className != null && targets.length != 1) {
      CliLog.err(
        '--class selects one class: pass exactly one .dart under lib or a single target.\n'
        'Targets after filter: ${targets.length}.',
      );
      exit(64);
    }

    final packageName = readPackageName(packageRoot);

    if ((parsedArgs.dryRun ?? false) && (parsedArgs.check ?? false)) {
      CliLog.err('--dry-run and --check are mutually exclusive: pick one.');
      exit(64);
    }

    var config = GeneratorConfig.load(packageRoot, configPath: parsedArgs.configPath);
    if (parsedArgs.strategy != null ||
        parsedArgs.maxCases != null ||
        parsedArgs.seed != null ||
        parsedArgs.useCloseForDouble != null ||
        parsedArgs.doubleEpsilon != null ||
        parsedArgs.useExpectMatchersBoolNull != null ||
        parsedArgs.keepRunner != null ||
        parsedArgs.dryRun != null ||
        parsedArgs.check != null) {
      config = GeneratorConfig(
        defaults: config.defaults.copyWith(
          strategy: parsedArgs.strategy != null ? SamplingStrategy.fromString(parsedArgs.strategy) : null,
          maxCases: parsedArgs.maxCases,
          seed: parsedArgs.seed,
          useCloseForDouble: parsedArgs.useCloseForDouble,
          doubleEpsilon: parsedArgs.doubleEpsilon,
          useExpectMatchersBoolNull: parsedArgs.useExpectMatchersBoolNull,
        ),
        methods: config.methods,
        keepRunner: parsedArgs.keepRunner ?? config.keepRunner,
        dryRun: parsedArgs.dryRun ?? config.dryRun,
        check: parsedArgs.check ?? config.check,
      );
    }

    final labels = targets.map((t) => shortLibLabel(t, packageRoot)).toList();
    final ui = GenerationProgressUi.create(labels);

    if (parsedArgs.verbose) {
      CliLog.err('[cli]\tverbose\tpkg=$packageRoot\tfiles=${targets.length}\n');
    }

    if (targets.length == 1) {
      final label = labels.first;
      CheckFailure? checkFailure;
      try {
        checkFailure = await generateSingleLibraryFile(
          filesystem: _deps.filesystem,
          generator: _deps.defaultGenerator,
          absoluteLibPath: targets.first,
          packageRoot: packageRoot,
          packageName: packageName,
          className: parsedArgs.className,
          displayLabel: label,
          verbose: parsedArgs.verbose,
          config: config,
          emit: _mainThreadEmit(progressUi: ui, displayLabel: label, verbose: parsedArgs.verbose),
        );
      } on SnapshotRunnerFailure catch (f) {
        ui.finish();
        CliLog.err(formatSnapshotRunnerFailure(f));
        exit(1);
      } catch (e, st) {
        ui.finish();
        CliLog.err('Error: $e\n$st');
        exit(1);
      }
      ui.finish();
      if (checkFailure != null) {
        CliLog.err(checkFailure.summary);
        CliLog.err('[check] 1 file(s) differ');
        exit(1);
      }
      return;
    }

    final futures = <Future<void>>[];
    final checkFailureSummaries = <String>[];

    for (final libAbs in targets) {
      final receivePort = ReceivePort();
      final displayLabel = shortLibLabel(libAbs, packageRoot);

      final done = Completer<void>();
      var doneSent = false;
      var success = false;
      var sawResult = false;

      StreamSubscription<Object?>? sub;
      sub = receivePort.listen((message) {
        if (message is Map) {
          final t = message['t'] as String?;
          if (t == GenerationIsolateProtocol.msgProgress) {
            final lab = message['l']! as String;
            final pct = (message['pct'] as num).toDouble();
            ui.setPercent(lab, pct);
            return;
          }
          if (t == GenerationIsolateProtocol.msgVerbose && parsedArgs.verbose) {
            final m = message['m'] as String? ?? '';
            CliLog.err(m.endsWith('\n') ? m : '$m\n');
            return;
          }
          if (t == GenerationIsolateProtocol.msgError) {
            final m = message['m'] as String? ?? '';
            CliLog.err(m.endsWith('\n') ? m : '$m\n');
            return;
          }
          if (t == GenerationIsolateProtocol.msgCheckFail) {
            final s = message['s'] as String? ?? '';
            checkFailureSummaries.add(s);
            return;
          }
          return;
        }
        if (message is String && message.startsWith(isolateResultPrefix)) {
          success = message.endsWith(':ok');
          sawResult = true;
          return;
        }
        if (message == isolateDoneSentinel) {
          if (!doneSent) {
            doneSent = true;
            if (!sawResult) {
              done.completeError(StateError('isolate finished without result: $libAbs'));
            } else if (success) {
              done.complete();
            } else {
              done.completeError(StateError('generation failed: $libAbs'));
            }
          }
          return;
        }
      });

      futures.add(done.future.then((_) async {
        await sub?.cancel();
        receivePort.close();
      }));

      final isolateMessage = generationIsolateSpawnMessage(
        absoluteLibPath: libAbs,
        packageRoot: packageRoot,
        packageName: packageName,
        className: parsedArgs.className,
        displayLabel: displayLabel,
        verbose: parsedArgs.verbose,
        config: config,
        logPort: receivePort.sendPort,
      );

      await Isolate.spawn(
        generationIsolateMain,
        isolateMessage,
        errorsAreFatal: false,
        debugName: p.basename(libAbs),
      );
    }

    Object? aggregateError;
    for (final f in futures) {
      try {
        await f;
      } catch (e, st) {
        aggregateError ??= e;
        CliLog.err('Error: $e\n$st');
      }
    }

    ui.finish();

    if (aggregateError != null) {
      exit(1);
    }

    if (checkFailureSummaries.isNotEmpty) {
      for (final s in checkFailureSummaries) {
        CliLog.err(s);
      }
      CliLog.err('[check] ${checkFailureSummaries.length} file(s) differ');
      exit(1);
    }
  }
}

```

## Файл: .\lib\src\application\dynamic_input_generator.dart

```dart
import '../../test_generator.dart';
import '../domain/logic_profile.dart';

enum StringHint {
  caseSensitive,
  whitespace,
  delimiter,
  emptyString,
  lengthDependent,
  substringMatch,
  replacement,
  padding,
}

enum NumericHint {
  parity,
  signDependent,
  rounding,
  specialValues,
  arithmetic,
  bitManipulation,
  formatting,
}

const _stringHints = {
  'toLowerCase': StringHint.caseSensitive,
  'toUpperCase': StringHint.caseSensitive,
  'trim': StringHint.whitespace,
  'trimLeft': StringHint.whitespace,
  'trimRight': StringHint.whitespace,
  'split': StringHint.delimiter,
  'splitMapJoin': StringHint.delimiter,
  'isEmpty': StringHint.emptyString,
  'isNotEmpty': StringHint.emptyString,
  'substring': StringHint.lengthDependent,
  'length': StringHint.lengthDependent,
  'codeUnitAt': StringHint.lengthDependent,
  'startsWith': StringHint.substringMatch,
  'endsWith': StringHint.substringMatch,
  'contains': StringHint.substringMatch,
  'indexOf': StringHint.substringMatch,
  'lastIndexOf': StringHint.substringMatch,
  'replaceFirst': StringHint.replacement,
  'replaceAll': StringHint.replacement,
  'replaceRange': StringHint.replacement,
  'padLeft': StringHint.padding,
  'padRight': StringHint.padding,
};

const _numericHints = {
  'isOdd': NumericHint.parity,
  'isEven': NumericHint.parity,
  'abs': NumericHint.signDependent,
  'sign': NumericHint.signDependent,
  'isNegative': NumericHint.signDependent,
  'round': NumericHint.rounding,
  'floor': NumericHint.rounding,
  'ceil': NumericHint.rounding,
  'truncate': NumericHint.rounding,
  'toInt': NumericHint.rounding,
  'toDouble': NumericHint.rounding,
  'roundToDouble': NumericHint.rounding,
  'floorToDouble': NumericHint.rounding,
  'ceilToDouble': NumericHint.rounding,
  'truncateToDouble': NumericHint.rounding,
  'isNaN': NumericHint.specialValues,
  'isFinite': NumericHint.specialValues,
  'isInfinite': NumericHint.specialValues,
  'gcd': NumericHint.arithmetic,
  'modPow': NumericHint.arithmetic,
  'modInverse': NumericHint.arithmetic,
  'bitLength': NumericHint.bitManipulation,
  'toUnsigned': NumericHint.bitManipulation,
  'toSigned': NumericHint.bitManipulation,
  'toStringAsFixed': NumericHint.formatting,
  'toStringAsExponential': NumericHint.formatting,
  'toStringAsPrecision': NumericHint.formatting,
};

/// Generates targeted test inputs based on a [LogicProfile].
class DynamicInputGenerator {
  const DynamicInputGenerator();

  /// Returns a map of parameter name to a set of logic-derived literals.
  Map<String, Set<String>> generate(LogicProfile profile, List<Param> params) {
    final result = <String, Set<String>>{};

    for (final param in params) {
      final literals = profile.parameterLiterals[param.name] ?? {};
      final inferences = profile.parameterInferences[param.name] ?? {};
      final dynamicBoundaries = <String>{};

      for (final lit in literals) {
        dynamicBoundaries.add(lit);

        // Integer boundaries (value - 1, value, value + 1)
        if (param.type == ParamType.int_) {
          final val = int.tryParse(lit);
          if (val != null) {
            dynamicBoundaries.add('${val - 1}');
            dynamicBoundaries.add('${val + 1}');
          }
        }

        // String variations
        if (param.type == ParamType.string_) {
          dynamicBoundaries.add("''");

          // If we found an integer literal for a string parameter (e.g. from .length),
          // generate strings of that length.
          final val = int.tryParse(lit);
          if (val != null && val >= 0) {
            if (val > 0) dynamicBoundaries.add("'${'a' * (val - 1)}'");
            dynamicBoundaries.add("'${'a' * val}'");
            dynamicBoundaries.add("'${'a' * (val + 1)}'");
          }
        }
      }

      // API-based inferences
      for (final inf in inferences) {
        if (param.type == ParamType.string_) {
          final hint = _stringHints[inf];
          if (hint != null) {
            _addStringHintBoundaries(dynamicBoundaries, hint);
          }
        }
        if (param.type == ParamType.int_ || param.type == ParamType.double_ || param.type == ParamType.listInt_) {
          final hint = _numericHints[inf];
          if (hint != null) {
            _addNumericHintBoundaries(dynamicBoundaries, hint, param.type);
          }
        }
      }

      if (dynamicBoundaries.isNotEmpty) {
        result[param.name] = dynamicBoundaries;
      }
    }

    return result;
  }

  void _addStringHintBoundaries(Set<String> boundaries, StringHint hint) {
    switch (hint) {
      case StringHint.caseSensitive:
        boundaries.addAll(["'MIXED_case'", "'UPPERCASE'", "'lowercase'"]);
      case StringHint.whitespace:
        boundaries.addAll(["'  leading'", "'trailing  '", "'  both  '", r"'\t tab \n'"]);
      case StringHint.delimiter:
        boundaries.addAll(["','", "' '", "'|'", "';'"]);
      case StringHint.emptyString:
        boundaries.addAll(["''", "' '"]);
      case StringHint.lengthDependent:
        boundaries.addAll(["'a'", "'long string' * 10"]);
      case StringHint.substringMatch:
        boundaries.addAll(["'prefix'", "'suffix'", "'middle'"]);
      case StringHint.replacement:
        boundaries.addAll(["'old'", "'new'"]);
      case StringHint.padding:
        boundaries.addAll(["'x'", "'0'"]);
    }
  }

  void _addNumericHintBoundaries(Set<String> boundaries, NumericHint hint, ParamType type) {
    switch (hint) {
      case NumericHint.parity:
        boundaries.addAll(['1', '2']);
      case NumericHint.signDependent:
        boundaries.addAll(['-1', '0', '1']);
      case NumericHint.rounding:
        if (type == ParamType.double_) {
          boundaries.addAll(['0.1', '0.5', '0.9', '-0.5']);
        }
      case NumericHint.specialValues:
        if (type == ParamType.double_) {
          boundaries.addAll(['double.nan', 'double.infinity', 'double.negativeInfinity']);
        }
      case NumericHint.arithmetic:
        boundaries.addAll(['2', '3', '5', '7']);
      case NumericHint.bitManipulation:
        boundaries.addAll(['0', '1', '255', '-1']);
      case NumericHint.formatting:
        boundaries.addAll(['1.2345', '123456.789']);
    }
  }
}

```

## Файл: .\lib\src\application\generation_isolate.dart

```dart
import 'dart:isolate';

import 'package:dart_test_gen/gen_config.dart';
import 'package:dart_test_gen/snapshot.dart';

import '../generators/snapshot_unit_test_generator_module.dart';
import '../infrastructure/io_generation_filesystem.dart';
import 'generation_single_library.dart';
import 'snapshot_failure_formatting.dart';

/// Messages from the isolate (sendable types only).
abstract final class GenerationIsolateProtocol {
  static const msgProgress = 'p';
  static const msgVerbose = 'v';
  static const msgError = 'e';
  static const msgCheckFail = 'cf';
}

/// [isolateDoneSentinel] follows [isolateResultPrefix].
const isolateResultPrefix = '__dart_test_gen_result__';
const isolateDoneSentinel = '__dart_test_gen_isolate_done__';

Map<String, Object?> generationIsolateSpawnMessage({
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required GeneratorConfig config,
  required SendPort logPort,
}) =>
    <String, Object?>{
      'absoluteLibPath': absoluteLibPath,
      'packageRoot': packageRoot,
      'packageName': packageName,
      'className': className,
      'displayLabel': displayLabel,
      'verbose': verbose,
      'config': config,
      'logPort': logPort,
    };

@pragma('vm:entry-point')
Future<void> generationIsolateMain(Map<String, Object?> message) async {
  final path = message['absoluteLibPath']! as String;
  final root = message['packageRoot']! as String;
  final pkg = message['packageName']! as String;
  final className = message['className'] as String?;
  final displayLabel = message['displayLabel']! as String;
  final verbose = message['verbose']! as bool;
  final config = message['config']! as GeneratorConfig;
  final port = message['logPort']! as SendPort;

  void bridge({double? progress, String? line, bool? error}) {
    final isErr = error == true;
    if (progress != null) {
      port.send(<String, Object?>{
        't': GenerationIsolateProtocol.msgProgress,
        'l': displayLabel,
        'pct': progress,
      });
    }
    if (line != null && (verbose || isErr)) {
      port.send(<String, Object?>{
        't': isErr ? GenerationIsolateProtocol.msgError : GenerationIsolateProtocol.msgVerbose,
        'm': line,
      });
    }
  }

  var ok = false;
  try {
    final checkFailure = await generateSingleLibraryFile(
      filesystem: IoGenerationFilesystem(),
      generator: const SnapshotUnitTestGeneratorModule(),
      absoluteLibPath: path,
      packageRoot: root,
      packageName: pkg,
      className: className,
      displayLabel: displayLabel,
      verbose: verbose,
      config: config,
      emit: bridge,
    );
    if (checkFailure != null) {
      port.send(<String, Object?>{'t': GenerationIsolateProtocol.msgCheckFail, 's': checkFailure.summary});
    }
    ok = true;
  } on SnapshotRunnerFailure catch (f) {
    bridge(line: formatSnapshotRunnerFailure(f), error: true);
  } catch (e, st) {
    bridge(
      line: 'ERROR\t$e\n$st\n',
      error: true,
    );
  }
  port.send('$isolateResultPrefix:${ok ? "ok" : "fail"}');
  port.send(isolateDoneSentinel);
}

```

## Файл: .\lib\src\application\generation_single_library.dart

```dart
import 'package:dart_test_gen/gen_config.dart';

import '../domain/check_failure.dart';
import '../domain/generator_module.dart';
import '../ports/generation_filesystem.dart';

/// Runs generation for a single library file via a [GeneratorModule].
///
/// Returns a [CheckFailure] when `config.check` is true and the generated
/// content differs from the existing test file; returns `null` otherwise.
Future<CheckFailure?> generateSingleLibraryFile({
  required GenerationFilesystem filesystem,
  required GeneratorModule generator,
  required String absoluteLibPath,
  required String packageRoot,
  required String packageName,
  required String? className,
  required String displayLabel,
  required bool verbose,
  required GeneratorConfig config,
  required EmitGenerationUi emit,
}) async {
  final ctx = GeneratorRunContext(
    absoluteLibPath: absoluteLibPath,
    packageRoot: packageRoot,
    packageName: packageName,
    className: className,
    displayLabel: displayLabel,
    verbose: verbose,
    config: config,
    fs: filesystem,
    emit: emit,
  );
  final outcome = await generator.run(ctx);
  if (outcome is GeneratorRunCheckMismatch) {
    return outcome.failure;
  }
  return null;
}

```

## Файл: .\lib\src\application\method_logic_analyzer.dart

```dart
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import '../domain/logic_profile.dart';

/// Analyzes a method body to extract logic-derived test hints.
class MethodLogicAnalyzer {
  const MethodLogicAnalyzer();

  LogicProfile analyze(AstNode? body, List<String> paramNames) {
    if (body == null) return LogicProfile.empty();

    final literals = <String, Set<String>>{};
    final inferences = <String, Set<String>>{};

    for (final name in paramNames) {
      literals[name] = {};
      inferences[name] = {};
      body.accept(_LogicVisitor(name, literals[name]!, inferences[name]!));
    }

    return LogicProfile(
      parameterLiterals: literals,
      parameterInferences: inferences,
    );
  }
}

class _LogicVisitor extends RecursiveAstVisitor<void> {
  final String paramName;
  final Set<String> literals;
  final Set<String> inferences;

  _LogicVisitor(this.paramName, this.literals, this.inferences);

  @override
  void visitBinaryExpression(BinaryExpression node) {
    final left = _unwrapParens(node.leftOperand);
    final right = _unwrapParens(node.rightOperand);

    if (_tracesToParam(left)) {
      _extractLiteral(right);
    } else if (_tracesToParam(right)) {
      _extractLiteral(left);
    }

    super.visitBinaryExpression(node);
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    final target = _unwrapParens(node.expression);
    if (_isParam(target)) {
      for (final member in node.members) {
        if (member is SwitchCase) {
          _extractLiteral(member.expression);
        } else if (member is SwitchPatternCase) {
          final pattern = member.guardedPattern.pattern;
          if (pattern is ConstantPattern) {
            _extractLiteral(pattern.expression);
          }
        }
      }
    }
    super.visitSwitchStatement(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    if (target != null && _tracesToParam(_unwrapParens(target))) {
      inferences.add(node.methodName.name);
    }
    super.visitMethodInvocation(node);
  }

  bool _isParam(Expression e) {
    return e is SimpleIdentifier && e.name == paramName;
  }

  bool _tracesToParam(Expression e) {
    var current = _unwrapParens(e);
    while (current is MethodInvocation || current is PropertyAccess || current is PrefixedIdentifier) {
      if (current is MethodInvocation) {
        final target = current.target;
        if (target == null) return false;
        current = _unwrapParens(target);
      } else if (current is PropertyAccess) {
        final target = current.target;
        if (target == null) return false;
        current = _unwrapParens(target);
      } else if (current is PrefixedIdentifier) {
        current = current.prefix;
      }
    }
    return _isParam(current);
  }

  void _extractLiteral(Expression e) {
    final u = _unwrapParens(e);
    if (u is Literal) {
      literals.add(u.toSource());
    } else if (u is PrefixExpression && u.operator.lexeme == '-') {
      final inner = _unwrapParens(u.operand);
      if (inner is Literal) {
        literals.add(u.toSource());
      }
    }
  }

  Expression _unwrapParens(Expression e) {
    var x = e;
    while (x is ParenthesizedExpression) {
      x = x.expression;
    }
    return x;
  }
}

```

## Файл: .\lib\src\application\snapshot_failure_formatting.dart

```dart
import 'package:dart_test_gen/snapshot.dart';

/// Structured, user-facing rendering of a [SnapshotRunnerFailure].
String formatSnapshotRunnerFailure(SnapshotRunnerFailure f) {
  final ctx = StringBuffer('[${f.absoluteLibPath}');
  if (f.className != null) {
    ctx.write(' ${f.className}');
    if (f.methodName != null) ctx.write('.${f.methodName}');
    ctx.write(']');
  } else {
    ctx.write(']');
  }
  final tail = f.dartStderrTail.trimRight();
  final indentedTail = tail.isEmpty ? '    <empty>' : tail.split('\n').map((l) => '    $l').join('\n');
  return [
    'Snapshot runner failed (${f.stage}) for $ctx',
    '  runner kept at: ${f.runnerPath}',
    if (f.exitCode != null) '  dart exit code: ${f.exitCode}',
    '  dart stderr (tail):',
    indentedTail,
    '  hints:',
    '    - re-run with -v for the full log',
    '    - open the runner file to inspect the generated snapshot code',
    '    - if this looks like a generator bug, attach the runner file to the report',
    '',
  ].join('\n');
}

```

## Файл: .\lib\src\application\snapshot_unit_test_generation.dart

```dart
import 'dart:io';

import 'package:path/path.dart' as p;

import 'package:dart_test_gen/cli_log.dart';
import 'package:dart_test_gen/resolved_dependencies.dart';
import 'package:dart_test_gen/sampling.dart';
import 'package:dart_test_gen/snapshot.dart';
import 'package:dart_test_gen/source_parser.dart';
import 'package:dart_test_gen/test_generator.dart';

import '../domain/check_failure.dart';
import '../domain/generator_module.dart';
import '../ports/generation_filesystem.dart';

String buildGenerationCheckSummary(String testPath, String? existingContent, String generatedNormalized) {
  if (existingContent == null) {
    return '[check] differs: $testPath\n  expected: <missing>\n';
  }
  final existingLines = existingContent.split('\n');
  final generatedLines = generatedNormalized.split('\n');
  final maxLen = existingLines.length > generatedLines.length ? existingLines.length : generatedLines.length;
  for (var i = 0; i < maxLen; i++) {
    final ex = i < existingLines.length ? existingLines[i] : '<EOF>';
    final gen = i < generatedLines.length ? generatedLines[i] : '<EOF>';
    if (ex != gen) {
      const maxWidth = 160;
      final exTrunc = ex.length > maxWidth ? '${ex.substring(0, maxWidth)}…' : ex;
      final genTrunc = gen.length > maxWidth ? '${gen.substring(0, maxWidth)}…' : gen;
      final absPath = p.normalize(p.absolute(testPath));
      return '[check] differs: $testPath\n'
          '  expected: $absPath\n'
          '  first diff at line ${i + 1}:\n'
          '    -- existing: $exTrunc\n'
          '    ++ generated: $genTrunc\n';
    }
  }
  return '';
}

/// Snapshot-driven unit test generation for one library file.
Future<GeneratorRunOutcome> runSnapshotUnitTestGeneration(GeneratorRunContext ctx) async {
  final absoluteLibPath = ctx.absoluteLibPath;
  final packageRoot = ctx.packageRoot;
  final packageName = ctx.packageName;
  final className = ctx.className;
  final displayLabel = ctx.displayLabel;
  final verbose = ctx.verbose;
  final config = ctx.config;
  final emit = ctx.emit;
  final fs = ctx.fs;

  void v(String phase, String detail) {
    if (!verbose) return;
    emit(line: '[$displayLabel]\t$phase\t$detail\n');
  }

  emit(progress: 5);
  v('init', absoluteLibPath);

  final mergePaths = await resolveReferencedLibAbsolutePaths(
    packageRoot: packageRoot,
    packageName: packageName,
    absoluteLibPath: absoluteLibPath,
    className: className,
  );

  final parsed = parseLibraryClassOptional(
    absoluteLibPath,
    className: className,
    mergeLibAbsolutePaths: mergePaths,
  );
  if (parsed == null) {
    emit(progress: 100);
    v('skip', 'no class with supportable methods');
    return GeneratorRunSkipped();
  }
  emit(progress: 14);
  v('parse', 'class=${parsed.className}, methods=${parsed.methods.length}');

  final extraPackageImports = mergePaths.map((path) => packageImportUri(packageRoot, packageName, path)).toList()
    ..sort();

  const snapStart = 14.0;
  const snapWidth = 54.0;

  final snapshots = runSnapshots(
    packageRoot: packageRoot,
    packageName: packageName,
    absoluteLibPath: absoluteLibPath,
    parsed: parsed,
    extraPackageImports: extraPackageImports,
    logLabel: displayLabel,
    onSnapshotFraction: (f) => emit(progress: snapStart + snapWidth * f),
    onVerboseLine: verbose
        ? (ln) {
            emit(line: ln);
          }
        : null,
    onRunnerFailed: verbose
        ? (se, so) {
            emit(
              line: 'snapshot runner stderr:\n$se\nsnapshot runner stdout:\n$so\n',
              error: true,
            );
          }
        : null,
    keepRunner: config.keepRunner,
  );
  if (config.keepRunner) {
    v('snapshot', 'runner kept (per --keep-runner)');
  }

  emit(progress: 72);
  v('snapshot', 'decode OK');

  if (snapshots.length != parsed.methods.length) {
    throw StateError('snapshot count does not match parsed methods');
  }

  final methods = <MethodSpec>[];
  for (var i = 0; i < parsed.methods.length; i++) {
    final m = parsed.methods[i];
    final snap = snapshots[i];
    if (snap.methodName != m.name) {
      throw StateError('snapshot method name does not match parsed method');
    }
    final rows = <TestCaseRow>[];
    for (final r in snap.rows) {
      if (r.throwsExceptionType != null) {
        rows.add(
          TestCaseRow(
            argLiterals: r.argLiterals,
            throwsType: r.throwsExceptionType,
          ),
        );
      } else if (m.snapshotReturnType == 'void') {
        rows.add(TestCaseRow(argLiterals: r.argLiterals));
      } else {
        final lit = r.expectedDartLiteral;
        if (lit == null) {
          throw StateError('Missing expectedDartLiteral for ${m.name}');
        }
        rows.add(TestCaseRow(argLiterals: r.argLiterals, expectedLiteral: lit));
      }
    }

    final sampledRows = sampleTestCases(rows, config.forMethod(m.name));

    final methodConfig = config.forMethod(m.name);
    methods.add(
      MethodSpec(
        name: m.name,
        params: m.params,
        returnType: m.returnType,
        snapshotReturnType: m.snapshotReturnType,
        isAsync: m.isAsync,
        isStream: m.isStream,
        isStatic: m.isStatic,
        isFactory: m.isFactory,
        kind: m.kind,
        useCloseForDouble: methodConfig.useCloseForDouble,
        doubleEpsilon: methodConfig.doubleEpsilon,
        useExpectMatchersBoolNull: methodConfig.useExpectMatchersBoolNull,
        testCases: sampledRows,
      ),
    );
  }

  emit(progress: 78);
  final testOut = testOutputPathForLib(packageRoot, absoluteLibPath);
  final importPath = packageImportUri(packageRoot, packageName, absoluteLibPath);
  v('render', importPath);

  ClassInfo? receiverInfo;
  for (final c in parsed.allFileClasses) {
    if (c.name == parsed.className) {
      receiverInfo = c;
      break;
    }
  }
  final receiverInstantiation = receiverInfo != null ? instantiationExpressionForClass(receiverInfo) : null;

  final content = generateTestFile(
    className: parsed.className,
    importPath: importPath,
    extraImports: extraPackageImports,
    methods: methods,
    receiverInstantiation: receiverInstantiation,
  );

  emit(progress: 90);

  if (config.dryRun) {
    CliLog.out(testOut);
    if (verbose) emit(line: content);
    emit(progress: 100);
    v('dry-run', testOut);
    return GeneratorRunSuccess();
  }

  if (config.check) {
    final existingContent = fs.fileExistsSync(testOut) ? fs.readFileAsStringSync(testOut) : null;
    final normalizedExisting = existingContent != null ? stripGeneratedTimestamp(existingContent) : null;
    final normalizedGenerated = stripGeneratedTimestamp(content);
    if (normalizedExisting == normalizedGenerated) {
      emit(progress: 100);
      v('check', 'ok: $testOut');
      return GeneratorRunSuccess();
    }
    final summary = buildGenerationCheckSummary(testOut, normalizedExisting, normalizedGenerated);
    emit(progress: 100);
    v('check', 'differs: $testOut');
    return GeneratorRunCheckMismatch(CheckFailure(testPath: testOut, summary: summary));
  }

  fs.writeFileSyncEnsuringParents(testOut, content);
  emit(progress: 100);
  v('done', testOut);
  return GeneratorRunSuccess();
}

/// `lib/a/b.dart` → `test/a/b_test.dart`
String testOutputPathForLib(String packageRoot, String absoluteLibPath) {
  final libRoot = p.join(packageRoot, 'lib');
  final rel = p.relative(absoluteLibPath, from: libRoot);
  if (rel.startsWith('..')) {
    throw StateError('File must be under $libRoot, got: $absoluteLibPath');
  }
  final dir = p.dirname(rel);
  final base = p.basenameWithoutExtension(rel);
  final testTail = dir == '.' ? '${base}_test.dart' : p.join(dir, '${base}_test.dart');
  return p.join(packageRoot, 'test', testTail);
}

String shortLibLabel(String absoluteLibPath, String packageRoot) {
  final libRoot = p.join(packageRoot, 'lib');
  try {
    return p.relative(absoluteLibPath, from: libRoot).replaceAll(r'\', '/');
  } catch (_) {
    return p.basename(absoluteLibPath);
  }
}

String _absolute(String cwd, String userPath) {
  final normalized = p.normalize(userPath);
  if (p.isAbsolute(normalized)) return normalized;
  return p.normalize(p.join(cwd, normalized));
}

/// Expands files and directories into a sorted list of absolute `.dart` paths.
List<String> expandGenerationTargetsWithFs(GenerationFilesystem fs, String cwd, List<String> inputs) {
  final seen = <String>{};
  final out = <String>[];
  for (final raw in inputs) {
    final abs = _absolute(cwd, raw);
    final kind = fs.pathKind(abs);
    if (kind == PathNodeKind.notFound) {
      CliLog.err('Path not found: $abs');
      exit(1);
    }
    if (kind == PathNodeKind.file) {
      if (!abs.endsWith('.dart')) {
        CliLog.err('Expected a .dart file: $abs');
        exit(1);
      }
      if (seen.add(abs)) out.add(abs);
      continue;
    }
    if (kind == PathNodeKind.directory) {
      for (final f in fs.dartFilesUnderDirectory(abs)) {
        if (seen.add(f)) out.add(f);
      }
      continue;
    }
    CliLog.err('Unsupported path type: $abs');
    exit(1);
  }
  return out;
}

```

## Файл: .\lib\src\domain\check_failure.dart

```dart
/// Holds the diff summary for a single `--check` failure.
class CheckFailure {
  final String testPath;
  final String summary;
  const CheckFailure({required this.testPath, required this.summary});
}

```

## Файл: .\lib\src\domain\generator_module.dart

```dart
import 'package:dart_test_gen/gen_config.dart';

import '../ports/generation_filesystem.dart';
import 'check_failure.dart';

/// UI callback: progress 0–100 and a detail line; [error]==true always goes to stderr.
typedef EmitGenerationUi = void Function({double? progress, String? line, bool? error});

/// Built-in generator: snapshot-driven unit tests for library members.
const String kDefaultGeneratorModuleId = 'snapshot_unit_test';

sealed class GeneratorRunOutcome {}

/// Parsed library had no supported class/methods — nothing to emit.
final class GeneratorRunSkipped extends GeneratorRunOutcome {}

/// Wrote or validated output; no `--check` mismatch.
final class GeneratorRunSuccess extends GeneratorRunOutcome {}

/// `--check` found a diff vs disk.
final class GeneratorRunCheckMismatch extends GeneratorRunOutcome {
  final CheckFailure failure;
  GeneratorRunCheckMismatch(this.failure);
}

/// Inputs for one generator run (one library file).
class GeneratorRunContext {
  final String absoluteLibPath;
  final String packageRoot;
  final String packageName;
  final String? className;
  final String displayLabel;
  final bool verbose;
  final GeneratorConfig config;
  final GenerationFilesystem fs;
  final EmitGenerationUi emit;

  const GeneratorRunContext({
    required this.absoluteLibPath,
    required this.packageRoot,
    required this.packageName,
    required this.className,
    required this.displayLabel,
    required this.verbose,
    required this.config,
    required this.fs,
    required this.emit,
  });
}

/// Pluggable code generator (e.g. snapshot unit tests; future modules register alongside).
abstract class GeneratorModule {
  String get id;

  Future<GeneratorRunOutcome> run(GeneratorRunContext ctx);
}

```

## Файл: .\lib\src\domain\logic_profile.dart

```dart
/// Profile of the logic extracted from a method body.
class LogicProfile {
  /// Literals found in the method body, grouped by parameter name.
  final Map<String, Set<String>> parameterLiterals;

  /// Inferred characteristics of parameters based on API calls.
  /// E.g., 'input' -> {'toLowerCase', 'trim'}
  final Map<String, Set<String>> parameterInferences;

  const LogicProfile({
    required this.parameterLiterals,
    required this.parameterInferences,
  });

  factory LogicProfile.empty() => const LogicProfile(
        parameterLiterals: {},
        parameterInferences: {},
      );
}

```

## Файл: .\lib\src\generators\snapshot_unit_test_generator_module.dart

```dart
import '../application/snapshot_unit_test_generation.dart';
import '../domain/generator_module.dart';

/// Built-in module: snapshot-driven unit tests.
final class SnapshotUnitTestGeneratorModule implements GeneratorModule {
  const SnapshotUnitTestGeneratorModule();

  @override
  String get id => kDefaultGeneratorModuleId;

  @override
  Future<GeneratorRunOutcome> run(GeneratorRunContext ctx) => runSnapshotUnitTestGeneration(ctx);
}

```

## Файл: .\lib\src\infrastructure\io_generation_filesystem.dart

```dart
import 'dart:io';

import 'package:path/path.dart' as p;

import '../ports/generation_filesystem.dart';

/// Default [GenerationFilesystem] using `dart:io`.
final class IoGenerationFilesystem implements GenerationFilesystem {
  @override
  String get currentWorkingDirectory => Directory.current.path;

  @override
  PathNodeKind pathKind(String absolutePath) {
    final normalized = p.normalize(absolutePath);
    final type = FileSystemEntity.typeSync(normalized);
    return switch (type) {
      FileSystemEntityType.file => PathNodeKind.file,
      FileSystemEntityType.directory => PathNodeKind.directory,
      FileSystemEntityType.notFound => PathNodeKind.notFound,
      _ => PathNodeKind.unsupported,
    };
  }

  @override
  List<String> dartFilesUnderDirectory(String directoryAbsolute) {
    final root = Directory(directoryAbsolute);
    final out = <String>[];
    if (!root.existsSync()) return out;
    for (final entity in root.listSync(recursive: true, followLinks: false)) {
      if (entity is! File) continue;
      if (!p.basename(entity.path).endsWith('.dart')) continue;
      out.add(p.normalize(entity.path));
    }
    out.sort();
    return out;
  }

  @override
  bool fileExistsSync(String absoluteFilePath) => File(absoluteFilePath).existsSync();

  @override
  String readFileAsStringSync(String absoluteFilePath) => File(absoluteFilePath).readAsStringSync();

  @override
  void writeFileSyncEnsuringParents(String absoluteFilePath, String content) {
    final file = File(absoluteFilePath);
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
  }
}

```

## Файл: .\lib\src\ports\generation_filesystem.dart

```dart
/// Resolved node kind for path expansion (no `dart:io` types on the port).
enum PathNodeKind {
  file,
  directory,
  notFound,
  unsupported,
}

/// Filesystem boundary for generation (expand targets, read/write tests).
abstract class GenerationFilesystem {
  /// Current working directory (e.g. `Directory.current.path`).
  String get currentWorkingDirectory;

  PathNodeKind pathKind(String absolutePath);

  /// All `.dart` files under [directoryAbsolute] (recursive), sorted, normalized paths.
  List<String> dartFilesUnderDirectory(String directoryAbsolute);

  bool fileExistsSync(String absoluteFilePath);

  String readFileAsStringSync(String absoluteFilePath);

  void writeFileSyncEnsuringParents(String absoluteFilePath, String content);
}

```

## Файл: .\lib\src\README.md

```md
# `lib/src/` layout

This package keeps **stable** `package:dart_test_gen/<name>.dart` entrypoints at `lib/*.dart` while implementation moves under `lib/src/` by layer.

## Layers (dependency direction: entry → application → domain & ports ← infrastructure)

| Folder | Role |
|--------|------|
| `domain/` | Core types with no I/O: generator contract, check failure DTO. |
| `ports/` | Abstract boundaries (`GenerationFilesystem`) — no `dart:io` / `dart:isolate`. |
| `application/` | Orchestration and use-cases: CLI run, path expansion, snapshot unit-test generation. |
| `infrastructure/` | Adapters: real filesystem backed by `dart:io`. |
| `generators/` | Concrete `GeneratorModule` implementations (today: snapshot unit tests). |
| `wiring/` | Composition root: default adapters and module registration. |

## Import graph (pre-refactor public consumers)

Entrypoints imported from `bin/` and `test/`:

- `package:dart_test_gen/cli_help.dart`
- `package:dart_test_gen/generate_pipeline.dart`
- `package:dart_test_gen/test_generator.dart`
- `package:dart_test_gen/gen_config.dart`
- `package:dart_test_gen/source_parser.dart`
- `package:dart_test_gen/snapshot.dart`
- `package:dart_test_gen/sampling.dart`

Internal `lib/` graph (high level):

- `generate_pipeline.dart` → `cli_*`, `gen_config`, `resolved_dependencies`, `sampling`, `snapshot`, `source_parser`, `test_generator`
- `snapshot.dart` → `source_parser`, `test_generator`
- `source_parser.dart` → `test_generator` (params / `MethodKind`)
- `sampling.dart` → `gen_config`, `test_generator`
- `resolved_dependencies.dart` → `source_parser`

After this change, `generate_pipeline.dart` stays the façade for CLI helpers and delegates orchestration to `src/application/cli_generation_orchestrator.dart` and generation to `src/generators/`.

```

## Файл: .\lib\src\wiring\app_dependencies.dart

```dart
import '../domain/generator_module.dart';
import '../generators/snapshot_unit_test_generator_module.dart';
import '../infrastructure/io_generation_filesystem.dart';
import '../ports/generation_filesystem.dart';

/// Composition root: default filesystem and registered generator modules.
final class AppDependencies {
  AppDependencies({
    required this.filesystem,
    required List<GeneratorModule> modules,
  }) : modules = List<GeneratorModule>.unmodifiable(modules);

  final GenerationFilesystem filesystem;
  final List<GeneratorModule> modules;

  GeneratorModule get defaultGenerator =>
      modules.firstWhere((m) => m.id == kDefaultGeneratorModuleId, orElse: () => modules.first);

  /// Production wiring (real I/O, built-in snapshot unit-test generator).
  factory AppDependencies.production() {
    final fs = IoGenerationFilesystem();
    return AppDependencies(
      filesystem: fs,
      modules: const [SnapshotUnitTestGeneratorModule()],
    );
  }
}

```

## Файл: .\lib\test_generator.dart

```dart
enum MethodKind {
  method,
  getter,
  setter,
  operator_,
}

enum ParamType {
  int_,
  double_,
  bool_,
  string_,
  dynamic_,
  listInt_,
  listString_,
  setInt_,
  iterableInt_,
  enum_,
  custom_,
}

class Param {
  final String name;
  final ParamType type;

  /// When set (e.g. enum cases), these override the default boundary values.
  final List<String>? literalValues;

  final bool isNullable;
  final bool isNamed;
  final bool isOptionalPositional;
  final String? defaultValueCode;

  const Param(
    this.name,
    this.type, {
    this.literalValues,
    this.isNullable = false,
    this.isNamed = false,
    this.isOptionalPositional = false,
    this.defaultValueCode,
  });
}

/// One test-case row after snapshotting.
class TestCaseRow {
  final List<String> argLiterals;
  final String? expectedLiteral;
  final String? throwsType;

  const TestCaseRow({
    required this.argLiterals,
    this.expectedLiteral,
    this.throwsType,
  });
}

/// Descriptor for one method, used for test generation.
class MethodSpec {
  final String name;
  final List<Param> params;
  final String returnType;

  /// Value type for `expect` / void checks (`Future<T>` → `T`, `Stream<T>` → `List<T>`).
  final String snapshotReturnType;

  final bool isAsync;
  final bool isStream;
  final bool isStatic;
  final bool isFactory;
  final MethodKind kind;

  /// From config: when true and [snapshotReturnType] is `double`, emit `closeTo`.
  final bool useCloseForDouble;

  /// Absolute epsilon for generated `closeTo` when [useCloseForDouble] is true.
  final double doubleEpsilon;

  /// From config: when true, bool/null literals use `isTrue` / `isFalse` / `isNull`.
  final bool useExpectMatchersBoolNull;

  final List<TestCaseRow> testCases;

  const MethodSpec({
    required this.name,
    required this.params,
    required this.returnType,
    required this.snapshotReturnType,
    this.isAsync = false,
    this.isStream = false,
    this.isStatic = false,
    this.isFactory = false,
    this.kind = MethodKind.method,
    this.useCloseForDouble = false,
    this.doubleEpsilon = 1e-9,
    this.useExpectMatchersBoolNull = true,
    required this.testCases,
  });
}

const Map<ParamType, List<String>> _boundaryValues = {
  ParamType.int_: ['0', '1', '-1', '2', '-2', '10', '-10'],
  ParamType.double_: ['0.0', '1.0', '-1.0', '0.5', '-0.5'],
  ParamType.bool_: ['true', 'false'],
  ParamType.string_: ["''", "'hello'", "'  '"],
  ParamType.dynamic_: ['0', "'str'"],
  ParamType.listInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  // Compact sets: same semantic boundaries as listInt_/string_, without extra combinatorics.
  ParamType.listString_: ['<String>[]', "['']", "['hello']"],
  ParamType.setInt_: ['<int>{}', '{0}', '{-1, 1}'],
  ParamType.iterableInt_: ['<int>[]', '[0]', '[1, -1, 2]'],
  ParamType.enum_: const [], // only with literalValues
  ParamType.custom_: const [], // only with literalValues
};

/// Descriptive `test('…')` titles include the expected value; cap length so runners stay readable.
const int _kMaxDescriptiveTestTitleLength = 220;

List<List<String>> generateBoundaryCases(List<Param> params) {
  if (params.isEmpty) return [[]];

  List<List<String>> result = [[]];
  for (final param in params) {
    final values = <String>{};

    // Always add standard boundaries for primitive types
    final defaults = _boundaryValues[param.type];
    if (defaults != null && defaults.isNotEmpty) {
      values.addAll(defaults);
    }

    // Add literals specific to the parameter (from AST or enum)
    if (param.literalValues != null) {
      values.addAll(param.literalValues!);
    }

    if (param.isNullable) {
      values.add('null');
    }
    if (param.defaultValueCode != null) {
      values.add(param.defaultValueCode!);
    }
    if (param.isNamed || param.isOptionalPositional) {
      values.add('__OMITTED__');
    }

    final valuesList = values.toList();
    result = [
      for (final existing in result)
        for (final val in valuesList)
          if (_isValidCombination(existing, val, params)) [...existing, val],
    ];
  }
  return result;
}

bool _isValidCombination(List<String> existing, String newVal, List<Param> params) {
  final nextIdx = existing.length;
  final param = params[nextIdx];

  if (param.isOptionalPositional) {
    // If the current arg is not omitted but a previous optional positional was omitted — invalid.
    if (newVal != '__OMITTED__') {
      for (var i = 0; i < existing.length; i++) {
        if (params[i].isOptionalPositional && existing[i] == '__OMITTED__') {
          return false;
        }
      }
    }
  }
  return true;
}

String _argLabel(List<Param> params, List<String> args) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final p = params[i];
    final val = args[i];
    if (val == '__OMITTED__') continue;
    if (p.isNamed) {
      parts.add('${p.name}: $val');
    } else {
      parts.add(val);
    }
  }
  return parts.join(', ');
}

/// Name in `test('…')`: escape `'` and `\` in argument labels (`'hello'`, etc.).
String _escapeSingleQuoted(String s) => s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");

String _inputDeclarations(List<Param> params, List<String> argLiterals) {
  final buf = StringBuffer();
  for (var i = 0; i < params.length; i++) {
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    buf.writeln('      final ${params[i].name} = $val;');
  }
  return buf.toString().trimRight();
}

String _callArgs(List<Param> params, List<String> argLiterals) {
  final parts = <String>[];
  for (var i = 0; i < params.length; i++) {
    final p = params[i];
    final val = argLiterals[i];
    if (val == '__OMITTED__') continue;
    if (p.isNamed) {
      parts.add('${p.name}: ${p.name}');
    } else {
      parts.add(p.name);
    }
  }
  return parts.join(', ');
}

String _operatorTestExpression(String recv, String op, List<Param> params, List<String> argLiterals) {
  String nameAt(int i) {
    if (i >= argLiterals.length || argLiterals[i] == '__OMITTED__') {
      throw StateError('operator $op: missing arg at index $i');
    }
    return params[i].name;
  }

  switch (op) {
    case '[]':
      return '$recv[${nameAt(0)}]';
    case '[]=':
      return '$recv[${nameAt(0)}] = ${nameAt(1)}';
    case '~':
      return '~$recv';
    case '-':
      if (params.isEmpty) return '-$recv';
      return '$recv - ${nameAt(0)}';
    default:
      return '$recv $op ${nameAt(0)}';
  }
}

/// Synchronous invocation expression for the test (before `await` when async).
String _syncInvokeExpression(
  String className,
  MethodSpec spec,
  String callArgs,
  List<String> argLiterals,
) {
  final instance = className.toLowerCase();
  if (spec.isFactory) {
    if (spec.name.isEmpty) {
      return '$className($callArgs)';
    }
    return '$className.${spec.name}($callArgs)';
  }
  final recv = spec.isStatic ? className : instance;
  switch (spec.kind) {
    case MethodKind.getter:
      return '$recv.${spec.name}';
    case MethodKind.setter:
      return '$recv.${spec.name} = $callArgs';
    case MethodKind.operator_:
      return _operatorTestExpression(recv, spec.name, spec.params, argLiterals);
    case MethodKind.method:
      return '$recv.${spec.name}($callArgs)';
  }
}

/// Prefix for `group` and test titles: getter/setter with the same name and operators stay distinct.
String _testGroupName(MethodSpec spec) {
  switch (spec.kind) {
    case MethodKind.getter:
      return 'getter ${spec.name}';
    case MethodKind.setter:
      return 'setter ${spec.name}';
    case MethodKind.operator_:
      return 'operator ${spec.name}';
    case MethodKind.method:
      return spec.name;
  }
}

String _testCaseTitleArgs(MethodSpec spec, String label) {
  switch (spec.kind) {
    case MethodKind.getter:
      return 'getter ${spec.name}';
    case MethodKind.setter:
      return label.isEmpty ? 'setter ${spec.name}' : 'setter ${spec.name}($label)';
    case MethodKind.operator_:
      return label.isEmpty ? 'operator ${spec.name}' : 'operator ${spec.name}($label)';
    case MethodKind.method:
      return label.isEmpty ? spec.name : '${spec.name}($label)';
  }
}

String _expectedOutcomePhrase(String expectedLiteral, {required bool useClose}) {
  final e = expectedLiteral.trim();
  if (useClose) {
    return 'returns a value close to $e';
  }
  return 'returns $e';
}

/// Compact fragment is [_testCaseTitleArgs]; descriptive adds a `returns …` / `closeTo` phrase unless too long.
String _successTestTitle(MethodSpec spec, String label, String expectedLiteral, {required bool useClose}) {
  final invocationPart = _testCaseTitleArgs(spec, label);
  final outcome = _expectedOutcomePhrase(expectedLiteral, useClose: useClose);
  final descriptive = '$invocationPart $outcome';
  if (descriptive.length > _kMaxDescriptiveTestTitleLength) {
    return invocationPart;
  }
  return descriptive;
}

/// Instance getter `hashCode`: do not compare to the snapshot literal (unstable across processes);
/// instead assert consistency between two identically constructed objects.
bool _isInstanceHashCodeGetter(MethodSpec spec) =>
    spec.kind == MethodKind.getter && spec.name == 'hashCode' && !spec.isStatic && !spec.isFactory;

String _renderHashCodePairEqualityTest(String className, MethodSpec spec, String receiverExpr) {
  final title = _escapeSingleQuoted(_testCaseTitleArgs(spec, ''));
  if (spec.isAsync || spec.isStream) {
    return '''
    test('$title', () async {
      final left = $receiverExpr;
      final right = $receiverExpr;
      expect(await left.hashCode, await right.hashCode);
    });''';
  }
  return '''
    test('$title', () {
      final left = $receiverExpr;
      final right = $receiverExpr;
      expect(left.hashCode, right.hashCode);
    });''';
}

/// Second argument to `expect(actual, …)` for bool/null literals, or null for `expected` binding.
String? _successExpectMatcherSecondArg(MethodSpec spec, String expectedLiteral) {
  if (!spec.useExpectMatchersBoolNull) return null;
  final trimmed = expectedLiteral.trim();
  if (trimmed == 'null') return 'isNull';
  final rt = spec.snapshotReturnType.trim();
  if (rt == 'bool' || rt == 'bool?') {
    if (trimmed == 'true') return 'isTrue';
    if (trimmed == 'false') return 'isFalse';
  }
  return null;
}

String _renderSuccessTest(String className, MethodSpec spec, TestCaseRow row) {
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final syncCall = _syncInvokeExpression(className, spec, callArgs, row.argLiterals);

  final async = spec.isAsync || spec.isStream;
  final awaitedCall = spec.isStream ? 'await $syncCall.toList()' : 'await $syncCall';

  final titlePart = _testCaseTitleArgs(spec, label);
  if (spec.snapshotReturnType == 'void') {
    final title = _escapeSingleQuoted('$titlePart runs without error');
    if (async) {
      return '''
    test('$title', () async {
$inputs
      $awaitedCall;
    });''';
    }
    final voidBody = spec.kind == MethodKind.setter
        ? 'expect(() { $syncCall; }, returnsNormally);'
        : 'expect(() => $syncCall, returnsNormally);';
    return '''
    test('$title', () {
$inputs
      $voidBody
    });''';
  }

  final expected = row.expectedLiteral;
  if (expected == null) {
    throw StateError('expectedLiteral is null for ${spec.name}');
  }

  final useClose = spec.useCloseForDouble && spec.snapshotReturnType == 'double';
  final matcherSecond = useClose ? null : _successExpectMatcherSecondArg(spec, expected);
  final expectLine = useClose
      ? 'expect(actual, closeTo(expected, ${_doubleLiteralForGenerated(spec.doubleEpsilon)}));'
      : matcherSecond != null
      ? 'expect(actual, $matcherSecond);'
      : 'expect(actual, expected);';

  final expectedDecl = (useClose || matcherSecond == null) ? '      final expected = $expected;\n' : '';

  final titleOk = _escapeSingleQuoted(
    _successTestTitle(spec, label, expected, useClose: useClose),
  );

  if (async) {
    return '''
    test('$titleOk', () async {
$inputs
${expectedDecl}      final actual = $awaitedCall;
      $expectLine
    });''';
  }

  return '''
    test('$titleOk', () {
$inputs
${expectedDecl}      final actual = $syncCall;
      $expectLine
    });''';
}

String _doubleLiteralForGenerated(double d) {
  if (d.isNaN || d.isInfinite) return d.toString();
  return d.toString();
}

String _renderThrowsTest(String className, MethodSpec spec, TestCaseRow row) {
  final label = _argLabel(spec.params, row.argLiterals);
  final inputs = _inputDeclarations(spec.params, row.argLiterals);
  final callArgs = _callArgs(spec.params, row.argLiterals);
  final call = _syncInvokeExpression(className, spec, callArgs, row.argLiterals);

  final ex = row.throwsType ?? 'Object';
  final titlePart = _testCaseTitleArgs(spec, label);
  final title = _escapeSingleQuoted('$titlePart throws $ex');
  final async = spec.isAsync || spec.isStream;
  final thrown = spec.isStream ? '$call.toList()' : call;

  if (async) {
    return '''
    test('$title', () async {
$inputs
      await expectLater($thrown, throwsA(isA<$ex>()));
    });''';
  }

  final throwsBody = spec.kind == MethodKind.setter
      ? 'expect(() { $call; }, throwsA(isA<$ex>()));'
      : 'expect(() => $call, throwsA(isA<$ex>()));';

  return '''
    test('$title', () {
$inputs
      $throwsBody
    });''';
}

String generateTestFile({
  required String className,
  required String importPath,
  required List<MethodSpec> methods,
  List<String> extraImports = const [],
  /// Receiver constructor call (e.g. `Foo(a: 1)` when named parameters are required).
  String? receiverInstantiation,
}) {
  final buf = StringBuffer();

  buf.writeln("import 'package:test/test.dart';");
  buf.writeln("import '$importPath';");
  for (final imp in extraImports) {
    buf.writeln("import '$imp';");
  }
  buf.writeln();
  buf.writeln('// Auto-generated — do not edit manually');
  buf.writeln('// Generated: ${DateTime.now().toIso8601String()}');
  buf.writeln();
  buf.writeln('void main() {');
  final receiverExpr = receiverInstantiation ?? '$className()';
  bool needsInstance = methods.any((m) => !m.isStatic && !m.isFactory);
  if (needsInstance) {
    buf.writeln('  final ${className.toLowerCase()} = $receiverExpr;');
    buf.writeln();
  }

  for (final spec in methods) {
    buf.writeln("  group('${_escapeSingleQuoted(_testGroupName(spec))}', () {");

    if (_isInstanceHashCodeGetter(spec)) {
      buf.writeln(_renderHashCodePairEqualityTest(className, spec, receiverExpr));
    } else {
      for (final row in spec.testCases) {
        if (row.throwsType != null) {
          buf.writeln(_renderThrowsTest(className, spec, row));
        } else {
          buf.writeln(_renderSuccessTest(className, spec, row));
        }
      }
    }

    buf.writeln('  });');
    buf.writeln();
  }

  buf.writeln('}');
  return buf.toString();
}

/// Removes the generated timestamp banner line (English or legacy Cyrillic prefix).
/// All other lines are left unchanged. Idempotent.
String stripGeneratedTimestamp(String content) {
  return content
      .split('\n')
      .where((line) => !line.startsWith('// Generated:') && !line.startsWith('// Сгенерировано:'))
      .join('\n');
}

```

