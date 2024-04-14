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
      ref = "refs/tags/v4.4.168";
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
          sed -i -E "s/(minimumWidth: )([0-9]+)/\1650/" main.qml
          cp smartcode-stremio.desktop $out/smartcode-stremio.desktop
          cp images/stremio.png $out/stremio_window.png
          cp images/stremio.svg $out/stremio.svg
          cd $out
          make -f release.makefile
        '';
        installPhase = ''
          mkdir $out/bin
          mkdir $out/opt
          mkdir $out/opt/stremio
          mkdir $out/share
          mkdir $out/share/applications
          mkdir $out/share/icons
          mkdir $out/share/pixmaps
          ln -s ${nodejs}/bin/node $out/opt/stremio/node
          ln -s $server $out/opt/stremio/server.js
          cp $out/stremio $out/opt/stremio/stremio
          ln -s $out/opt/stremio/stremio $out/bin/stremio
          mv $out/smartcode-stremio.desktop $out/share/applications/smartcode-stremio.desktop
          install -Dm 644 $out/stremio_window.png $out/share/pixmaps/smartcode-stremio.png
          install -Dm 644 $out/stremio.svg $out/share/icons/smartcode-stremio.svg
          find $out -maxdepth 1 -type f -delete
        '';

        buildInputs = [ curl libsForQt5.qt5.qtwebengine mpv gcc ];

        nativeBuildInputs = [ libsForQt5.qt5.qtbase libsForQt5.qt5.wrapQtAppsHook ];
      };

    packages.x86_64-linux.default = self.packages.x86_64-linux.stremio-patch;
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.stremio-patch;

  };
}
