## 1. Parser Updates

- [x] 1.1 Update `MethodInfo` in `lib/source_parser.dart` to include `isStatic` and `isFactory` flags.
- [x] 1.2 Modify `ClassInfo` in `lib/source_parser.dart` to include an `isExtensionType` flag.
- [x] 1.3 Update `parseSourceFile` in `lib/source_parser.dart` to extract `static` methods from classes.
- [x] 1.4 Update `parseSourceFile` in `lib/source_parser.dart` to extract `factory` constructors.
- [x] 1.5 Update `parseSourceFile` in `lib/source_parser.dart` to parse `ExtensionTypeDeclaration`s, their primary constructors, and their methods.

## 2. Code Generation Updates

- [x] 2.1 Update `generateSnapshotScript` in `lib/snapshot.dart` to correctly invoke static methods (e.g., `ClassName.methodName()`).
- [x] 2.2 Update `generateSnapshotScript` in `lib/snapshot.dart` to correctly invoke factory constructors.
- [x] 2.3 Update `generateSnapshotScript` in `lib/snapshot.dart` to correctly instantiate extension types and invoke their methods.
- [x] 2.4 Update `generateTestFile` in `lib/test_generator.dart` to use the correct invocation syntax for static methods, factory constructors, and extension types in the generated tests.

## 3. Showcase and Validation

- [x] 3.1 Create `lib/usecases/type_extensions_showcase/type_extensions_showcase.dart` with examples of static methods, factories, and extension types.
- [x] 3.2 Run the generator on the new showcase usecase.
- [x] 3.3 Verify that the generated tests in `test/usecases/type_extensions_showcase/type_extensions_showcase_test.dart` pass and cover all scenarios.
- [x] 3.4 Update `README.md` to mark the 5th TODO item as completed.