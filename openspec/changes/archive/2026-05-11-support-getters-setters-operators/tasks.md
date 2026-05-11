## 1. AST Parsing

- [x] 1.1 Add `methodKind` (getter, setter, operator, method) or boolean flags to `MethodInfo` class.
- [x] 1.2 Update `source_parser.dart` to extract getters from AST and create `MethodInfo` with the appropriate kind.
- [x] 1.3 Update `source_parser.dart` to extract setters from AST and create `MethodInfo` with the appropriate kind.
- [x] 1.4 Update `source_parser.dart` to extract operators from AST and create `MethodInfo` with the appropriate kind.

## 2. Snapshot Generation

- [x] 2.1 Update `snapshot.dart` to format getter invocations properly in the generated runner snippet (no parentheses).
- [x] 2.2 Update `snapshot.dart` to format setter invocations properly (assignment syntax).
- [x] 2.3 Update `snapshot.dart` to format operator invocations properly (e.g., `obj + arg`, `obj[arg]`).

## 3. Test Generation

- [x] 3.1 Update `test_generator.dart` to output property access syntax for getters (`actual = obj.name;`).
- [x] 3.2 Update `test_generator.dart` to output assignment syntax for setters (`obj.name = arg;`).
- [x] 3.3 Update `test_generator.dart` to output operator syntax for binary operators and index operators.

## 4. Showcase and Verification

- [x] 4.1 Create `lib/usecases/getters_setters_operators_showcase/getters_setters_operators_showcase.dart` with diverse getters, setters, and operators.
- [x] 4.2 Run the generator on the showcase file to generate the test file.
- [x] 4.3 Run `dart test` to verify the generated tests pass successfully.
- [x] 4.4 Update `README.md` to mark TODO #6 as completed.