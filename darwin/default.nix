{ inputs, lib, pkgs, system, ... }:
let

  disabledShortcuts = [
    32 34 33 35 36 37 62 63 79 80 81 82
    118 119 120 121 122 123 124 125 126
    64 65 70 160 163 164 175
  ];

  disableShortcutCommands = lib.concatMapStringsSep "\n"
    (id: ''defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add ${toString id} "<dict><key>enabled</key><false/></dict>"'')
    disabledShortcuts;

in {

  nix.enable = false;
  
  system = {
    activationScripts = {
      preActivation.text = ''
        echo "Checking for Rosetta 2..."
        if ! /usr/bin/pgrep oahd > /dev/null 2>&1; then
          echo "Installing Rosetta 2..."
          /usr/sbin/softwareupdate --install-rosetta --agree-to-license
        else
          echo "Rosetta 2 is already installed."
        fi
      '';
      
      disableKeyboardShortcuts.text = ''
        echo "Disabling macOS keyboard shortcuts..."
        ${disableShortcutCommands}
        echo "Keyboard shortcuts disabled. Changes will take effect after logout/login."
      '';
    };
    
    defaults = {
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
        ShowStatusBar = true;
        ShowPathbar = true;
        CreateDesktop = false;
        _FXShowPosixPathInTitle = true;
      };
      
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "bottom";
        tilesize = 32;
        largesize = 48;
        static-only = true;
        mineffect = "scale";
        launchanim = false;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.5;
      };
      
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
        };
      };
      
      WindowManager = {
        StandardHideDesktopIcons = true;
      };
      
      menuExtraClock = {
        Show24Hour = true;
        ShowDate = 0;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };
      
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        AppleInterfaceStyle = "Dark";
        "com.apple.swipescrolldirection" = false;
        "com.apple.trackpad.scaling" = 3.0;
      };

      ".GlobalPreferences"."com.apple.mouse.scaling" = 6.0;
    };
    
    primaryUser = "tetta";
    stateVersion = 6;
  };
  
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    casks = [
      "google-japanese-ime"
      "karabiner-elements"
    ];
  };

  fonts = {
    packages = with pkgs; [
      hackgen-nf-font
      source-han-code-jp
    ];
  };
}
