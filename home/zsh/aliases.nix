{
  ll = "ls -l";
  nix-update = "nu ~/Git/niiix/home/scripts/update.nu";
  devcode = "nix develop --command bash -c \"code . --enable-features=UseOzonePlatform --ozone-platform=wayland\"";
  devnu = "nix develop --command bash -c \"zsh\"";
  pulk = "git pull --rebase";
}
