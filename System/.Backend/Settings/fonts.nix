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

 cfg = config.style.fonts;
in {
 config = mkMerge [
   (mkIf cfg.enable {
     fonts = {
       packages = cfg.packages;

       fontconfig = {
         allowBitmaps  = false;
         subpixel.rgba = "rgb";
         hinting.style = "full";

         defaultFonts = {
           emoji     = [ cfg.emoji.name     ];
           serif     = [ cfg.serif.name     ];
           sansSerif = [ cfg.sansSerif.name ];
           monospace = [ cfg.monospace.name ];
         };
       };
     };
   })

   (mkIf config.firefox.enable {
     home-manager.users."${username}".programs.firefox.profiles.default.settings = {
       "font.name.serif.x-western"      = cfg.serif.name;
       "font.name.monospace.x-western"  = cfg.monospace.name;
       "font.name.sans-serif.x-western" = cfg.sansSerif.name;
     };
   })

   (mkIf config.gnome.enable {
     home-manager.users."${username}".dconf.settings = {
       "org/gnome/desktop/interface" = {
         font-hinting        = "full";
         font-antialiasing   = "rgba";
         monospace-font-name = "${cfg.monospace.name} ${toString cfg.size.terminal}";
         font-name           = "${cfg.sansSerif.name} ${toString cfg.size.applications}";
         document-font-name  = "${cfg.serif.name}     ${toString cfg.size.applications}";
       };
     };
   })
 ];
}
