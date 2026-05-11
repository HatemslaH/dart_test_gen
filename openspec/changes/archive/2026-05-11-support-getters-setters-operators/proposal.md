## Why

Currently, the test generator does not support generating test cases for getters, setters, and operators. They are skipped during AST parsing. Supporting these features will increase test coverage and ensure that standard Dart idioms are tested similarly to regular methods. For getters, a separate "call" model is needed in the tests, as they are invoked without parentheses.

## What Changes

- Add AST parsing and snapshot invocation support for getters.
- Add AST parsing and snapshot invocation support for setters.
- Add AST parsing and snapshot invocation support for custom operators (e.g., `+`, `-`, `==`, `[]`, `[]=`).
- Generate appropriate test assertions (`expect`) for getters and operators.
- Generate appropriate test code for setters (invoke the setter, possibly followed by a getter or state assertion, though snapshots typically return the state or void, we might just verify the setter completes successfully or verify its exceptions).
- Introduce a new test feature in `lib/usecases/` to showcase getters, setters, and operators and ensure regressions don't occur.

## Capabilities

### New Capabilities
- `getters-setters-operators`: Support for discovering, executing, and generating tests for Dart getters, setters, and operators.
- `usecase-getters-setters-operators`: A dedicated test showcase use case that defines various getters, setters, and operators for end-to-end testing of the generator.

### Modified Capabilities
- `snapshot-type-extensions`: Might have minor updates if operators require special generic handling, but primarily we are just adding new method types. No requirement changes to existing snapshot types.

## Impact

- `source_parser.dart` will be updated to parse getters, setters, and operators.
- `snapshot.dart` will be modified to handle the invocation of getters (no args), setters (one arg), and operators (typically one arg, or index arg).
- `test_generator.dart` will be updated to format the test calls correctly (e.g., `actual = obj.myGetter;` instead of `actual = obj.myGetter();`, and `actual = obj + other;`).
- New test data in `lib/usecases/getters_setters_operators_showcase/`.