{ inputs }:
{ pkgs, ... }:
{
  home.packages =
    let
      p = with pkgs; [
        waypipe
        firefox
        fish
        nixfmt
        gparted
        picard
        fd
        ffmpeg
      ];
    in
    p ++ inputs.git-flakes.packages."${pkgs.system}";
}
