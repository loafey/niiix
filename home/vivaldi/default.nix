{ pkgs, ... }:
let
  viv = (pkgs.vivaldi.overrideAttrs (oldAttrs: {
    buildPhase =
      builtins.replaceStrings [ "for f in libGLESv2.so libqt5_shim.so ; do" ]
      [ "for f in libGLESv2.so libqt5_shim.so libqt6_shim.so ; do" ]
      oldAttrs.buildPhase;
  })).override {
    qt5 = pkgs.qt6;
    commandLineArgs = [ "--ozone-platform=wayland" ];
    # The following two are just my preference, feel free to leave them out
    proprietaryCodecs = true;
    enableWidevine = true;
  };
in { home.packages = [ viv ]; }
