{
  description = "display3d";

  #version = "v4.4.142";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };

    display3d = {
      type = "git";
      url = "https://github.com/redpenguinyt/display3d";
      flake = false;
      submodules = true;
    };

  };

  outputs = { self, nixpkgs, display3d }: {
    packages.x86_64-linux.display3d =
      with import nixpkgs { system = "x86_64-linux"; };
      let pkgs = nixpkgsFor."x86_64-linux"; in
      stdenv.mkDerivation {
        makeFlags = [ "PREFIX=$(out)" ];
        name = "display3d";
        src = display3d;
        buildPhase = ''
          cargo build --release
        '';
        installPhase = ''
          ls
        '';

        buildInputs = [ ];

        nativeBuildInputs = [ rustc cargo ];
      };

    packages.x86_64-linux.default = self.packages.x86_64-linux.display3d;
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.display3d;
  };
}
