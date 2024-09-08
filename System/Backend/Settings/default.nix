{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 inherit (builtins)
  toString;

 cfgFonts   = config.style.fonts;
 cfgCursor  = config.style.colors.cursor;
 cfgAdwaita = config.style.colors.adwaita;
in {
 config = mkMerge [
   (mkIf cfgFonts.enable {
     fonts = {
       packages = [
         cfgFonts.emoji.package
         cfgFonts.serif.package
         cfgFonts.monospace.package
         cfgFonts.sansSerif.package
       ];

       fontconfig = {
         allowBitmaps  = false;
         subpixel.rgba = "rgb";
         hinting.style = "full";

         defaultFonts = {
           emoji = [
             cfgFonts.emoji.name
           ];

           serif = [
             cfgFonts.serif.name
           ];

           sansSerif = [
             cfgFonts.sansSerif.name
           ];

           monospace = [
             cfgFonts.monospace.name
           ];
         };
       };
     };
   })

   (mkIf cfgCursor.enable {
     home-manager.users."${username}" = {
       home.pointerCursor = {
         x11.enable = true;
         gtk.enable = true;
         name       = cfgCursor.settings.name;
         size       = cfgCursor.settings.size;
         package    = cfgCursor.settings.package;
       };
     };
   })

   (mkIf (cfgFonts.enable && config.firefox.enable) {
     home-manager.users."${username}".programs.firefox.profiles.default.settings = {
       "font.name.serif.x-western"      = cfgFonts.serif.name;
       "font.name.monospace.x-western"  = cfgFonts.monospace.name;
       "font.name.sans-serif.x-western" = cfgFonts.sansSerif.name;
     };
   })

   (mkIf (cfgFonts.enable && config.gnome.enable) {
     home-manager.users."${username}".dconf.settings = {
       "org/gnome/desktop/interface" = {
         font-hinting        = "full";
         font-antialiasing   = "rgba";
         monospace-font-name = "${cfgFonts.monospace.name} ${toString cfgFonts.size.terminal}";
         font-name           = "${cfgFonts.sansSerif.name} ${toString cfgFonts.size.applications}";
         document-font-name  = "${cfgFonts.serif.name}     ${toString cfgFonts.size.applications}";
       };
     };
   })

   (mkIf (cfgAdwaita.enable && config.freetube.enable) {
     home-manager.users."${username}" = {
       programs.freetube.settings = {
         mainColor = "Red";
         secColor  = "Amber";
         baseTheme = "black";
       };
     };
   })

   (mkIf (cfgAdwaita.enable && config.bat.enable) {
     home-manager.users."${username}" = {
       programs.bat.config = {
         style       = "full";
         theme       = "base16";
         color       = "always";
         decorations = "always";
         italic-text = "always";
       };
     };
   })

   (mkIf (cfgAdwaita.enable && config.helix.enable) {
     home-manager.users."${username}" = {
       programs.helix.settings = {
         editor.true-color = true;
         theme             = "adwaita-dark";
       };
     };
   })

   (mkIf cfgAdwaita.enable {
     home-manager.users."${username}" = {
       dconf.settings."org/gnome/desktop/interface" = {
         color-scheme = "prefer-dark";
         cursor-theme = cfgCursor.settings.name;
       };
     };
   })

   (mkIf (cfgAdwaita.enable && config.firefox.enable) {
     home-manager.users."${username}" = {
       programs.firefox = {
         profiles.default.settings."ui.systemUsesDarkTheme" = 1;

         policies.ExtensionSettings = {
           "{f1128560-8b23-46c1-aa6f-fb3e79f23cf3}" = {
             installation_mode = "normal_installed";
             install_url       = "https://addons.mozilla.org/firefox/downloads/latest/gnome-adwaita-gtk4-dark/latest.xpi";
           };
         };
       };
     };
   })
 ];
}
