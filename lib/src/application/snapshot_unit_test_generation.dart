import 'package:dart_test_gen/dart_test_gen.dart';
import 'package:path/path.dart' as p;

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
    SnapshotRunContext(
      packageRoot: packageRoot,
      packageName: packageName,
      absoluteLibPath: absoluteLibPath,
      parsed: parsed,
      processRunner: const IoProcessRunner(),
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
    ),
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
    if (verbose) emit(line: content);
    emit(progress: 100);
    v('dry-run', testOut);
    return GeneratorRunSuccess(emitStdoutLine: testOut);
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

/// Returns mandatory rows + sampled optional rows.
List<TestCaseRow> sampleTestCases(
  List<TestCaseRow> rows,
  MethodConfig cfg,
) {
  final mandatory = rows.where((r) => r.throwsType != null).toList();
  final optional = rows.where((r) => r.throwsType == null).toList();

  final selected = switch (cfg.strategy) {
    SamplingStrategy.full => truncateOptionalRows(optional, cfg.maxCases),
    SamplingStrategy.random => randomSampleOptionalRows(optional, cfg.maxCases, cfg.seed),
    SamplingStrategy.happyPath => optional.take(1).toList(),
  };

  return [...mandatory, ...selected];
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
      throw GenerationTargetError('Path not found: $abs');
    }
    if (kind == PathNodeKind.file) {
      if (!abs.endsWith('.dart')) {
        throw GenerationTargetError('Expected a .dart file: $abs');
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
    throw GenerationTargetError('Unsupported path type: $abs');
  }
  return out;
}

/// Built-in [GeneratorModule] for snapshot-driven unit tests.
///
/// Registered in [AppDependencies] and the generation isolate; delegates to
/// [runSnapshotUnitTestGeneration] so additional modules can coexist in the same registry.
final class SnapshotUnitTestGeneratorModule implements GeneratorModule {
  const SnapshotUnitTestGeneratorModule();

  @override
  String get id => kDefaultGeneratorModuleId;

  @override
  Future<GeneratorRunOutcome> run(GeneratorRunContext ctx) => runSnapshotUnitTestGeneration(ctx);
}
