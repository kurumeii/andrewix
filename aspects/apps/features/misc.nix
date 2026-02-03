{ pkgs, ... }: {
  home-manager.users.andrew.programs.zoxide.enable = true;
  home-manager.users.andrew.programs.bat.enable = true;
  home-manager.users.andrew.programs.eza.enable = true;
  home-manager.users.andrew.programs.fzf.enable = true;
  home-manager.users.andrew.programs.fastfetch.enable = true;
  home-manager.users.andrew.programs.fd.enable = true;
  home-manager.users.andrew.programs.bun.enable = true;
  home-manager.users.andrew.programs.ripgrep.enable = true;
  home-manager.users.andrew.programs.uv.enable = true;

  home-manager.users.andrew.programs.btop = {
    enable = true;
    settings = {
      color_theme = "tty";
      theme_background = false;
      vim_keys = true;
      proc_sorting = "memory";
      cpu_single_graph = true;
      show_disks = false;
    };
  };
  home-manager.users.andrew.programs.tealdeer = {
    enable = true;
    settings = {
      auto_update = true;
      display = {
        compact = false;
        use_pager = true;
        show_title = true;
      };
    };
  };
}
