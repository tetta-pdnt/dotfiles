eval "$(mise activate zsh)"
eval "$(zoxide init zsh --hook prompt)"

export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export ABBR_GET_AVAILABLE_ABBREVIATION=1
export ABBR_LOG_AVAILABLE_ABBREVIATION=1
