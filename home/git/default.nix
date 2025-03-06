{ ... }: {
  programs.git = {
    enable = true;
    userName = "Samuel Hammersberg";
    userEmail = "samuel@loafey.se";
    extraConfig = {
      gpg.format = "ssh";
      pull.rebase = true;
      user.signingKey = "/home/loafey/.ssh/id_ed25519.pub";
      commit.gpgSign = true;
    };

    includes = [{ path = "~/.gitconfig.local"; }];
  };
}

