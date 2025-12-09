{ inputs, lib, config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      git
      curl
    ];

    username = "tetta";
    homeDirectory = "/Users/tetta";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}

