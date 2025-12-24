{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Samuel Hammersberg";
        email = "samuel@loafey.se";
      };
      gpg.format = "ssh";
      pull.rebase = true;
      user.signingKey = "/home/loafey/.ssh/id_ed25519.pub";
      commit.gpgSign = true;
      url."git@github.com:" = { insteadOf = "https://github.com/"; };
    };

    includes = [{ path = "~/.gitconfig.local"; }];
  };
}

