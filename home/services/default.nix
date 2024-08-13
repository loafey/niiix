{ pkgs, ... }:
{
  systemd.user.services =
    let
      range = pkgs.lib.concatStrings
        (
          map
            (p: ''-L ${builtins.toString p}:localhost:${builtins.toString p} '')
            (pkgs.lib.lists.range 10666 10676)
        );
    in
    {
      ssh-tunnels = {
        Unit = {
          Description = ''SSH Tunnel 2049 10666-10676'';
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = "${pkgs.writeShellScript "ssh-tunnels" ''
              #!/run/current-system/sw/bin/bash
              ${pkgs.openssh}/bin/ssh -nNT -L 2049:localhost:2049 ${range} dev.loafey.se
              ''}";
          Restart = "always";
          RestartSec = "5s";
        };
      };
    };
}
