---
name: haskell-code
description: Guides practical Haskell coding and refactoring toward smaller modules, safer types, lower-duplication architecture, and algebra-driven design. Use when writing, reviewing, or refactoring Haskell code; when adding domain types; when introducing internal seams around wire types; or when consolidating repeated logic in Haskell apps, libraries, sync pipelines, or backtests.
---

# Haskell Code

## Quick start

When changing Haskell code:

1. Prefer small, green, behavior-preserving refactors.
2. Extract duplication before adding abstraction.
3. Add typed wrappers at internal seams, not storage/API boundaries first.
4. Keep modules navigable: domain types, combinators, orchestration, adapters.
5. Rebuild after each meaningful step.

## Algebra-driven design additions

When the code is feature-building, request-building, or other orchestration-heavy Haskell, prefer these moves:

1. **Find the algebraic core first**
   - Extract the smallest pure operation that captures the repeated behavior.
   - Good examples: side-aware mapping, attempted/landed percentages, diff computations, fallback selection.

2. **Hide noisy record plumbing behind internal seam types**
   - Keep external DTOs and JSON/wire contracts stable.
   - Introduce small internal bundle/input records for construction and composition.
   - Examples: request-builder inputs, feature-enrichment bundles, prediction-assembly bundles.

3. **Use deep modules with small public surfaces**
   - Split large orchestration files into narrower internals.
   - Keep a facade module when callers should remain stable.

4. **Prefer lawful combinators over ad hoc updates**
   - If multiple patches compose, give them `Semigroup`/`Monoid` structure when appropriate.
   - Centralize field-setting helpers instead of repeating mirrored updates.

5. **Write law-style tests for the extracted algebra**
   - Good targets: identity, associativity, antisymmetry, fallback behavior, invariants preserved by composition.

## Default refactor order

Use this order unless the task clearly suggests otherwise:

1. **Structural pattern**
   - Replace mirrored `A/B`, `red/blue`, or `landed/attempted` shapes with shared structures.
   - Prefer small domain types like `BoutSide`, `Attempted a`.

2. **Combinator pattern**
   - Extract repeated pure logic into shared modules.
   - Best candidates: metrics, rendering helpers, request builders, normalization helpers.

3. **Type-level / typed wrappers**
   - Introduce wrappers like `Percentage`, `Seconds`, `PositiveInt`.
   - Keep DB/JSON/wire types stable; convert at boundaries.

4. **Monad transformer seam**
   - Add `ReaderT`/`ExceptT` only where dependency plumbing or error flow is already noisy.
   - Prefer thin seams over whole-program rewrites.

5. **DSL pattern**
   - Only after repeated orchestration steps are obvious and stable.

## Module shape guidelines

Prefer splitting responsibilities like this:

- `UFC.Domain.*` — small types and invariants
- `UFC.Analytics.*` — pure feature/math/report combinators
- `UFC.Sync.*` — orchestration and normalization
- `UFC.Sync.Adapter.*` — source-specific parsing only
- `UFC.DB.*` — persistence boundaries

If a file mixes parsing, math, rendering, and IO, split pure pieces out first.

## What to extract first

Good extraction candidates:

- duplicated metric calculations
- repeated report/render formatting
- repeated source normalization helpers
- repeated side-aware logic (`fighter A/B`, `red/blue`)
- repeated lookup/update math (e.g. Elo)

Avoid extracting:

- one-off logic
- unstable code still being designed
- abstractions that only save 5-10 lines but add indirection

## Boundary rule

Prefer this pattern:

- rich internal type
- plain external representation
- explicit conversion at boundary

Examples:

- internal `Percentage` -> external `Double`
- internal `Seconds` -> external `Int`
- internal typed source IDs -> external `Text`
- internal request/feature bundle -> external worker DTO

For API/worker contracts, prefer keeping the contract stable while improving only the internal construction path.

## Safety checklist

Before finishing:

- [ ] behavior unchanged unless requested
- [ ] build passes
- [ ] tests updated if constructor/field shapes changed
- [ ] duplication reduced, not merely moved
- [ ] new module name reflects one responsibility
- [ ] abstractions are used at least twice or clearly define an invariant

## Heuristics

- Prefer total helpers over partial ones.
- Prefer data constructors that make invalid states harder.
- Prefer pure functions extracted from IO-heavy code.
- Prefer adding one seam at a time.
- Prefer facade modules when splitting internals but keeping callers stable.
- Prefer shared structural helpers over duplicated left/right or A/B logic.
- When introducing composition, add at least one law-style test.
- If uncertain, choose the more boring refactor.
