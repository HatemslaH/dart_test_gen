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