{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf mkDefault;
in {
 config = mkIf (config.gnome.enable) {
   services = {
     xserver = {
       enable                      = true;
       desktopManager.gnome.enable = true;
       displayManager.gdm.enable   = mkDefault true;

       excludePackages = [
         pkgs.xterm
       ];
     };
   };

   environment = with pkgs; with gnome; with gnomeExtensions; {
     systemPackages = [
       gnome-tweaks
       user-themes
     ];

     gnome.excludePackages = [
       atomix
       epiphany
       geary
       gnome-tour
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
       yelp
     ];
   };

   home-manager.users.vonix = { lib, ... }:

   let
    inherit (lib)
     mkDefault;

    inherit (lib.hm.gvariant)
     mkUint32;
   in {
     gtk.enable = true;

     dconf.settings = {
       "org/gnome/system/location" = {
         enabled = true;
       };

       "org/gnome/mutter" = {
         edge-tiling = true;
       };

       "org/gnome/desktop/peripherals/touchpad" = {
         tap-to-click   = true;
         natural-scroll = false;
       };

       "org/gnome/desktop/session" = {
         idle-delay = mkUint32 0;
       };

       "org/gnome/desktop/datetime" = {
         automatic-timezone = true;
       };

       "org/gnome/desktop/interface" = {
         clock-show-weekday = true;
         enable-hot-corners = false;
         font-antialiasing  = "rgba";
         font-hinting       = "full";
       };

       "org/gnome/desktop/privacy" = {
         recent-files-max-age   = 30;
         remove-old-trash-files = true;
         remove-old-temp-files  = true;
       };

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
         num-workspaces = 3;
         button-layout  = "appmenu:minimize,maximize,close";
       };

       "org/gnome/shell" = {
         disable-user-extensions = false;

         disabled-extensions = [ 
           ""
         ];

         favorite-apps = [
           "org.gnome.Nautilus.desktop"
           "firefox.desktop"
           "freetube.desktop"
         ];

         enabled-extensions = [ 
           "user-theme@gnome-shell-extensions.gcampax.github.com"
         ];
       };
     };
   };
 };
}
