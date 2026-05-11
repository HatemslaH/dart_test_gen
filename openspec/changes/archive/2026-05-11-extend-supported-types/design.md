## Context

`source_parser.dart` maps parameters to `ParamType` with special cases for primitives, `String`, `List<int>` (only that instantiation), enums declared in parsed units, and “custom” types that match a `ClassInfo` gathered from the target file plus `mergeLibAbsolutePaths`. Custom types need constructor metadata and field lists to synthesize two diagonal constructor literals. Anything else becomes `ParamType.custom_` with no literals; `generateBoundaryCases` then yields **no** values for that parameter, which can collapse the whole combination matrix to zero rows for that method.

`snapshot.dart` already serializes lists, maps, enums, same-merge `ClassInfo` shapes, optional `toJson()`, and a string fallback. Return-type decoding has explicit branches today for `List<int>` and `Map<String, int>` (normalized spacing); other structured returns rely on the generic `Map`/`_type` path or `dartLiteralFromJsonLoose`, which is narrow.

**Gap (example):** `List<NameTag> pairNameTags(String x, String y) => [NameTag(x), NameTag(y)];` — `snapshotValue` encodes each element as a JSON `Map` with `_type` / fields, but decoding used to assume only homogenous primitives inside `List` (or failed in `dartLiteralFromJsonLoose` on nested structures). The same class of problem applies to **`Set<T>`**, **`Iterable<T>`**, and **`Map<String, T>`** whenever **`T` is not** a primitive / `String` / `int` but a **merged `ClassInfo` type**, enum, or another type we already know how to turn into a Dart literal.

## Goals / Non-Goals

**Goals:**

- Define how to extend `ParamType` / `_paramFor` (or a successor model) for `Set<T>`, `Iterable<T>`, and additional generic collections where `T` is already a supported leaf type.
- Define snapshot JSON and Dart literal emission rules for new return shapes that mirror parameter support (avoid asymmetric “can return but cannot pass” where possible).
- **Collections with a single type argument `T`** where `T` is any type we can already decode as a literal: primitives, `String`, enums, merged `ClassInfo` types (`List<NameTag>`, `Set<CounterLabel>`, `Iterable<NameTag>`, `Map<String, NameTag>`, …). Decoding SHALL recurse element-wise: `dartLiteralFromJson(element, 'T', allClasses)`.
- Keep deterministic boundary sampling and existing sampling strategies compatible.

**Non-Goals:**

- Static methods, factories, extension types, getters/setters (other README items).
- **Nested** generic parameters in one token (e.g. `List<List<int>>`, `Map<String, List<int>>`) in the first iteration — require a richer parser or full `DartType` from the analyzer instead of string heuristics.
- Arbitrary deep user-defined graphs without `ClassInfo` or `toJson` (handled by existing fallbacks until a richer plugin exists).

## Decisions

1. **Extend `ParamType` vs generic recipe** — Prefer adding explicit `ParamType` values for `Set<int>`, `Iterable<int>`, `List<String>`, and `Map<String, int>` parameters first (mirrors current `List<int>` approach) before inventing a fully generic `CollectionParam(inner)` model. Rationale: smallest change to `generateBoundaryCases` and existing cartesian product logic; easier to test.

2. **Literal sets for collections** — For `Set<int>` / `Iterable<int>`, reuse the same int literals as list boundaries mapped to `Set<int>{...}` / `Iterable` via spread from a list literal where valid, e.g. `{0, 1, -1}` built from sorted unique samples. Start with **small literal sets** to control combination explosion; optionally cap with the same `max_cases` sampling already applied post-expansion.

3. **Return types — homogenous collections (implemented / planned):**
   - **Phase A (done earlier):** fixed inner kinds `List<int>`, `List<String>`, `Set<int>`, `Iterable<int>`, `Map<String, int>` with dedicated or compact literals.
   - **Phase B (return literals):** Parse `returnType` as `Outer<Inner>` with a **single identifier** `Inner` (no commas, no nested `<`). If `Outer` is `List` / `Set` / `Iterable`, JSON for the value is a **JSON array** of element payloads (same as today’s `snapshotValue` on `List`/`Set`/`Iterable`). Emit Dart literals by mapping each element with **`dartLiteralFromJson(e, innerType, allClasses)`** recursively.
   - **Phase B′ `Map<String, T>`:** JSON object keyed by string; each value decoded with `dartLiteralFromJson(value, T, allClasses)`. Unifies former `Map<String, int>` special case with `Map<String, NameTag>` etc.
   - **`Set<T>` ordering:** For `Set<int>`, keep numeric sort of elements for stable literals; for other `T`, sort emitted element literals as strings for determinism (or preserve snapshot list order — document choice).

4. **Parameters `List<CustomType>` / `Set<CustomType>` / …** — Same recursion idea: boundary literals must be valid Dart; either a **small catalog** of typed literals per `Inner` (harder) or **two diagonal constructor-based samples** built from `ClassInfo` embedded in list/set literals (e.g. `[NameTag(''), NameTag('test')]`). Track as follow-up once return decoding is stable.

5. **README / fixture alignment** — Treat `lib/usecases/type_extensions_showcase/` as the acceptance driver (e.g. `pairNameTags`); `dart run bin/generate.dart` on that entry must complete without `dartLiteralFromJsonLoose` errors on nested collection values.

## Risks / Trade-offs

- **[Risk] Combination explosion** → Mitigation: reuse `max_cases` / strategy filters; keep literal sets minimal for first iteration.
- **[Risk] `Iterable` vs concrete collection** → Mitigation: snapshot as `List` JSON; decode to `List` literal or `.toList()` factory if the API returns a lazy iterable that is not replayable (document non-goals if a method returns one-shot iterators).
- **[Risk] Order-sensitive sets as `Set` literals** → Mitigation: emit sorted literals for deterministic tests (int by value; otherwise by string form of child literal).
- **[Risk] `returnType` string vs analyzer `DartType`** → Heuristic `Outer<Inner>` parsing fails on nested generics; mitigation: document limitation; long-term use resolved `DartType` or serialize “element type” alongside snapshot rows.

## Migration Plan

N/A for a library-only tool; changes are backward-compatible if new types are strictly additive.

## Open Questions

- **Parameters** for `List<CustomType>` / `Set<CustomType>`: minimal literal catalog vs constructor-diagonal pattern for elements.
- Nested generics (`List<List<int>>`, `Map<String, List<String>>`) and **records**.
- Whether `dartLiteralFromJsonLoose` should recurse for **custom class fields** whose types are collections of `ClassInfo` types (same bug pattern as returns, different code path).
