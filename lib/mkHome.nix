{ inputs, username, stateVersion, fontFamily, driveMountPath, ... }:

let
  mkHome = hostname: aspectModules:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = [ (import inputs.rust-overlay) ]; 
      };
      extraSpecialArgs = {
        inherit inputs username stateVersion fontFamily driveMountPath hostname;
        self = inputs.self;
      };
      modules = [
        ../users/${username}/default.nix
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = stateVersion;
          # QUAN TRỌNG: Kích hoạt chế độ tương thích cho Fedora/Ubuntu/WSL
          targets.genericLinux.enable = true; 
          programs.home-manager.enable = true;
        }
      ] 
      ++ aspectModules;
    };
in mkHome
