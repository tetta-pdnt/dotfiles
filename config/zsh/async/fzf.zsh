export FZF_DEFAULT_OPTS="
  --multi
  --reverse
  --border=rounded
  --inline-info
  --height=60%
  --select-1
  --exit-0
  --color='hl:-1:reverse,hl+:-1:reverse'
"

export FZF_CTRL_T_COMMAND="
  rg --files --no-ignore --hidden --follow \
  --glob '!{.git,.cache,Library,Downloads,Movies,Music,Applications (Parallels),.DS_Store,.zsh_session,node_modules}'
"
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always  {}'
  --bind '?:toggle-preview'
"

export FZF_ALT_C_COMMAND='fd --type d'
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --color=always {} | head -200'"

export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window up:3:hidden:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --bind 'ctrl-/:toggle-preview'
"

export _ZO_FZF_OPTS="
  --reverse
  --style=full:rounded
  --height 75%
  --preview 'eza -l --icons --sort modified -r --color=always {2..}'
  --preview-window=down,50%,wrap
  --no-sort
  --exact
"

_fzf_cache="$HOME/.cache/fzf.zsh"
if [[ ! -f $_fzf_cache || "$(command -v fzf)" -nt $_fzf_cache ]]; then
  mkdir -p "${_fzf_cache:h}"
  fzf --zsh > "$_fzf_cache"
fi
source "$_fzf_cache"
