let
  loafey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgZEwdnAZcIrmJ+bCq5H8OlZlvTVpxce+5N85YKKo3o samuel@loafey.se";
in {
  "hardware/mango-basket/secrets/woof.age".publicKeys = [ loafey ];
  "hardware/mango-basket/secrets/rss.age".publicKeys = [ loafey ];
}
