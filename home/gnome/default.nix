{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      clock-show-date = false;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;

      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-panel@jderose9.github.com"
        "gsconnect@andyholmes.github.io"
        "rounded-window-corners@yilozt"
      ];
    };
  };
}
