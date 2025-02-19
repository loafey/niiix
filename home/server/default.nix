{ inputs }:
{ pkgs, ... }: {
  home.packages = let
    p = with pkgs; [ waypipe firefox fish nixfmt-classic kdePackages.dolphin ];
  in p ++ inputs.git-flakes.packages."${pkgs.system}";
}
