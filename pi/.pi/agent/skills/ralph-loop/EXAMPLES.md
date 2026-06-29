# Ralph Loop Examples

## Fix tests

```md
---
commands:
  - name: tests
    run: npm test
    timeout: 120
    acceptance: true
max_iterations: 20
timeout: 300
completion_promise: DONE
completion_gate: required
guardrails:
  block_commands:
    - 'git\\s+push'
  protected_files:
    - '.env*'
    - 'policy:secret-bearing-paths'
---

You are an autonomous coding agent running in a loop.
Each iteration starts with fresh context.
Your progress lives in code, commits, and RALPH_PROGRESS.md.

## Test results
{{ commands.tests }}

## Task
Fix one failing test or one closely related failing cluster this iteration.
Run tests before committing.
Update RALPH_PROGRESS.md with what changed and what remains.

## Completion
Stop with <promise>DONE</promise> only when the full test suite passes.
```

## Migration

```md
---
commands:
  - name: search-old-pattern
    run: rg 'oldPattern|legacyApi' src test || true
    timeout: 60
  - name: tests
    run: npm test
    timeout: 120
    acceptance: true
max_iterations: 30
items_per_iteration: 3
reflect_every: 5
completion_promise: DONE
completion_gate: required
required_outputs:
  - MIGRATION_REPORT.md
guardrails:
  block_commands:
    - 'git\\s+push'
    - 'npm\\s+publish'
  protected_files:
    - 'policy:secret-bearing-paths'
---

You are an autonomous coding agent running in a loop.

## Remaining old-pattern usages
{{ commands.search-old-pattern }}

## Test results
{{ commands.tests }}

## Task
Migrate up to 3 old-pattern usages to the new API.
Prefer cohesive files or modules.
Update tests and MIGRATION_REPORT.md.

## Completion
Stop with <promise>DONE</promise> only when no old-pattern usages remain, tests pass, and MIGRATION_REPORT.md summarizes the migration.
```
