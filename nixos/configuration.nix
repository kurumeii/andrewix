{
  config,
  pkgs,
  hostName,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./programs.nix
    ./i18n.nix
    ./users/andrew.nix
    ./fonts.nix
    ./services.nix
    ./neovim.nix
  ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "fuse" ];
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Ho_Chi_Minh";
  security.rtkit.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  hardware.aic8800.enable = true;
  system.stateVersion = stateVersion;
}
