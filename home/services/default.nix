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
          Description = ''SSH Tunnel 2049 6969 18080 18081'';
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = "${pkgs.writeShellScript "ssh-tunnels" ''
              #!/run/current-system/sw/bin/bash
              ${pkgs.openssh}/bin/ssh -nNT -L 2049:localhost:2049 -L 6969:localhost:6969 -L 18080:localhost:18080 -L 18081:localhost:18081 dev.loafey.se
              ''}";
          # ${pkgs.openssh}/bin/ssh -nNT -L 2049:localhost:2049 -L 18080:localhost:18080 -L 18081:localhost:18081 ${range} dev.loafey.se
          Restart = "always";
          RestartSec = "5s";
        };
      };
    };
}
