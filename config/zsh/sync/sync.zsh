eval "$(starship init zsh)"

export XDG_CONFIG_HOME="$HOME/.config"
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export NIX_USER_CONF_FILES="$XDG_CONFIG_HOME/nix/nix.conf:${XDG_CONFIG_HOME}/nix/local.conf"
