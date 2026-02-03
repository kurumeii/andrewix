{ ... }: {
  home-manager.users.andrew.programs.git = {
    enable = true;
    settings = {
      user.email = "babybangunny@gmail.com";
      user.name = "Andrew Nguyen";
    };
  };
  home-manager.users.andrew.programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = { editor = "nvim"; };
  };
  home-manager.users.andrew.programs.lazygit = {
    enable = true;
    settings = {
      git = {
        pagers =
          [{ externalDiffCommand = "difft --color=always --display=inline"; }];
      };
      gui = {
        nerdFontsVersion = "3";
        showBranchCommitHash = true;
        showCommandLog = true;
        spinner = {
          frames = [ "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏" ];
          rate = 120;
        };
      };
    };
  };

  home-manager.users.andrew.programs.difftastic = {
    enable = true;
    # git.enable = true; # Removed because it might conflict or be redundant if difftastic is enabled
    # git.diffToolMode = true;
  };
}
