## Why

README roadmap item 4 calls out missing coverage for collection and generic types beyond what the parser and boundary-case builder handle today. The root README also misstates how types like `RgbColor` work (they are not a special-case “pattern” in code). Clarifying the roadmap and adding a dedicated usecase library makes the gap visible and gives a regression target for future parser/snapshot work.

## What Changes

- Refresh README: accurate description of supported custom types and TODO item 4 scope.
- Add `lib/usecases/type_extensions_showcase/` with a small public API split across files (types imported via `package:` so dependency merge applies), including methods that illustrate **not yet** fully supported signatures (`Set`, `Iterable`, non-`List<int>` generics) alongside at least one fully generatable method.
- Follow-up implementation (separate apply phase): extend `source_parser.dart` / `test_generator.dart` / `snapshot.dart` so those signatures gain literals, snapshots, and emitted tests where feasible.

## Capabilities

### New Capabilities

- `snapshot-type-extensions`: Requirements for recognizing additional Dart types in public instance method parameters and return positions, producing valid boundary literals and JSON round-trips for snapshot runners and generated `expect` literals.

### Modified Capabilities

- (none — no existing `openspec/specs/` baseline in this repo)

## Impact

- **Docs**: `README.md` (feature list + TODO 4).
- **Examples**: `lib/usecases/type_extensions_showcase/**` (new); optional future `test/usecases/...` once generator supports the new cases.
- **Core** (later apply): `lib/source_parser.dart`, `lib/test_generator.dart`, `lib/snapshot.dart`, possibly `lib/resolved_dependencies.dart` if new type shapes need more merge rules.
