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
          Description = ''SSH Tunnel 10666-10676'';
        };

        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          ExecStart = "${pkgs.writeShellScript "ssh-tunnels" ''
        #!/run/current-system/sw/bin/bash
        ssh -nNT ${range} dev.loafey.se
      ''}";
        };
      };
    };
}
