{ inputs, ... }:
let
  username = "andrew";
  stateVersion = "25.11";
  fontFamily = "CaskaydiaCove Nerd Font";
  driveMountPath = "/home/${username}/gdrive";
  mkSystem = import ../lib/mksystem.nix {
    inherit inputs username stateVersion fontFamily driveMountPath;
  };
  mkHome = import ../lib/mkHome.nix {
    inherit inputs username stateVersion fontFamily driveMountPath;
  };
in {
  flake.nixosConfigurations = {
    andrew-pc = mkSystem "andrew-pc" [
      inputs.aic8800.nixosModules.default
      ../aspects/base
      ../aspects/system
      ../aspects/desktop
      ../aspects/apps
      ../aspects/dev
    ];

    andrew-laptop = mkSystem "andrew-laptop" [
      inputs.aic8800.nixosModules.default
      ../aspects/base
      ../aspects/system
      ../aspects/desktop
      ../aspects/apps
      ../aspects/dev
    ];
  };
  flake.homeConfigurations = {
	  andrew-work-pc = mkHome "andrew-work-pc" [
		  ../aspects/dev
			  ../aspects/apps/features/agents.nix
			  ../aspects/apps/features/misc.nix
			  ../aspects/system/features/cli-tools.nix
	  ];
  };
}
