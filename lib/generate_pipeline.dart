import 'dart:io';

import 'package:path/path.dart' as p;

import 'snapshot.dart';
import 'source_parser.dart';
import 'test_generator.dart';

/// Разбор аргументов: путь к `lib/...dart` и опционально `--class Name`.
({String libPath, String? className}) parseCliArgs(List<String> args) {
  String? className;
  final rest = <String>[];
  for (var i = 0; i < args.length; i++) {
    final a = args[i];
    if (a == '--class' && i + 1 < args.length) {
      className = args[++i];
    } else {
      rest.add(a);
    }
  }
  if (rest.isEmpty) {
    stderr.writeln('Использование: dart run bin/generate.dart <lib/file.dart> [--class ClassName]');
    exit(64);
  }
  return (libPath: rest.first, className: className);
}

String _absoluteLibPath(String cwd, String userPath) {
  final normalized = p.normalize(userPath);
  if (p.isAbsolute(normalized)) return normalized;
  return p.normalize(p.join(cwd, normalized));
}

String _testOutputPath(String packageRoot, String absoluteLibPath) {
  final libRoot = p.join(packageRoot, 'lib');
  final rel = p.relative(absoluteLibPath, from: libRoot);
  if (rel.startsWith('..')) {
    throw StateError('Файл должен быть в каталоге lib: $absoluteLibPath');
  }
  final stem = p.basenameWithoutExtension(rel);
  return p.join(packageRoot, 'test', '${stem}_test.dart');
}

String _importForTestFile(String testFileAbs, String libFileAbs) {
  final rel = p.relative(libFileAbs, from: p.dirname(testFileAbs));
  return rel.replaceAll(r'\', '/');
}

/// Генерирует `test/<stem>_test.dart` для указанного файла в `lib/`.
void generateFromLibraryFile(List<String> args) {
  final parsedArgs = parseCliArgs(args);
  final cwd = Directory.current.path;
  final libAbs = _absoluteLibPath(cwd, parsedArgs.libPath);
  if (!File(libAbs).existsSync()) {
    stderr.writeln('Файл не найден: $libAbs');
    exit(1);
  }

  final packageRoot = findPackageRootForFile(libAbs);
  final packageName = readPackageName(packageRoot);

  final parsed = parseLibraryClass(libAbs, className: parsedArgs.className);
  final snapshots = runSnapshots(
    packageRoot: packageRoot,
    packageName: packageName,
    absoluteLibPath: libAbs,
    parsed: parsed,
  );

  if (snapshots.length != parsed.methods.length) {
    throw StateError('несогласованность снимков и методов');
  }

  final methods = <MethodSpec>[];
  for (var i = 0; i < parsed.methods.length; i++) {
    final m = parsed.methods[i];
    final snap = snapshots[i];
    if (snap.methodName != m.name) {
      throw StateError('несогласованность имён методов');
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
      } else if (m.returnType == 'void') {
        rows.add(TestCaseRow(argLiterals: r.argLiterals));
      } else {
        final lit = r.expectedDartLiteral;
        if (lit == null) {
          throw StateError('ожидался expectedDartLiteral для ${m.name}');
        }
        rows.add(TestCaseRow(argLiterals: r.argLiterals, expectedLiteral: lit));
      }
    }
    methods.add(
      MethodSpec(
        name: m.name,
        params: m.params,
        returnType: m.returnType,
        testCases: rows,
      ),
    );
  }

  final testOut = _testOutputPath(packageRoot, libAbs);
  final importPath = _importForTestFile(testOut, libAbs);
  final content = generateTestFile(
    className: parsed.className,
    importPath: importPath,
    methods: methods,
  );
  writeTestFile(testOut, content);
}
