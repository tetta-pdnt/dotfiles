{ inputs, pkgs, system, ... }:

let

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
    uv
    himalaya
    unar
    zed-editor
  ] ++ (with pkgs.brewCasks; [
    ghostty
    raycast
    notunes
    obsidian
    jetbrains-toolbox
    bitwarden
    monitorcontrol
    android-studio
    alt-tab
    epic-games
  ]) ++ (with inputs.llm-agents.packages.${system}; [
    claude-code
    amp
  ]);
}
