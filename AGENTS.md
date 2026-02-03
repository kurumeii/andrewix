# AGENTS.md - NixOS Dotfiles Configuration (Andrewix)

This repository contains Andrew's NixOS and Home Manager configuration. It follows a modular architecture using the **Dendritic** structure with `import-tree`. This file serves as the primary manual for autonomous agents operating in this repository.

## 🛠️ Build, Test & Maintenance Commands

### System Management (Primary)
```bash
# Apply changes and switch to new configuration
nh os switch ~/dotconfigs

# Dry-run switch (preview changes without applying - HIGHLY RECOMMENDED for complex changes)
nh os switch ~/dotconfigs --dry-run

# Update all flake inputs
nix flake update --flake ~/dotconfigs

# Cleanup nix garbage and old generations
nh clean all
```

### Validation & Testing
**Always run these before confirming a task is complete.**

```bash
# 1. Formatting (Essential)
# Format all files in the current directory recursively
nixfmt .

# 2. Linting / Checking (Essential)
# Check the entire flake for evaluation errors (syntax, missing vars)
nix flake check

# 3. Component Testing
# Evaluate a specific module to check for syntax errors without building the whole system
nix-instantiate --parse aspects/base/features/<name>.nix

# Check Home Manager configuration validity specifically
nix-instantiate -E '(import ./users/andrew/default.nix {inherit inputs;}).outPath'
```

### Search & Shell
```bash
# Search for packages (use this instead of guessing package names)
nh search <package-name>

# Enter the project development shell (has nix tools available)
nix develop
```

## 🏗️ Architecture & Conventions

### Module Structure (Dendritic)
The configuration is split into **Aspects** (functional logic) and **Hosts** (hardware/definitions).

- **`aspects/`**: Contains the core logic. Divided into categories:
  - `base/`: Core system settings (locale, fonts, security)
  - `system/`: System-wide services (docker, audio, networking)
  - `desktop/`: GUI applications, window managers (Hyprland), theming
  - `apps/`: User-land applications (browsers, productivity)
  - `dev/`: Development environments and tools
- **`features/` folder pattern**: Inside each aspect (e.g., `aspects/system/features/`), any `.nix` file added is **automatically imported**.
- **`users/`**: Home Manager identities. Note that most *feature* config happens in `aspects`, not here.
- **`hosts/`**: Hardware definitions and the `default.nix` registry.
- **`lib/`**: Helper functions, primarily `mksystem.nix`.

### Code Style Guidelines

#### General Patterns
- **Standard Module Header:**
  ```nix
  { config, pkgs, inputs, lib, ... }: {
    # implementation
  }
  ```
- **Aspect Bundles:** definition files in `aspects/<name>/default.nix` must strictly follow:
  ```nix
  { inputs, ... }: { imports = [ (inputs.import-tree ./features) ]; }
  ```
- **Global Variables:**
  - `driveMountPath`: Parameterized path for rclone mounts.
  - `fontFamily`: The primary system font.
  - `username`: "andrew"
  - `stateVersion`: "25.11"

#### Naming Conventions
- **Files:** `kebab-case.nix` (e.g., `keepassxc.nix`, `git-config.nix`)
- **Variables:** `camelCase` (e.g., `hostName`, `driveMountPath`)
- **Booleans:** Prefix with `enable` (e.g., `enable = true;`)
- **Hostnames:** `andrew-pc` (desktop), `andrew-laptop` (portable)

#### Formatting Rules
- **Tool:** `nixfmt` (RFC 166 style)
- **Indentation:** 2 spaces.
- **Lists:** Multi-line lists should have one element per line.
- **Blocks:** Open `{` on the same line, close `}` on a new line with matching indentation.

### ⚠️ Critical Implementation Details

#### 1. Home Manager vs. NixOS
This is a **hybrid** configuration.
- **System-level settings** (networking, users, boot) go directly under `config.*`.
- **User-level settings** (VSCode, dotfiles, Git) **MUST** be nested under `home-manager.users.${username}` within the aspect files.
  *   *Incorrect:* `programs.git.enable = true;` (in a system module)
  *   *Correct:* `home-manager.users.${username}.programs.git.enable = true;`

#### 2. Adding New Features (Agent Workflow)
1.  **Identify Category:** Choose the correct `aspects/<category>/features/` directory.
2.  **Create File:** Create `my-new-feature.nix`.
3.  **Implement:**
    *   If it needs a package: `environment.systemPackages = [ pkgs.name ];`
    *   If it needs user config: `home-manager.users.${username}.programs.name = { ... };`
4.  **No Import Needed:** Do *not* manually add it to an imports list. `import-tree` handles it.
5.  **Format & Check:** Run `nixfmt .` and `nix flake check`.

#### 3. Error Handling
- **Infinite Recursion:** Usually caused by circular imports or incorrect `useUserPackages` usage. Check module arguments.
- **Missing Attribute:** Ensure you are using `pkgs.lib` or `lib` correctly and that the package exists in `pkgs`.
- **Immutable Files:** Do not edit `flake.lock` manually. Use `nix flake update`.

## 📂 Repository Layout Reference
```
~/dotconfigs/
├── flake.nix              # Entry point
├── AGENTS.md              # This file
├── aspects/               # Functional modules
│   ├── base/features/     # Core files (auto-imported)
│   ├── system/features/   # Service files
│   ├── desktop/features/  # UI files
│   └── ...
├── users/                 # Home Manager identity
│   └── andrew/default.nix
├── hosts/                 # Host registry
│   └── default.nix        # GLOBAL ARGS DEFINED HERE
└── lib/                   # Helpers
    └── mksystem.nix       # System builder
```

## Git Workflow
1.  **Edit:** Make changes to modules.
2.  **Verify:** `nix flake check` -> **MUST PASS**.
3.  **Format:** `nixfmt .`
4.  **Apply:** `nh os switch ~/dotconfigs` (if requested by user).
5.  **Commit:** `git commit -am "category: brief description"`
