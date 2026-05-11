## Context

`dart_test_gen` relies on the `analyzer` package to parse Dart source code, extract classes and their methods, and then generate a snapshot runner that executes these methods with various boundary values. Currently, the parser and generator only support non-static methods of standard classes. To support static methods, factory constructors, and extension types, we need to update the parsing logic to identify these elements and update the code generation logic to use the correct invocation syntax (e.g., `ClassName.staticMethod()` instead of `instance.method()`).

## Goals / Non-Goals

**Goals:**
- Parse and extract static methods from classes.
- Parse and extract factory constructors from classes.
- Parse and extract extension types and their methods/constructors.
- Generate valid snapshot runner code that correctly invokes these static methods, factories, and extension type methods.
- Generate valid unit test code that matches the snapshot runner's invocation syntax.
- Create a comprehensive usecase (`lib/usecases/static_factory_extension_showcase/`) to validate these features.

**Non-Goals:**
- Support for getters, setters, and operators (this is a separate TODO item).
- Support for top-level functions (outside of any class or extension type).

## Decisions

1. **Parsing Logic Updates (`source_parser.dart`)**:
   - **Static Methods**: Modify the method extraction logic to include static methods. We will need to store a boolean flag `isStatic` in the `MethodInfo` class so the generator knows how to invoke it.
   - **Factory Constructors**: Treat factory constructors as a special kind of static method that returns an instance of the class. We will extract them and mark them appropriately (e.g., `isFactory`).
   - **Extension Types**: Add support for parsing `ExtensionTypeDeclaration`. Extension types have a primary constructor and can have methods. We will extract them into `ClassInfo` (or a similar structure) with a flag indicating it's an extension type.

2. **Code Generation Updates (`snapshot.dart` and `test_generator.dart`)**:
   - **Invocation Syntax**:
     - Non-static methods: `final instance = ClassName(...); final actual = instance.methodName(...);` (Current behavior)
     - Static methods: `final actual = ClassName.methodName(...);` (No instance creation needed)
     - Factory constructors: `final actual = ClassName.factoryName(...);` or `final actual = ClassName(...);`
     - Extension types: Handled similarly to classes for instantiation and method invocation, but we must ensure the representation type is correctly handled if needed.

3. **Usecase Creation**:
   - Create `lib/usecases/static_factory_extension_showcase/static_factory_extension_showcase.dart` containing examples of static methods, factory constructors, and extension types.

## Risks / Trade-offs

- **Risk**: Extension types are a relatively new Dart feature and might have edge cases in the analyzer API.
  - **Mitigation**: Rely on the latest `analyzer` package features and thoroughly test with the new usecase.
- **Risk**: Factory constructors might return private types or subtypes that are hard to serialize/deserialize in the snapshot.
  - **Mitigation**: We will treat the return type of the factory as the declared type (the class itself) and rely on the existing object serialization/snapshot logic.