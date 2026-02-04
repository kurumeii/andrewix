inputs@{ pkgs, username, ... }:
{
  home.packages = with pkgs; [
    vim
    wget
    git
    nh
    ast-grep
    pnpm
    nodePackages.nodejs
    bun
  ];


  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 5";
    flake = "/home/${username}/dotconfigs";
  };
}
