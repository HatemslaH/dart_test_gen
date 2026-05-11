## Why

Currently, the test generator only supports non-static methods of normal classes. To increase the coverage and usefulness of the tool, we need to support generating tests for static methods, factory constructors, and extension types. This addresses the 5th TODO item in the project roadmap.

## What Changes

- Add support for parsing and generating tests for `static` methods.
- Add support for parsing and generating tests for `factory` constructors.
- Add support for parsing and generating tests for `extension type`s.
- Create a new usecase in `lib/usecases/` (e.g., `lib/usecases/static_factory_extension_showcase/`) to demonstrate and test these new capabilities.
- Update the test generator to correctly instantiate or call these methods and types in the generated test files.

## Capabilities

### New Capabilities
- `snapshot-type-extensions`: Support for generating tests for static methods, factory constructors, and extension types.

### Modified Capabilities

## Impact

- `lib/source_parser.dart`: Needs to be updated to parse static methods, factories, and extension types.
- `lib/test_generator.dart`: Needs to be updated to generate the correct invocation syntax for static methods, factories, and extension types.
- `lib/snapshot.dart`: Needs to be updated to correctly invoke static methods, factories, and extension types during snapshot generation.
- `lib/usecases/`: New showcase files will be added.
- `test/usecases/`: New generated tests will be added for the new showcase.