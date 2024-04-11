{ pkgs, home, config, ... }:
let
  discord-wayland = pkgs.runCommand "discord"
    { buildInputs = [ pkgs.makeWrapper pkgs.tree pkgs.gnused ]; } ''
    makeWrapper ${pkgs.discord}/bin/discord $out/bin/discord --set NIXOS_OZONE_WL 1
    tree ${pkgs.discord}
    mkdir $out/share
    mkdir $out/share/applications
    mkdir $out/share/icons
    cp ${pkgs.discord}/opt/Discord/discord.desktop $out/share/applications/discord.desktop
    sed -i '/\/usr\/share\/discord\/Discord/c\Exec=discord' $out/share/applications/discord.desktop
    sed -i '/Icon=discord/c\Icon=$out/share/icons/discord.png' $out/share/applications/discord.desktop
    cp ${pkgs.discord}/opt/Discord/discord.png $out/share/icons/discord.png
  '';
in
{
  home.packages = [ discord-wayland ];
}
