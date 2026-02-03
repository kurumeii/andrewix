{ inputs, ... }:
let
  username = "andrew";
  stateVersion = "25.11";
  fontFamily = "CaskaydiaCove Nerd Font";
  driveMountPath = "/home/${username}/gdrive";
  mkSystem = import ../lib/mksystem.nix {
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
}
