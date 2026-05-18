import 'dart:io';

import 'package:path/path.dart' as p;

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
