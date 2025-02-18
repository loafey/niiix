{ inputs }:
{ pkgs, ... }: {
  home.packages = let p = with pkgs; [ waypipe firefox fish ];
  in p ++ inputs.git-flakes.packages."${pkgs.system}";
}
