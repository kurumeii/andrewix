{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [
    fuse
    usbutils
    pciutils
    wl-clipboard
    wl-clip-persist
    cliphist
    caprine
    gnomeExtensions.kimpanel
  ];
  programs.firefox.enable = true;
}
