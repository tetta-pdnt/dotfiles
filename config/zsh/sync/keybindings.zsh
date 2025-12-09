autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

zle -N ghq-fzf
bindkey "^g" ghq-fzf

zle -N sudo-command-line
bindkey "^s" sudo-command-line
