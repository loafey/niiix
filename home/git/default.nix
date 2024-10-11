{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Samuel Hammersberg";
    userEmail = "samuel.hammersberg@gmail.com";
    extraConfig = {
      pull.rebase = true;
    };

    includes = [
      { path = "~/.gitconfig.local"; }
    ];
  };
}
