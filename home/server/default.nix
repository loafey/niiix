{ inputs }:
{ pkgs, ... }: {
  home.packages = let
    p = with pkgs; [
      waypipe
      firefox
      fish
      nixfmt-classic
      xfce.thunar
      xfce.ristretto
    ];
  in p ++ inputs.git-flakes.packages."${pkgs.system}";
}
