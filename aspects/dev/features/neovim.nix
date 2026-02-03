{ config, pkgs, ... }:
let
  rust-nightly = pkgs.rust-bin.nightly.latest.default.override {
    extensions = [ "rust-src" "rust-analyzer" ];
  };
in {
  home-manager.users.andrew.programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      rust-nightly
      cargo
      ripgrep
      fd
      gcc
      unzip
      wget
      curl
      tree-sitter
      lua-language-server
    ];
  };

  # Link existing config
  home-manager.users.andrew.xdg.configFile."nvim".source =
    config.home-manager.users.andrew.lib.file.mkOutOfStoreSymlink
    "${config.home-manager.users.andrew.home.homeDirectory}/nvim";
}
