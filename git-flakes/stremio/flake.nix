{
  description = "Stremio";

  #version = "v4.4.142";

  inputs = {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };

    stremio = {
      type = "git";
      url = "https://github.com/Stremio/stremio-shell/";
      flake = false;
      submodules = true;
      ref = "refs/tags/v4.4.142";
    };

  };

  outputs = { self, nixpkgs, stremio }: {
    packages.x86_64-linux.stremio-patch =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        makeFlags = [ "PREFIX=$(out)" ];
        name = "stremio";
        src = stremio;
        server = fetchurl {
          url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/v4.4.142/server.js";
          hash = "sha256-YYeD3SEbLgNQHGP5AI9WiHUU6xLkTeFAqYIuWsIsYSs=";
        };
        buildPhase = ''
          qmake -o $out/release.makefile
          cd $out
          make -f release.makefile
        '';
        installPhase = ''
          mkdir $out/bin
          mkdir $out/opt
          mkdir $out/opt/stremio
          ln -s ${nodejs}/bin/node $out/opt/stremio/node
          ln -s $server $out/opt/stremio/server.js
          cp $out/stremio $out/opt/stremio/stremio
          ln -s $out/opt/stremio/stremio $out/bin/stremio
        '';

        buildInputs = [ curl libsForQt5.qt5.qtwebengine mpv gcc ];

        nativeBuildInputs = [ libsForQt5.qt5.qtbase libsForQt5.qt5.wrapQtAppsHook ];
      };

    packages.x86_64-linux.default = self.packages.x86_64-linux.stremio-patch;

  };
}
