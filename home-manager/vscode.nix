{ pkgs, ... }:

let
  # Override Claude Code extension with correct hash
  claude-code = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "claude-code";
      publisher = "anthropic";
      version = "2.0.59";
      hash = "sha256-QDUW5VXhFE6eSg1A+kbyMznys/o6EfVsU7AoilLGa+g=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Allow manual installation of extensions not available in nixpkgs
    mutableExtensionsDir = true;

    profiles.default = {
      # Disable update checks
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      userSettings = {
      # Editor settings
      "editor.fontSize" = 13;
      "editor.fontFamily" = "'Source Han Code JP N', monospace";
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "selection";
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.smoothScrolling" = true;
      "editor.bracketPairColorization.enabled" = false;
      "editor.guides.bracketPairs" = false;
      "editor.wordWrap" = "on";

      # Vim settings
      "vim.leader" = "<space>";
      "vim.easymotion" = true;
      "vim.insertModeKeyBindings" = [
        {
          "before" = ["j" "j"];
          "after" = ["<Esc>"];
        }
      ];
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = ["s"];
          "after" = ["<leader>" "<leader>" "s"];
        }
      ];

      # Workbench settings
      "workbench.colorTheme" = "Default Dark Modern";
      "workbench.iconTheme" = "vs-seti";
      "workbench.startupEditor" = "none";
      "workbench.editor.enablePreview" = false;
      "workbench.list.smoothScrolling" = true;

      # Terminal settings
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'HackGen Console NF', monospace";
      "terminal.integrated.smoothScrolling" = true;

      # File settings
      "files.autoSave" = "afterDelay";
      "files.autoSaveDelay" = 1000;
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;

      # Git settings
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "git.enableSmartCommit" = true;

      # Search settings
      "search.exclude" = {
        "**/.git" = true;
        "**/node_modules" = true;
        "**/dist" = true;
        "**/build" = true;
        "**/.next" = true;
        "**/.nuxt" = true;
      };

      # Window settings
      "window.restoreWindows" = "none";
      "window.zoomLevel" = 0;
      };

      keybindings = [
        # IntelliJ-style Search Everywhere with Shift+Shift
        {
          key = "shift shift";
          command = "workbench.action.quickTextSearch";
        }
      ];

      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        jnoortheen.nix-ide
        eamodio.gitlens
        esbenp.prettier-vscode
      ] ++ [
        claude-code
      ];
    };
  };
}
