# Andrewix - NixOS & Home Manager Configuration

A modular, auto-importing configuration for NixOS and Home Manager using flake-parts and import-tree.

## Quick Start

Apply the latest configuration:
```bash
nh os switch ~/dotconfigs
```

Update all flake inputs:
```bash
nix flake update --flake ~/dotconfigs
```

Check for errors before applying:
```bash
nix flake check
```

## Directory Structure

- `modules/system/features/` - System-level modules (NixOS). Auto-imported via import-tree.
- `modules/user/features/` - User-level modules (Home Manager). Auto-imported via import-tree.
- `modules/hosts/<hostname>/` - Host-specific configurations (hardware, hostname).
- `modules/flake/` - Flake logic and `mkSystem` helper.

## Adding New Features

Create a new `.nix` file in the appropriate `features/` directory. It will be auto-imported.

Example for a user module (`modules/user/features/myapp.nix`):
```nix
{ pkgs, ... }: {
  programs.myapp = {
    enable = true;
    # Your configuration here
  };
}
```

## Code Style

- **Files:** kebab-case.nix
- **Variables:** camelCase
- **Booleans:** enable/disable prefix
- **Formatter:** nixfmt with 2-space indentation

## Hosts

- `andrew-pc` - Desktop workstation
- `andrew-laptop` - Laptop (includes aic8800 WiFi driver)

## References

See [AGENTS.md](AGENTS.md) for developer documentation on building, testing, and code conventions.
