{ inputs, username, stateVersion, fontFamily, driveMountPath, ... }:

let
  mkSystem = hostName: aspectModules:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs username stateVersion fontFamily driveMountPath hostName;
        self = inputs.self;
      };
      modules = [
        ../hosts/${hostName}/default.nix
        inputs.home-manager.nixosModules.home-manager
        {
          nixpkgs.pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            overlays = [ (import inputs.rust-overlay) ];
            config.allowUnfree = true;
          };

          home-manager = {
            extraSpecialArgs = {
              inherit inputs username stateVersion fontFamily driveMountPath
                hostName;
              self = inputs.self;
            };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              imports = [ ../users/${username}/default.nix ];
            };
            backupFileExtension = "backup";
          };
        }
      ] ++ aspectModules;
    };
in mkSystem
