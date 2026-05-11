## Context

The `dart_test_gen` tool parses Dart classes and generates unit tests using a snapshot approach (executing actual methods with varied arguments). Currently, getters, setters, and operators are skipped by `source_parser.dart` and `test_generator.dart`. Standardizing their test generation improves code coverage and DX. 

## Goals / Non-Goals

**Goals:**
- Identify and parse getters, setters, and operators in the target AST.
- Generate valid Dart test code representing these elements properly.
  - Getter: `expect(obj.property, expected);`
  - Setter: `obj.property = value;` (we may snapshot this call just to ensure no exceptions, or observe returned state if applicable. In Dart, setters return void. We should just test that they don't throw, and generate `obj.property = value;` statements).
  - Operator: `expect(obj + value, expected);` or similar syntax for operators like `==`, `<`, `>`, `[]`, `[]=`.
- Provide a full use-case for regression testing.

**Non-Goals:**
- Handling deeply nested property setters or chained getters.
- Simulating internal object state outside of the standard snapshot process.

## Decisions

- **Parsing Strategy**: In `source_parser.dart`, we currently iterate over `MethodDeclaration`. Getters and Setters might also appear as `MethodDeclaration` with `isGetter` / `isSetter` flags. We will parse them to `MethodInfo`. Operators also appear as `MethodDeclaration` with `isOperator`.
- **Snapshot Representation**: 
  - Getters act like methods with zero parameters.
  - Setters act like methods with exactly one parameter.
  - Operators act like methods with one parameter (for `+`, `-`, `==`, etc.) or more (for `[]=`).
  - We will record a special "kind" in `MethodInfo` to distinguish them during test generation. A new enum `MethodKind` (e.g., `method`, `getter`, `setter`, `operator`) can be introduced, or simply boolean flags.
- **Code Generation (`test_generator.dart`)**:
  - Based on the method kind, generate the specific invocation syntax instead of `actual = obj.methodName(...)`.

## Risks / Trade-offs

- [Risk] Custom operator syntax generation might be complex if not hardcoded (e.g., `[]=` requires `obj[arg1] = arg2;`).
  → Mitigation: Start with a hardcoded map of supported operators (like `+`, `-`, `*`, `/`, `==`, `[]`, `[]=`) and map their AST names to format strings.
- [Risk] Setters don't return values.
  → Mitigation: They should still be run in snapshots to capture exceptions. Test generation will just be `obj.prop = value;` without an `expect(actual, expected)`.