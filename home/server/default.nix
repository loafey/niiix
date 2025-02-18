{ inputs }:
{ pkgs, ... }: {
  home.packages = let p = with pkgs; [ waypipe ];
  in p ++ inputs.git-flakes.packages."${pkgs.system}";
}
