ghq-fzf() {
  local repo=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.md 2>/dev/null || eza -T -L 1 $(ghq root)/{}")
  if [[ -n "$repo" ]]; then
    BUFFER="cd $(ghq root)/$repo"
    zle accept-line
  fi
  zle reset-prompt
}

y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

sudo-command-line() {
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
  if [[ $BUFFER == sudo\ * ]]; then
    LBUFFER="${LBUFFER#sudo }"
  else
    LBUFFER="sudo $LBUFFER"
  fi
}

if (( $+command[gh] )); then
  gh() {
    unfunction gh
    eval "$(command gh completion -s zsh)"
    command gh "$@"
  }
fi
