---
name: ralph-loop
description: Helps create, configure, and operate pi-ralph-loop autonomous coding loops and RALPH.md task folders. Use when starting or debugging /ralph, /ralph-draft, /ralph-status, /ralph-resume, /ralph-stop, /ralph-cancel, /ralph-scaffold, or when handling long-running repetitive coding work.
---

# Ralph Loop

## Quick start

- Never run `/ralph ...` with `bash`; it is a Pi slash command.
- If Pi did not intercept a slash command, tell the user to reinstall/reload the extension and rerun it.
- Use `pi list` to verify `npm:@lnilluv/pi-ralph-loop` is installed.
- For a new loop, create a task folder with `RALPH.md`, then tell the user to run `/ralph --path ./task`.
- For a smoke test, use `pi -p "/ralph --path ./task"`.

## Workflows

### Start or draft a loop
1. Create or edit the task folder.
2. Add `RALPH.md` with YAML frontmatter plus the prompt body.
3. Include evidence commands, rules, and completion criteria.
4. Prefer one clear task per iteration.

### Configure safely
- Use `snake_case` keys in YAML.
- Add guardrails for blocked commands and protected files.
- Set `completion_promise` only when early stopping is knowable.
- Use `required_outputs` when completion depends on files.

### Operate and stop
- `/ralph-status [path] [--summary]` for deterministic status.
- `/ralph-resume <path>` to continue from an existing task.
- `/ralph-stop` to finish the current iteration and stop.
- `/ralph-cancel` to stop immediately.
- `/ralph-archive` to archive run artifacts.

## Advanced features

- See [REFERENCE.md](REFERENCE.md) for the full command list, frontmatter keys, prompt structure, guardrails, and completion-gate behavior.
- See [EXAMPLES.md](EXAMPLES.md) for ready-to-use task templates.
