{
  description = "Stremio";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };

    stremio = {
      url = "github:Stremio/stremio-shell";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, stremio }: {

    # https://github.com/Stremio/stremio-shell

    packages.x86_64-linux.stremio =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "stremio";
        src = self;
        buildPhase = "qmake " + ${qtWrapperArgs [ @ ]};
        installPhase = "echo yo";

        buildInputs = [ libsForQt5.qt5.qtwebengine mpv ];

        nativeBuildInputs = [ libsForQt5.qt5.qtbase libsForQt5.qt5.wrapQtAppsHook ];
      };

    packages.x86_64-linux.default = self.packages.x86_64-linux.stremio;

  };
}
