{
  ll = "lsd -lh";
  nix-update = "nu ~/Git/niiix/home/scripts/update.nu";
  devnvim = "nix develop --command nvim .";
  devcode = "nix develop --command bash -c \"code . --enable-features=UseOzonePlatform --ozone-platform=wayland\"";
  devnu = "nix develop --command bash -c \"zsh\"";
  pulk = "git pull --rebase";
  pull = "git pull";
  push = "git push";
  commit = "git commit -m";
  add = "git add";
  pc = "ssh dev.loafey.se -t \"./pc\"";
  direnv-setup = "echo \"use flake\" > .envrc; direnv allow";
  ls = "lsd";
  flake = "nix flake";
  nixos-rebuild = "nixos-rebuild --use-remote-sudo";
  gc = "sudo nix-collect-garbage -d --quiet 2> /dev/null; nix-collect-garbage -d --quiet 2> /dev/null";
  split-sync = "bash -c `tmux new-session -s \"splat\" -d && tmux split-window -h && tmux swap-pane -s 0 && tmux set synchronize-panes on && tmux -2 attach-session -d `";
}
