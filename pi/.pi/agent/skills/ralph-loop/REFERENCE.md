# Ralph Loop Reference

## Native Pi command rules

- `/ralph` is a Pi slash command, not a shell executable.
- If a bare `/ralph ...` reaches chat as plain text, Pi did not intercept it; ask the user to reload the extension or restart Pi after installing `npm:@lnilluv/pi-ralph-loop`.
- `pi --help` does not list slash commands; use `pi list`.
- Do not simulate the loop manually.

## Command forms

- `/ralph [path-or-task]`
- `/ralph --path ./dir --arg key=val`
- `/ralph-draft "task description"`
- `/ralph-list`
- `/ralph-status [path] [--summary]`
- `/ralph-resume <path>`
- `/ralph-archive <path>`
- `/ralph-stop [task folder or RALPH.md]`
- `/ralph-cancel [task folder or RALPH.md]`
- `/ralph-scaffold [--preset <name>] <name-or-path>`
- `/ralph-logs [<task folder or RALPH.md>] [--path <task folder or RALPH.md>] [--dest <dir>]`

## RALPH.md structure

Every loop needs a `RALPH.md` file with YAML frontmatter and a Markdown body.

Recommended keys:

- `commands`
- `args`
- `max_iterations`
- `inter_iteration_delay`
- `items_per_iteration`
- `reflect_every`
- `timeout`
- `completion_promise`
- `completion_gate`
- `required_outputs`
- `stop_on_error`
- `guardrails.block_commands`
- `guardrails.protected_files`
- `guardrails.shell_policy`

## Prompt pattern

Include these sections when relevant:

1. Orientation
2. Evidence
3. Task
4. Rules
5. Completion

## Guardrails

- Block dangerous commands like `git push`, `rm -rf /`, and `npm publish`.
- Protect secret-bearing paths.
- Use allowlists only when needed.

## Completion behavior

- `completion_promise` defines the stop signal.
- `completion_gate: required` also requires outputs, open questions readiness, and fresh acceptance reruns.
- `optional` and `disabled` relax that gating.

## Progress memory

- Use `RALPH_PROGRESS.md` to track iteration state.
- Ralph writes `.ralph-runner/final-summary.md` at terminal completion.
