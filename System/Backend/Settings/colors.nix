{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 cfgAdwaita = config.style.cursor;
 cfgCursor  = config.style.adwaita;
in {
 config = mkMerge [
   (mkIf cfgCursor.enable {
     home-manager.users."${username}" = {
       home.pointerCursor = {
         x11.enable = true;
         gtk.enable = true;
         name       = cfgAdwaita.settings.name;
         size       = cfgAdwaita.settings.size;
         package    = cfgAdwaita.settings.package;
       };
     };
   })

   (mkIf cfgAdwaita.enable {
     home-manager.users."${username}" = {
       dconf.settings = {
         "org/gnome/desktop/interface" = {
           color-scheme = "prefer-dark";
           cursor-theme = cfgCursor.settings.name;
         };
       };

       programs = {
         freetube.settings = {
           mainColor = "Red";
           secColor  = "Amber";
           baseTheme = "black";
         };

         bat.config = {
           style       = "full";
           theme       = "base16";
           color       = "always";
           decorations = "always";
           italic-text = "always";
         };

         helix.settings = {
           editor.true-color = true;
           theme             = "adwaita-dark";
         };

         firefox = {
           profiles.default.settings."ui.systemUsesDarkTheme" = 1;

           policies.ExtensionSettings = {
             "{f1128560-8b23-46c1-aa6f-fb3e79f23cf3}" = {
               installation_mode = "normal_installed";
               install_url       = "https://addons.mozilla.org/firefox/downloads/latest/gnome-adwaita-gtk4-dark/latest.xpi";
             };
           };
         };
       };
     };
   })
 ];
}
