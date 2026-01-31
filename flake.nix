{
	description = "Andrewix - flake it till we hit it";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		homeManager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		neovimNightly.url = "github:nix-community/neovim-nightly-overlay";
	};
	outputs = { self, nixpkgs, homeManager, ... }@inputs:
		let 
		system = "x86_64-linux";
	username = "andrew";
	hostName = "andrewix";
	stateVersion = "25.11";
	fontFamily = "JetBrainsMono Nerd Font";
	pkgs = nixpkgs.legacyPackages.${system};
	in {
		nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = {
				inherit inputs username
				hostName stateVersion
				fontFamily self;
			};
			modules = [ 
			./nixos/configuration.nix
			homeManager.nixosModules.home-manager
			{
				nixpkgs.overlays = [
					inputs.neovimNightly.overlays.default
				];
				home-manager = {
					extraSpecialArgs = {
						inherit inputs username
						hostName stateVersion
						fontFamily self;
					};
					useGlobalPkgs = true;
					useUserPackages = true;
					users.${username} = import ./home.nix;
					backupFileExtension = "backup";
				};
			}
			];
		};
	};
}
