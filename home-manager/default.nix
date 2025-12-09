{ inputs, lib, config, pkgs, ... }:
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
      lazygit
      fzf
      bat
      eza
      ripgrep
      fd
      zoxide
      delta
      as-tree
    ] ++ (with pkgs.brewCasks; [
      ghostty
      raycast
      claude-code
      notunes
      visual-studio-code
      obsidian
      jetbrains-toolbox
      cmd-eikana
      bitwarden
    ]) ++ [ vivaldi ];
    username = "tetta";
    homeDirectory = "/Users/tetta";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}

