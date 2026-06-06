eval "$(mise activate zsh)"
eval "$(zoxide init zsh --hook prompt)"

export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1
export SHELL_SESSIONS_DISABLE=1
export HOMEBREW_FORBIDDEN_FORMULAE="node python python3 pip npm pnpm yarn claude"
export ENABLE_TOOL_SEARCH=true
export ENABLE_EXPERIMENTAL_MCP_CLI=false
