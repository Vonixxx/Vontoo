{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf mkForce mkMerge;

 inherit (builtins)
  toString;

 cfgFonts      = config.style.fonts;
 cfgCursor     = config.style.colors.cursor;
 cfgAdwaita    = config.style.colors.adwaita;
 cfgCatppuccin = config.style.colors.catppuccin;
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
         inherit (cfgCursor.settings) name;
         inherit (cfgCursor.settings) size;
         inherit (cfgCursor.settings) package;
       };
     };
   })

   (mkIf (cfgFonts.enable && config.foot.enable) {
     home-manager.users."${username}".programs = {
       foot = {
         enable        = true;
         server.enable = true;
    
         settings = {
           csd.font  = "${cfgFonts.monospace.name}";
           main.font = "${cfgFonts.monospace.name}:size=16";
         };
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

   (mkIf (config.bat.enable) {
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

   (mkIf (cfgAdwaita.enable && config.freetube.enable) {
     home-manager.users."${username}" = {
       programs.freetube.settings = {
         mainColor = "Red";
         secColor  = "Amber";
         baseTheme = "black";
       };
     };
   })

   (mkIf (cfgCatppuccin.enable && config.freetube.enable) {
     home-manager.users."${username}" = {
       programs.freetube.settings = {
         baseTheme = mkForce "catppuccinMocha";
         mainColor = mkForce "CatppuccinMochaRed";
         secColor  = mkForce "CatppuccinMochaLavender";
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

   (mkIf (cfgCatppuccin.enable && config.helix.enable) {
     home-manager.users."${username}" = {
       programs.helix.settings = {
         editor.true-color = mkForce true;
         theme             = mkForce "catppuccin_mocha";
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

   (mkIf (cfgCatppuccin.enable && config.firefox.enable) {
     home-manager.users."${username}" = {
       programs.firefox = {
         profiles.default.settings."ui.systemUsesDarkTheme" = 1;

         policies.ExtensionSettings = {
           "{8446b178-c865-4f5c-8ccc-1d7887811ae3}" = {
             installation_mode = "normal_installed";
             install_url       = mkForce "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-mocha-lavender/latest.xpi";
           };
         };
       };
     };
   })
 ];
}
