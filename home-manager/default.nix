{ inputs, lib, config, pkgs, system, ... }:

{
  imports = [
    ./apps.nix
  ];

  home = {
    username = "tetta";
    homeDirectory = "/Users/tetta";
    stateVersion = "25.11";
  };

  home.file.".zshenv".source = ../config/zsh/.zshenv;

  xdg.configFile = {
    "karabiner/karabiner.json" = {
      source = ../config/karabiner.json;
      force = true;
    };
    "sheldon/plugins.toml".source = ../config/sheldon.toml;
    "zsh".source = ../config/zsh;
    "zsh-abbr/user-abbreviations".source = ../config/zsh-abbr;
    "ghostty/config".source = ../config/ghostty;
  };

  programs.home-manager.enable = true;
}
