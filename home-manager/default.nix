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

  home.file = {
    ".zshenv".source = ../config/zsh/.zshenv;
  };

  xdg.configFile = {
    "karabiner/karabiner.json".source = ../config/karabiner.json;
    "sheldon/plugins.toml".source = ../config/sheldon.toml;
    "starship.toml".source = ../config/starship.toml;
    "eza/theme.yml".source = ../config/eza.yaml;
    "zsh".source = ../config/zsh;
    "zsh-abbr/user-abbreviations".source = ../config/zsh-abbr;
    "ghostty/config".source = ../config/ghostty;
    "lazygit/config.yml".source = ../config/lazygit.yaml;
    "git".source = ../config/git;
  };

  programs.home-manager.enable = true;
}
