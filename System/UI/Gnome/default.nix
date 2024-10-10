{ lib
, pkgs
, config
, keymap
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.gnome.enable {
   programs.dconf.enable      = true;
   hardware.pulseaudio.enable = false;

   services = {
     power-profiles-daemon.enable = false;

     xserver = {
       enable                      = true;
       desktopManager.gnome.enable = true;
       displayManager.gdm.enable   = true;

       excludePackages = [
         pkgs.xterm
       ];
     };
   };

   environment = with pkgs;
                 with gnomeExtensions; {
     systemPackages = [
       amberol
       celluloid
       fragments
       impression
       gnome-tweaks
       user-themes
       zenity
     ];

     gnome.excludePackages = [
       atomix
       epiphany
       gnome-tour
       gnome-maps
       gnome-music
       gnome-contacts
       gnome-characters
       gnome-connections
       gnome-font-viewer
       gnome-shell-extensions
       hitori
       iagno
       seahorse
       tali
       totem
       yelp
     ];
   };

   home-manager.users."${username}" =
   { lib
   , ...
   }:

   let
    inherit (lib)
     mkDefault;

    inherit (lib.hm.gvariant)
     mkUint32;
   in {
     gtk.enable = true;

     dconf.settings = {
       "org/gnome/mutter".edge-tiling                               = true;
       "org/gnome/system/location".enabled                          = true;
       "org/gnome/desktop/datetime".automatic-timezone              = true;
       "org/gnome/desktop/a11y".always-show-universal-access-status = true;
       "org/gnome/Console".audible-bell                             = false;
       "org/gnome/desktop/session".idle-delay                       = mkUint32 0;

       "org/gnome/desktop/privacy" = {
         recent-files-max-age   = 30;
         remove-old-trash-files = true;
         remove-old-temp-files  = true;
       };

       "org/gnome/desktop/interface" = {
         enable-hot-corners = true;
         clock-show-weekday = false;
       };

       "org/gnome/desktop/peripherals/touchpad" = {
         tap-to-click   = true;
         natural-scroll = true;
       };

       "org/gnome/desktop/input-sources".sources = [
         "('xkb', '${keymap}')"
       ];

       "org/gnome/settings-daemon/plugins/power" = {
         sleep-inactive-battery-type = "nothing";
         sleep-inactive-ac-type      = "nothing";
         power-button-action         = "interactive";
       };

       "org/gnome/settings-daemon/plugins/color" = {
         night-light-schedule-automatic = true;
         night-light-temperature        = mkUint32 1700;
         night-light-enabled            = mkDefault true;
       };

       "org/gnome/desktop/wm/preferences" = {
         num-workspaces = 4;
         button-layout  = "appmenu:minimize,maximize,close";
       };

       "org/gnome/shell" = {
         disable-user-extensions = false;

         disabled-extensions = [
           ""
         ];

         favorite-apps = [
           "firefox.desktop"
           "startcenter.desktop"
           "org.gnome.Nautilus.desktop"
         ];

         enabled-extensions = [
           "user-theme@gnome-shell-extensions.gcampax.github.com"
         ];
       };
     };
   };
 };
}
