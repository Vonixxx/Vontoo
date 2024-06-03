{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.gnome.enable) {
   services = {
     xserver = {
       enable                      = true;
       desktopManager.gnome.enable = true;
       displayManager.gdm.enable   = true;

       excludePackages = [
         pkgs.xterm
       ];
     };
   };

   environment = with pkgs; with gnome; with gnomeExtensions; {
     systemPackages = [
       gnome-tweaks
       user-themes
       zenity
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

   home-manager.users."${username}" = { lib
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
       "org/gnome/system/location" = {
         enabled = true;
       };

       "org/gnome/mutter" = {
         edge-tiling = true;
       };

       "org/gnome/desktop/peripherals/touchpad" = {
         tap-to-click   = true;
         natural-scroll = true;
       };

       "org/gnome/desktop/session" = {
         idle-delay = mkUint32 60;
       };

       "org/gnome/desktop/datetime" = {
         automatic-timezone = true;
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

       "org/gnome/shell/extensions/user-theme" = {
         name = "Catppuccin-Mocha-Compact-Mauve-Dark";
       };

       "org/gnome/settings-daemon/plugins/color" = {
         night-light-schedule-automatic = true;
         night-light-temperature        = mkUint32 1700;
         night-light-enabled            = mkDefault true;
       };

       "org/gnome/desktop/wm/preferences" = {
         num-workspaces = 5;
         button-layout  = "appmenu:minimize,maximize,close";
       };

       "org/gnome/shell" = {
         disable-user-extensions = false;

         disabled-extensions = [
           ""
         ];

         enabled-extensions = [ 
           "user-theme@gnome-shell-extensions.gcampax.github.com"
         ];
       };

       "org/gnome/desktop/interface" = {
         enable-hot-corners = true;
         clock-show-weekday = false;
         font-antialiasing  = "rgba";
         font-hinting       = "full";
         icon-theme         = "Papirus-Dark";
         cursor-theme       = "Catppuccin-Mocha-Mauve-Cursors";
         gtk-theme          = "Catppuccin-Mocha-Compact-Mauve-Dark";
       };
     };
   };
 };
}
