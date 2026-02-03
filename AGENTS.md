# AGENTS.md - NixOS Dotfiles Configuration (Andrewix)

This repository contains Andrew's NixOS and Home Manager configuration. It follows a modular architecture with automatic directory scanning.

## Build & Maintenance Commands

### System Management
```bash
# Apply changes and switch to new configuration
nh os switch ~/dotconfigs

# Update all flake inputs
nix flake update --flake ~/dotconfigs

# Check flake for evaluation errors
nix flake check

# Cleanup nix garbage and old generations
nh clean all

# Optimize nix store (deduplicate files)
nix store optimise
```

### Search & Shell
```bash
# Search for packages
nh search <package-name>

# Enter the project development shell
nix develop
```

### Testing Individual Modules
```bash
# Evaluate a specific module for errors (no system switch)
nix-instantiate --parse modules/user/features/<name>.nix

# Check Home Manager configuration
nix-instantiate -E '(import ./modules/user/home.nix {inherit inputs;}).outPath'

# Dry-run switch (preview changes without applying)
nh os switch ~/dotconfigs --dry-run
```

## Architecture & Conventions

### Module Structure
- **NixOS (System):** `modules/system/features/`
- **Home Manager (User):** `modules/user/features/`
- **Hosts:** `modules/hosts/<hostname>/`
- **Flake Logic:** `modules/flake/`

We use `vic/import-tree` to automatically import all `.nix` files within `features/` directories. Simply adding a new file there integrates it into the build.

### Code Style Guidelines

#### General Patterns
- **Standard module input:** `{ config, pkgs, inputs, ... }: { ... }`
- **Bundle files (aggregators):** `{ inputs, ... }: { imports = [ (inputs.import-tree ./features) ]; }`
- **Host configurations:** Define `mkSystem` helper in `modules/flake/hosts.nix` using `inputs.nixpkgs.lib.nixosSystem`
- Use `inherit` for repetitive attribute passing
- Organize settings by subsystem (e.g., `programs`, `services`)

#### Naming Conventions
- **Files:** `kebab-case.nix` (e.g., `keepassxc.nix`, `git-config.nix`)
- **Variables:** `camelCase` (e.g., `hostName`, `stateVersion`)
- **Booleans:** Prefix with `enable` or `disable` (e.g., `enable = true`)
- **Hostnames:** `andrew-pc`, `andrew-laptop` (defined in `modules/flake/hosts.nix`)

#### Imports
- Use relative paths within modules (e.g., `./module.nix`)
- System/User bundles use `inputs.import-tree` for auto-importing all feature files
- Never use absolute paths; use paths relative to the file location

#### Formatting
- **Formatter:** `nixfmt` for all `.nix` files
- **Indentation:** 2 spaces
- **Curly braces:** New line for `{` and closing `}` on same indentation as opening

#### Error Handling
- **State Version:** Fixed at `25.11`. **Do not change** unless performing manual migration
- Use `lib.mkIf` or `lib.mkDefault` for conditional configuration
- Always run `nix flake check` before committing structural changes
- Use `inputs.nixpkgs.lib` functions (`mkIf`, `mkDefault`, `mkForce`) for option overrides

#### Neovim (nvf)
- Configured via `programs.nvf.settings` when using nvf module
- Follow the nested structure: `vim.*`, `vim.languages.*`, `vim.mini.*`
- Keymaps: Use the `vim.keymaps` array with `mode`, `action`, and `desc`

## Repository Layout
```
~/dotconfigs/
├── flake.nix              # Entry point (flake-parts)
├── outputs.nix            # Flake outputs configuration
├── AGENTS.md              # This file
├── README.md              # User documentation
├── andrew.omp.json        # Oh My Posh theme
└── modules/
    ├── system/            # NixOS system-level config
    │   ├── features/     # Auto-imported NixOS modules
    │   └── configuration.nix
    ├── user/              # Home Manager user-level config
    │   ├── features/     # Auto-imported user modules
    │   ├── bundle.nix
    │   └── home.nix
    ├── hosts/             # Hardware/Host specific configs
    │   ├── andrew-pc/
    │   └── andrew-laptop/
    └── flake/             # mkSystem and host definitions
        ├── hosts.nix
        └── inputs.nix
```

## Important Variables
- **Username:** `andrew`
- **State Version:** `25.11`
- **Font Family:** `CaskaydiaCove Nerd Font`
- **LSPs:** `nixd` for Nix, `lua-language-server` for Lua

## Git Workflow
1. Make changes to feature modules in `modules/system/features/` or `modules/user/features/`
2. Run `nix flake check` to verify no evaluation errors
3. Run `nh os switch ~/dotconfigs` to apply changes
4. Commit with descriptive message explaining the change
