{ hostname, ... }:
let email = if hostname == "andrew-work-pc" then "babybangunny@gmail.com" else "andrew.nguyen1@techvify.com.vn";
in 
{
  programs.git = {
    enable = true;
    settings = {
      user.email = email;
      user.name = "Andrew Nguyen";
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = { editor = "nvim"; };
  };
  programs.lazygit = {
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

  programs.difftastic = {
    enable = true;
    # git.enable = true; # Removed because it might conflict or be redundant if difftastic is enabled
    # git.diffToolMode = true;
  };
}
