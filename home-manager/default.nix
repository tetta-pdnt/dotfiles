{ inputs, lib, config, pkgs, system, ... }:
let

  vivaldi = pkgs.brewCasks.vivaldi.overrideAttrs (o: {
    nativeBuildInputs = o.nativeBuildInputs ++ [ pkgs.xz ];
    unpackPhase = ''
      tar -xJf $src
    '';
  });

in {

  nixpkgs = {
    overlays = [
      inputs.brew-nix.overlays.default
    ];
  };

  home = {
    packages = with pkgs; [
      git
      curl
      neovim
      gh
      ghq
      lazygit
      fzf
      bat
      eza
      ripgrep
      fd
      zoxide
      delta
      as-tree
      jq
      starship
      yazi
      mise
      ni
    ] ++ (with pkgs.brewCasks; [
      ghostty
      raycast
      claude-code
      notunes
      visual-studio-code
      obsidian
      jetbrains-toolbox
      bitwarden
    ]) ++ [
      vivaldi
    ];
    username = "tetta";
    homeDirectory = "/Users/tetta";
    stateVersion = "25.11";

    file = {
      ".zshrc".source = ../.zshrc;
      ".config/karabiner/karabiner.json" = {
        source = ../.config/karabiner/karabiner.json;
        force = true;
      };
    };
  };

  programs.home-manager.enable = true;
}

