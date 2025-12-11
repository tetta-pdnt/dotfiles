# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using Nix Flakes for macOS (aarch64-darwin) system configuration. It uses both nix-darwin for system-level configuration and home-manager for user-level package management.

## Architecture

### Flake Structure

The repository is organized with a single [flake.nix](flake.nix) that defines two main configurations:

1. **homeConfigurations.myHomeConfig**: User environment managed by home-manager
   - Defined in [home-manager/default.nix](home-manager/default.nix)
   - Manages user packages, dotfiles, and application installations via brew-nix
   - Handles Homebrew casks through the brew-nix overlay

2. **darwinConfigurations.myDarwinConfig**: System-level configuration via nix-darwin
   - Defined in [darwin/default.nix](darwin/default.nix)
   - Manages macOS system defaults (Finder, Dock, keyboard shortcuts)
   - Handles system services like karabiner-elements
   - Contains activation scripts (Rosetta 2, keyboard shortcut disabling)

### Key Dependencies

- **nixpkgs**: Unstable channel (main package source)
- **nixpkgs-stable**: 24.05 (used for specific packages like karabiner-elements)
- **brew-nix**: Enables installation of Homebrew casks through Nix
- **nix-darwin**: macOS system configuration framework
- **home-manager**: User environment management

### Package Management Strategy

The configuration uses a hybrid approach:

- CLI tools and open-source packages: Installed via nixpkgs in home-manager
- GUI applications (casks): Installed via brew-nix overlay in home-manager
- Special cases: Some packages (like karabiner-elements, vivaldi) require manual overlay handling

## Common Commands

### System Updates

Update flake inputs, home-manager, and nix-darwin together:
```bash
nix run .#update
```

### Individual Updates

Update home-manager only:
```bash
nix run nixpkgs#home-manager -- switch --flake .#myHomeConfig
```

Update nix-darwin only (requires sudo):
```bash
sudo nix run nix-darwin -- switch --flake .#myDarwinConfig
```

Update flake.lock:
```bash
nix flake update
```

### Configuration Files

User dotfiles are symlinked from the repository root to keep the home directory clean:
- `.zshenv` → `~/.zshenv` (defines `ZDOTDIR` to point to `~/.config/zsh`)
- All other dotfiles are placed in `~/.config/` via `xdg.configFile` in home-manager

Key XDG configuration files:
- `karabiner/karabiner.json` → `~/.config/karabiner/karabiner.json`
- `nb/.nbrc` → `~/.config/nb/.nbrc` (nb configuration, referenced by `NBRC_PATH` in config/zsh/sync/sync.zsh)
- `zsh` → `~/.config/zsh` (entire zsh configuration directory)
- `git` → `~/.config/git`
- `yazi` → `~/.config/yazi`

## Important Notes

### Karabiner-Elements Configuration

Karabiner is configured in two places:
1. System service enabled in darwin/default.nix (line 116)
2. Package installed from nixpkgs-stable in home-manager/default.nix (line 51)
3. Configuration file managed via home-manager file linking (line 59-62)

### Homebrew Integration

Homebrew is enabled in darwin configuration but most casks are installed through brew-nix in home-manager. The darwin homebrew.casks list (line 111-113) should only contain packages that cannot be installed via brew-nix.

### macOS Keyboard Shortcuts

The darwin configuration disables numerous macOS default keyboard shortcuts (defined in disabledShortcuts list, lines 4-7). Changes take effect after logout/login.

### Vivaldi Browser

Vivaldi requires a custom override to handle XZ-compressed archives (home-manager lines 4-9).

### Yazi Plugin Management

Yazi plugins are fully managed by Nix using Home Manager's `xdg.configFile`. All plugins are defined in [home-manager/default.nix](home-manager/default.nix).

#### Currently Installed Plugins

- **starship.yazi** - Status line with shell prompt integration
- **diff.yazi** - File diff viewer
- **full-border.yazi** - Full border UI theme
- **smart-enter.yazi** - Smart enter key behavior

#### Adding a New Plugin

1. **Get the plugin's rev and hash**:

```bash
# For plugins in separate repositories
nix-shell -p nix-prefetch-github --run "nix-prefetch-github <owner> <repo> --rev <commit-hash>"

# For yazi-rs/plugins repository
nix-shell -p nix-prefetch-github --run "nix-prefetch-github yazi-rs plugins --rev <commit-hash>"
```

2. **Add to home-manager/default.nix**:

For standalone plugin repositories:
```nix
"yazi/plugins/plugin-name.yazi".source = pkgs.fetchFromGitHub {
  owner = "author";
  repo = "plugin-name.yazi";
  rev = "commit-hash";
  hash = "sha256-...";
};
```

For plugins in yazi-rs/plugins:
```nix
"yazi/plugins/plugin-name.yazi".source = pkgs.fetchFromGitHub {
  owner = "yazi-rs";
  repo = "plugins";
  rev = "commit-hash";
  hash = "sha256-...";
} + "/plugin-name.yazi";
```

3. **Apply changes**:
```bash
nix run .#update
```

See [config/yazi/README.md](config/yazi/README.md) for detailed documentation.

### nb Configuration

The `nb` note-taking tool is configured to keep the home directory clean:

1. **Configuration file**: `config/nbrc.sh` is symlinked to `~/.config/nb/.nbrc`
2. **Environment variable**: `NBRC_PATH` is set in [config/zsh/sync/sync.zsh](config/zsh/sync/sync.zsh) to point to `~/.config/nb/.nbrc`
3. **Notes directory**: By default, nb uses `~/.nb` for notes. This can be changed by adding `export NB_DIR=/path/to/notes` in `config/nbrc.sh`

To modify nb settings:
- Edit `config/nbrc.sh` to add environment variables
- Or use `nb set <setting> <value>` which will write to the config file
- Apply changes with `nix run .#update`

### macOS System Settings

System-level macOS preferences are managed in [darwin/default.nix](darwin/default.nix):

- **Window restoration**: `NSQuitAlwaysKeepsWindows = false` prevents reopening windows from previous session on startup
- **Keyboard repeat**: Fast key repeat (`KeyRepeat = 2`, `InitialKeyRepeat = 15`)
- **Mouse/trackpad**: Custom scaling values for precise control
- **Dark mode**: Always enabled (`AppleInterfaceStyle = "Dark"`)
- **Natural scrolling**: Disabled for traditional scroll direction
