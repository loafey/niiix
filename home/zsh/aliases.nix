{
  ll = "ls -l";
  nix-update = "nu ~/Git/niiix/home/scripts/update.nu";
  devcode = "nix develop --command bash -c \"code . --enable-features=UseOzonePlatform --ozone-platform=wayland\"";
  devnu = "nix develop --command bash -c \"zsh\"";
  pulk = "git pull --rebase";
  pull = "git pull";
  push = "git push";
  commit = "git commit -m";
  add = "git add";
  pc = "ssh dev.loafey.se -t \"./pc\"";
  direnv-setup = "echo \"use flake\" > .envrc; direnv allow";
}
