{ inputs, pkgs, ... }:

let

  vivaldi = pkgs.brewCasks.vivaldi.overrideAttrs (o: {
    nativeBuildInputs = o.nativeBuildInputs ++ [ pkgs.xz ];
    unpackPhase = ''
      tar -xJf $src
    '';
  });

in {

  nixpkgs.overlays = [
    inputs.brew-nix.overlays.default
  ];

  home.packages = with pkgs; [
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
    sheldon
    nb
    bagels
  ] ++ (with pkgs.brewCasks; [
    ghostty
    raycast
    claude-code
    notunes
    obsidian
    jetbrains-toolbox
    bitwarden
  ]) ++ [
    vivaldi
  ];
}
