{ inputs, lib, config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      git
      curl
      neovim
      gh
      lazygit
      fzf
      bat
      eza
      ripgrep
      fd
      zoxide
      delta
      as-tree
    ];

    username = "tetta";
    homeDirectory = "/Users/tetta";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}

