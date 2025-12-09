{pkgs, ...}: {

  nix.enable = false;

  system = {
    defaults = {
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
      };
    };

    primaryUser = "tetta";
    stateVersion = 6;
  };
}

