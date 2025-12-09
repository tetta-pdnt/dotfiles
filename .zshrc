export NIX_USER_CONF_FILES="${XDG_CONFIG_HOME}/nix/nix.conf:${XDG_CONFIG_HOME}/nix/local.conf"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Completion
autoload -Uz compinit
compinit

# zoxide (cd replacement)
eval "$(zoxide init zsh)"

# fzf
eval "$(fzf --zsh)"

# Aliases
alias ls='eza'
alias ll='eza -l'
alias la='eza -la'
alias cat='bat'
alias cd='z'

