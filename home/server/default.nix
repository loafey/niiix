{inputs}: { pkgs, ... }: { 
    home.packages = let p = with pkgs; [ ]; in
        p ++ inputs.git-flakes.packages."${pkgs.system}";
}
