#compdef codex

autoload -U is-at-least

_codex() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-a+[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'--ask-for-approval=[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--oss[Convenience flag to select the local open source model provider. Equivalent to -c model_provider=oss; verifies a local Ollama server is running]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(-a --ask-for-approval --full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--search[Enable web search (off by default). When enabled, the native Responses \`web_search\` tool is available to the model (no per‑call approval)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Optional user prompt to start the session:' \
":: :_codex_commands" \
"*::: :->codex-cli" \
&& ret=0
    case $state in
    (codex-cli)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-command-$line[2]:"
        case $line[2] in
            (exec)
_arguments "${_arguments_options[@]}" : \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--output-schema=[Path to a JSON Schema file describing the model'\''s final response shape]:FILE:_files' \
'--color=[Specifies color settings for use in the output]:COLOR:(always never auto)' \
'-o+[Specifies file where the last message from the agent should be written]:FILE:_files' \
'--output-last-message=[Specifies file where the last message from the agent should be written]:FILE:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--oss[]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(--full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--skip-git-repo-check[Allow running Codex outside a Git repository]' \
'--json[Print events to stdout as JSONL]' \
'--include-plan-tool[Whether to include the plan tool in the conversation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Initial instructions for the agent. If not provided as an argument (or if `-` is used), instructions are read from stdin:' \
":: :_codex__exec_commands" \
"*::: :->exec" \
&& ret=0

    case $state in
    (exec)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-exec-command-$line[2]:"
        case $line[2] in
            (resume)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'()--last[Resume the most recent recorded session (newest) without specifying an id]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::session_id -- Conversation/session id (UUID). When provided, resumes this session. If omitted, use --last to pick the most recent recorded session:_default' \
'::prompt -- Prompt to send after resuming the session. If `-` is used, read from stdin:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__exec__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-exec-help-command-$line[1]:"
        case $line[1] in
            (resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(e)
_arguments "${_arguments_options[@]}" : \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--output-schema=[Path to a JSON Schema file describing the model'\''s final response shape]:FILE:_files' \
'--color=[Specifies color settings for use in the output]:COLOR:(always never auto)' \
'-o+[Specifies file where the last message from the agent should be written]:FILE:_files' \
'--output-last-message=[Specifies file where the last message from the agent should be written]:FILE:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--oss[]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(--full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--skip-git-repo-check[Allow running Codex outside a Git repository]' \
'--json[Print events to stdout as JSONL]' \
'--include-plan-tool[Whether to include the plan tool in the conversation]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::prompt -- Initial instructions for the agent. If not provided as an argument (or if `-` is used), instructions are read from stdin:' \
":: :_codex__exec_commands" \
"*::: :->exec" \
&& ret=0

    case $state in
    (exec)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-exec-command-$line[2]:"
        case $line[2] in
            (resume)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'()--last[Resume the most recent recorded session (newest) without specifying an id]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::session_id -- Conversation/session id (UUID). When provided, resumes this session. If omitted, use --last to pick the most recent recorded session:_default' \
'::prompt -- Prompt to send after resuming the session. If `-` is used, read from stdin:' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__exec__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-exec-help-command-$line[1]:"
        case $line[1] in
            (resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(login)
_arguments "${_arguments_options[@]}" : \
'--api-key=[(deprecated) Previously accepted the API key directly; now exits with guidance to use --with-api-key]:API_KEY:_default' \
'--experimental_issuer=[EXPERIMENTAL\: Use custom OAuth issuer base URL (advanced) Override the OAuth issuer base URL (advanced)]:URL:_default' \
'--experimental_client-id=[EXPERIMENTAL\: Use custom OAuth client ID (advanced)]:CLIENT_ID:_default' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--with-api-key[Read the API key from stdin (e.g. \`printenv OPENAI_API_KEY | codex login --with-api-key\`)]' \
'--device-auth[]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__login_commands" \
"*::: :->login" \
&& ret=0

    case $state in
    (login)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-login-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__login__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-login-help-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(logout)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(mcp)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__mcp_commands" \
"*::: :->mcp" \
&& ret=0

    case $state in
    (mcp)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-mcp-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--json[Output the configured servers as JSON]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(get)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--json[Output the server configuration as JSON]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':name -- Name of the MCP server to display:_default' \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
'*--env=[Environment variables to set when launching the server. Only valid with stdio servers]:KEY=VALUE:_default' \
'--url=[URL for a streamable HTTP MCP server]:URL:_default' \
'--bearer-token-env-var=[Optional environment variable to read for a bearer token. Only valid with streamable HTTP servers]:ENV_VAR:_default' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':name -- Name for the MCP server configuration:_default' \
'*::command -- Command to launch the MCP server. Use --url for a streamable HTTP server:_default' \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':name -- Name of the MCP server configuration to remove:_default' \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':name -- Name of the MCP server to authenticate with oauth:_default' \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':name -- Name of the MCP server to deauthenticate:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__mcp__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-mcp-help-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(mcp-server)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(app-server)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::shell -- Shell to generate completions for:(bash elvish fish powershell zsh)' \
&& ret=0
;;
(sandbox)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__sandbox_commands" \
"*::: :->sandbox" \
&& ret=0

    case $state in
    (sandbox)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-sandbox-command-$line[1]:"
        case $line[1] in
            (macos)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under seatbelt:_default' \
&& ret=0
;;
(seatbelt)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under seatbelt:_default' \
&& ret=0
;;
(linux)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under landlock:_default' \
&& ret=0
;;
(landlock)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under landlock:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__sandbox__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-sandbox-help-command-$line[1]:"
        case $line[1] in
            (macos)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(linux)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(debug)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
":: :_codex__sandbox_commands" \
"*::: :->sandbox" \
&& ret=0

    case $state in
    (sandbox)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-sandbox-command-$line[1]:"
        case $line[1] in
            (macos)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under seatbelt:_default' \
&& ret=0
;;
(seatbelt)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under seatbelt:_default' \
&& ret=0
;;
(linux)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under landlock:_default' \
&& ret=0
;;
(landlock)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (network-disabled sandbox that can write to cwd and TMPDIR)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::command -- Full command args to run under landlock:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__sandbox__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-sandbox-help-command-$line[1]:"
        case $line[1] in
            (macos)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(linux)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(apply)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':task_id:_default' \
&& ret=0
;;
(a)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
':task_id:_default' \
&& ret=0
;;
(resume)
_arguments "${_arguments_options[@]}" : \
'*-i+[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'*--image=[Optional image(s) to attach to the initial prompt]:FILE:_files' \
'-m+[Model the agent should use]:MODEL:_default' \
'--model=[Model the agent should use]:MODEL:_default' \
'-p+[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'--profile=[Configuration profile from config.toml to specify default options]:CONFIG_PROFILE:_default' \
'-s+[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'--sandbox=[Select the sandbox policy to use when executing model-generated shell commands]:SANDBOX_MODE:(read-only workspace-write danger-full-access)' \
'-a+[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'--ask-for-approval=[Configure when the model requires human approval before executing a command]:APPROVAL_POLICY:((untrusted\:"Only run "trusted" commands (e.g. ls, cat, sed) without asking for user approval. Will escalate to the user if the model proposes a command that is not in the "trusted" set"
on-failure\:"Run all commands without asking for user approval. Only asks for approval if a command fails to execute, in which case it will escalate to the user to ask for un-sandboxed execution"
on-request\:"The model decides when to ask the user for approval"
never\:"Never ask for user approval Execution failures are immediately returned to the model"))' \
'-C+[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'--cd=[Tell the agent to use the specified directory as its working root]:DIR:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'()--last[Continue the most recent session without showing the picker]' \
'--oss[Convenience flag to select the local open source model provider. Equivalent to -c model_provider=oss; verifies a local Ollama server is running]' \
'--full-auto[Convenience alias for low-friction sandboxed automatic execution (-a on-failure, --sandbox workspace-write)]' \
'(-a --ask-for-approval --full-auto)--dangerously-bypass-approvals-and-sandbox[Skip all confirmation prompts and execute commands without sandboxing. EXTREMELY DANGEROUS. Intended solely for running in environments that are externally sandboxed]' \
'--search[Enable web search (off by default). When enabled, the native Responses \`web_search\` tool is available to the model (no per‑call approval)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::session_id -- Conversation/session id (UUID). When provided, resumes this session. If omitted, use --last to pick the most recent recorded session:_default' \
'::prompt -- Optional user prompt to start the session:' \
&& ret=0
;;
(generate-ts)
_arguments "${_arguments_options[@]}" : \
'-o+[Output directory where .ts files will be written]:DIR:_files' \
'--out=[Output directory where .ts files will be written]:DIR:_files' \
'-p+[Optional path to the Prettier executable to format generated files]:PRETTIER_BIN:_files' \
'--prettier=[Optional path to the Prettier executable to format generated files]:PRETTIER_BIN:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(cloud)
_arguments "${_arguments_options[@]}" : \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(responses-api-proxy)
_arguments "${_arguments_options[@]}" : \
'--port=[Port to listen on. If not set, an ephemeral port is used]:PORT:_default' \
'--server-info=[Path to a JSON file to write startup info (single line). Includes {"port"\: <u16>}]:FILE:_files' \
'*-c+[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'*--config=[Override a configuration value that would otherwise be loaded from \`~/.codex/config.toml\`. Use a dotted path (\`foo.bar.baz\`) to override nested values. The \`value\` portion is parsed as JSON. If it fails to parse as JSON, the raw string is used as a literal]:key=value:_default' \
'--http-shutdown[Enable HTTP shutdown endpoint at GET /shutdown]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-command-$line[1]:"
        case $line[1] in
            (exec)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__exec_commands" \
"*::: :->exec" \
&& ret=0

    case $state in
    (exec)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-exec-command-$line[1]:"
        case $line[1] in
            (resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(login)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__login_commands" \
"*::: :->login" \
&& ret=0

    case $state in
    (login)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-login-command-$line[1]:"
        case $line[1] in
            (status)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(mcp)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__mcp_commands" \
"*::: :->mcp" \
&& ret=0

    case $state in
    (mcp)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-mcp-command-$line[1]:"
        case $line[1] in
            (list)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(get)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(add)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(remove)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(login)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(logout)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(mcp-server)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(app-server)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(completion)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(sandbox)
_arguments "${_arguments_options[@]}" : \
":: :_codex__help__sandbox_commands" \
"*::: :->sandbox" \
&& ret=0

    case $state in
    (sandbox)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:codex-help-sandbox-command-$line[1]:"
        case $line[1] in
            (macos)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(linux)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(apply)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(resume)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(generate-ts)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(cloud)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(responses-api-proxy)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_codex_commands] )) ||
_codex_commands() {
    local commands; commands=(
'exec:Run Codex non-interactively' \
'e:Run Codex non-interactively' \
'login:Manage login' \
'logout:Remove stored authentication credentials' \
'mcp:\[experimental\] Run Codex as an MCP server and manage MCP servers' \
'mcp-server:\[experimental\] Run the Codex MCP server (stdio transport)' \
'app-server:\[experimental\] Run the app server' \
'completion:Generate shell completion scripts' \
'sandbox:Run commands within a Codex-provided sandbox' \
'debug:Run commands within a Codex-provided sandbox' \
'apply:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'a:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'resume:Resume a previous interactive session (picker by default; use --last to continue the most recent)' \
'generate-ts:Internal\: generate TypeScript protocol bindings' \
'cloud:\[EXPERIMENTAL\] Browse tasks from Codex Cloud and apply changes locally' \
'responses-api-proxy:Internal\: run the responses API proxy' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex commands' commands "$@"
}
(( $+functions[_codex__app-server_commands] )) ||
_codex__app-server_commands() {
    local commands; commands=()
    _describe -t commands 'codex app-server commands' commands "$@"
}
(( $+functions[_codex__apply_commands] )) ||
_codex__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex apply commands' commands "$@"
}
(( $+functions[_codex__cloud_commands] )) ||
_codex__cloud_commands() {
    local commands; commands=()
    _describe -t commands 'codex cloud commands' commands "$@"
}
(( $+functions[_codex__completion_commands] )) ||
_codex__completion_commands() {
    local commands; commands=()
    _describe -t commands 'codex completion commands' commands "$@"
}
(( $+functions[_codex__exec_commands] )) ||
_codex__exec_commands() {
    local commands; commands=(
'resume:Resume a previous session by id or pick the most recent with --last' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex exec commands' commands "$@"
}
(( $+functions[_codex__exec__help_commands] )) ||
_codex__exec__help_commands() {
    local commands; commands=(
'resume:Resume a previous session by id or pick the most recent with --last' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex exec help commands' commands "$@"
}
(( $+functions[_codex__exec__help__help_commands] )) ||
_codex__exec__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex exec help help commands' commands "$@"
}
(( $+functions[_codex__exec__help__resume_commands] )) ||
_codex__exec__help__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex exec help resume commands' commands "$@"
}
(( $+functions[_codex__exec__resume_commands] )) ||
_codex__exec__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex exec resume commands' commands "$@"
}
(( $+functions[_codex__generate-ts_commands] )) ||
_codex__generate-ts_commands() {
    local commands; commands=()
    _describe -t commands 'codex generate-ts commands' commands "$@"
}
(( $+functions[_codex__help_commands] )) ||
_codex__help_commands() {
    local commands; commands=(
'exec:Run Codex non-interactively' \
'login:Manage login' \
'logout:Remove stored authentication credentials' \
'mcp:\[experimental\] Run Codex as an MCP server and manage MCP servers' \
'mcp-server:\[experimental\] Run the Codex MCP server (stdio transport)' \
'app-server:\[experimental\] Run the app server' \
'completion:Generate shell completion scripts' \
'sandbox:Run commands within a Codex-provided sandbox' \
'apply:Apply the latest diff produced by Codex agent as a \`git apply\` to your local working tree' \
'resume:Resume a previous interactive session (picker by default; use --last to continue the most recent)' \
'generate-ts:Internal\: generate TypeScript protocol bindings' \
'cloud:\[EXPERIMENTAL\] Browse tasks from Codex Cloud and apply changes locally' \
'responses-api-proxy:Internal\: run the responses API proxy' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex help commands' commands "$@"
}
(( $+functions[_codex__help__app-server_commands] )) ||
_codex__help__app-server_commands() {
    local commands; commands=()
    _describe -t commands 'codex help app-server commands' commands "$@"
}
(( $+functions[_codex__help__apply_commands] )) ||
_codex__help__apply_commands() {
    local commands; commands=()
    _describe -t commands 'codex help apply commands' commands "$@"
}
(( $+functions[_codex__help__cloud_commands] )) ||
_codex__help__cloud_commands() {
    local commands; commands=()
    _describe -t commands 'codex help cloud commands' commands "$@"
}
(( $+functions[_codex__help__completion_commands] )) ||
_codex__help__completion_commands() {
    local commands; commands=()
    _describe -t commands 'codex help completion commands' commands "$@"
}
(( $+functions[_codex__help__exec_commands] )) ||
_codex__help__exec_commands() {
    local commands; commands=(
'resume:Resume a previous session by id or pick the most recent with --last' \
    )
    _describe -t commands 'codex help exec commands' commands "$@"
}
(( $+functions[_codex__help__exec__resume_commands] )) ||
_codex__help__exec__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex help exec resume commands' commands "$@"
}
(( $+functions[_codex__help__generate-ts_commands] )) ||
_codex__help__generate-ts_commands() {
    local commands; commands=()
    _describe -t commands 'codex help generate-ts commands' commands "$@"
}
(( $+functions[_codex__help__help_commands] )) ||
_codex__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex help help commands' commands "$@"
}
(( $+functions[_codex__help__login_commands] )) ||
_codex__help__login_commands() {
    local commands; commands=(
'status:Show login status' \
    )
    _describe -t commands 'codex help login commands' commands "$@"
}
(( $+functions[_codex__help__login__status_commands] )) ||
_codex__help__login__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex help login status commands' commands "$@"
}
(( $+functions[_codex__help__logout_commands] )) ||
_codex__help__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex help logout commands' commands "$@"
}
(( $+functions[_codex__help__mcp_commands] )) ||
_codex__help__mcp_commands() {
    local commands; commands=(
'list:\[experimental\] List configured MCP servers' \
'get:\[experimental\] Show details for a configured MCP server' \
'add:\[experimental\] Add a global MCP server entry' \
'remove:\[experimental\] Remove a global MCP server entry' \
'login:\[experimental\] Authenticate with a configured MCP server via OAuth. Requires experimental_use_rmcp_client = true in config.toml' \
'logout:\[experimental\] Remove stored OAuth credentials for a server. Requires experimental_use_rmcp_client = true in config.toml' \
    )
    _describe -t commands 'codex help mcp commands' commands "$@"
}
(( $+functions[_codex__help__mcp__add_commands] )) ||
_codex__help__mcp__add_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp add commands' commands "$@"
}
(( $+functions[_codex__help__mcp__get_commands] )) ||
_codex__help__mcp__get_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp get commands' commands "$@"
}
(( $+functions[_codex__help__mcp__list_commands] )) ||
_codex__help__mcp__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp list commands' commands "$@"
}
(( $+functions[_codex__help__mcp__login_commands] )) ||
_codex__help__mcp__login_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp login commands' commands "$@"
}
(( $+functions[_codex__help__mcp__logout_commands] )) ||
_codex__help__mcp__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp logout commands' commands "$@"
}
(( $+functions[_codex__help__mcp__remove_commands] )) ||
_codex__help__mcp__remove_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp remove commands' commands "$@"
}
(( $+functions[_codex__help__mcp-server_commands] )) ||
_codex__help__mcp-server_commands() {
    local commands; commands=()
    _describe -t commands 'codex help mcp-server commands' commands "$@"
}
(( $+functions[_codex__help__responses-api-proxy_commands] )) ||
_codex__help__responses-api-proxy_commands() {
    local commands; commands=()
    _describe -t commands 'codex help responses-api-proxy commands' commands "$@"
}
(( $+functions[_codex__help__resume_commands] )) ||
_codex__help__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex help resume commands' commands "$@"
}
(( $+functions[_codex__help__sandbox_commands] )) ||
_codex__help__sandbox_commands() {
    local commands; commands=(
'macos:Run a command under Seatbelt (macOS only)' \
'linux:Run a command under Landlock+seccomp (Linux only)' \
    )
    _describe -t commands 'codex help sandbox commands' commands "$@"
}
(( $+functions[_codex__help__sandbox__linux_commands] )) ||
_codex__help__sandbox__linux_commands() {
    local commands; commands=()
    _describe -t commands 'codex help sandbox linux commands' commands "$@"
}
(( $+functions[_codex__help__sandbox__macos_commands] )) ||
_codex__help__sandbox__macos_commands() {
    local commands; commands=()
    _describe -t commands 'codex help sandbox macos commands' commands "$@"
}
(( $+functions[_codex__login_commands] )) ||
_codex__login_commands() {
    local commands; commands=(
'status:Show login status' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex login commands' commands "$@"
}
(( $+functions[_codex__login__help_commands] )) ||
_codex__login__help_commands() {
    local commands; commands=(
'status:Show login status' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex login help commands' commands "$@"
}
(( $+functions[_codex__login__help__help_commands] )) ||
_codex__login__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex login help help commands' commands "$@"
}
(( $+functions[_codex__login__help__status_commands] )) ||
_codex__login__help__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex login help status commands' commands "$@"
}
(( $+functions[_codex__login__status_commands] )) ||
_codex__login__status_commands() {
    local commands; commands=()
    _describe -t commands 'codex login status commands' commands "$@"
}
(( $+functions[_codex__logout_commands] )) ||
_codex__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex logout commands' commands "$@"
}
(( $+functions[_codex__mcp_commands] )) ||
_codex__mcp_commands() {
    local commands; commands=(
'list:\[experimental\] List configured MCP servers' \
'get:\[experimental\] Show details for a configured MCP server' \
'add:\[experimental\] Add a global MCP server entry' \
'remove:\[experimental\] Remove a global MCP server entry' \
'login:\[experimental\] Authenticate with a configured MCP server via OAuth. Requires experimental_use_rmcp_client = true in config.toml' \
'logout:\[experimental\] Remove stored OAuth credentials for a server. Requires experimental_use_rmcp_client = true in config.toml' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex mcp commands' commands "$@"
}
(( $+functions[_codex__mcp__add_commands] )) ||
_codex__mcp__add_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp add commands' commands "$@"
}
(( $+functions[_codex__mcp__get_commands] )) ||
_codex__mcp__get_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp get commands' commands "$@"
}
(( $+functions[_codex__mcp__help_commands] )) ||
_codex__mcp__help_commands() {
    local commands; commands=(
'list:\[experimental\] List configured MCP servers' \
'get:\[experimental\] Show details for a configured MCP server' \
'add:\[experimental\] Add a global MCP server entry' \
'remove:\[experimental\] Remove a global MCP server entry' \
'login:\[experimental\] Authenticate with a configured MCP server via OAuth. Requires experimental_use_rmcp_client = true in config.toml' \
'logout:\[experimental\] Remove stored OAuth credentials for a server. Requires experimental_use_rmcp_client = true in config.toml' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex mcp help commands' commands "$@"
}
(( $+functions[_codex__mcp__help__add_commands] )) ||
_codex__mcp__help__add_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help add commands' commands "$@"
}
(( $+functions[_codex__mcp__help__get_commands] )) ||
_codex__mcp__help__get_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help get commands' commands "$@"
}
(( $+functions[_codex__mcp__help__help_commands] )) ||
_codex__mcp__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help help commands' commands "$@"
}
(( $+functions[_codex__mcp__help__list_commands] )) ||
_codex__mcp__help__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help list commands' commands "$@"
}
(( $+functions[_codex__mcp__help__login_commands] )) ||
_codex__mcp__help__login_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help login commands' commands "$@"
}
(( $+functions[_codex__mcp__help__logout_commands] )) ||
_codex__mcp__help__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help logout commands' commands "$@"
}
(( $+functions[_codex__mcp__help__remove_commands] )) ||
_codex__mcp__help__remove_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp help remove commands' commands "$@"
}
(( $+functions[_codex__mcp__list_commands] )) ||
_codex__mcp__list_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp list commands' commands "$@"
}
(( $+functions[_codex__mcp__login_commands] )) ||
_codex__mcp__login_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp login commands' commands "$@"
}
(( $+functions[_codex__mcp__logout_commands] )) ||
_codex__mcp__logout_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp logout commands' commands "$@"
}
(( $+functions[_codex__mcp__remove_commands] )) ||
_codex__mcp__remove_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp remove commands' commands "$@"
}
(( $+functions[_codex__mcp-server_commands] )) ||
_codex__mcp-server_commands() {
    local commands; commands=()
    _describe -t commands 'codex mcp-server commands' commands "$@"
}
(( $+functions[_codex__responses-api-proxy_commands] )) ||
_codex__responses-api-proxy_commands() {
    local commands; commands=()
    _describe -t commands 'codex responses-api-proxy commands' commands "$@"
}
(( $+functions[_codex__resume_commands] )) ||
_codex__resume_commands() {
    local commands; commands=()
    _describe -t commands 'codex resume commands' commands "$@"
}
(( $+functions[_codex__sandbox_commands] )) ||
_codex__sandbox_commands() {
    local commands; commands=(
'macos:Run a command under Seatbelt (macOS only)' \
'seatbelt:Run a command under Seatbelt (macOS only)' \
'linux:Run a command under Landlock+seccomp (Linux only)' \
'landlock:Run a command under Landlock+seccomp (Linux only)' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex sandbox commands' commands "$@"
}
(( $+functions[_codex__sandbox__help_commands] )) ||
_codex__sandbox__help_commands() {
    local commands; commands=(
'macos:Run a command under Seatbelt (macOS only)' \
'linux:Run a command under Landlock+seccomp (Linux only)' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'codex sandbox help commands' commands "$@"
}
(( $+functions[_codex__sandbox__help__help_commands] )) ||
_codex__sandbox__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'codex sandbox help help commands' commands "$@"
}
(( $+functions[_codex__sandbox__help__linux_commands] )) ||
_codex__sandbox__help__linux_commands() {
    local commands; commands=()
    _describe -t commands 'codex sandbox help linux commands' commands "$@"
}
(( $+functions[_codex__sandbox__help__macos_commands] )) ||
_codex__sandbox__help__macos_commands() {
    local commands; commands=()
    _describe -t commands 'codex sandbox help macos commands' commands "$@"
}
(( $+functions[_codex__sandbox__linux_commands] )) ||
_codex__sandbox__linux_commands() {
    local commands; commands=()
    _describe -t commands 'codex sandbox linux commands' commands "$@"
}
(( $+functions[_codex__sandbox__macos_commands] )) ||
_codex__sandbox__macos_commands() {
    local commands; commands=()
    _describe -t commands 'codex sandbox macos commands' commands "$@"
}

if [ "$funcstack[1]" = "_codex" ]; then
    _codex "$@"
else
    compdef _codex codex
fi
