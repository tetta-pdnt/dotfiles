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
    "ghostty/config".source = ../config/ghostty.txt;
    "lazygit/config.yml".source = ../config/lazygit.yaml;
    "git".source = ../config/git;
    "nb/.nbrc".source = ../config/nbrc.sh;
    "nvim".source = ../config/nvim;

    # Yazi configuration files
    "yazi/yazi.toml".source = ../config/yazi/yazi.toml;
    "yazi/keymap.toml".source = ../config/yazi/keymap.toml;
    "yazi/theme.toml".source = ../config/yazi/theme.toml;
    "yazi/init.lua".source = ../config/yazi/init.lua;

    # Yazi plugins managed by Nix
    "yazi/plugins/starship.yazi".source = pkgs.fetchFromGitHub {
      owner = "Rolv-Apneseth";
      repo = "starship.yazi";
      rev = "eca1861";
      hash = "sha256-xcz2+zepICZ3ji0Hm0SSUBSaEpabWUrIdG7JmxUl/ts=";
    };

    "yazi/plugins/diff.yazi".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "19dc890";
      hash = "sha256-Hml7n07G6tEOPUPOFN9jf01C5LtZRO8pfERVHKHJQRo=";
    } + "/diff.yazi";

    "yazi/plugins/full-border.yazi".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "19dc890";
      hash = "sha256-Hml7n07G6tEOPUPOFN9jf01C5LtZRO8pfERVHKHJQRo=";
    } + "/full-border.yazi";

    "yazi/plugins/smart-enter.yazi".source = pkgs.fetchFromGitHub {
      owner = "yazi-rs";
      repo = "plugins";
      rev = "19dc890";
      hash = "sha256-Hml7n07G6tEOPUPOFN9jf01C5LtZRO8pfERVHKHJQRo=";
    } + "/smart-enter.yazi";
  };

  programs.home-manager.enable = true;
}
