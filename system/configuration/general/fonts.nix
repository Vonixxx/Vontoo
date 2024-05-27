{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 inherit (builtins)
  toString;

 cfg   = config.style.fonts;
 cfgHM = config.style.fonts.targets;
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

   (mkIf cfgHM.gtk.enable {
     config.gtk.font = {
       package = "${cfg.sansSerif.name}";
       name    = "${cfg.sansSerif.package}";
       size    = "${cfg.size.applications}";
     };
   })

   (mkIf cfgHM.firefox.enable {
     config.programs.foot.profiles.default.settings = {
       "font.name.serif.x-western"      = cfg.serif.name;
       "font.name.monospace.x-western"  = cfg.monospace.name;
       "font.name.sans-serif.x-western" = cfg.sansSerif.name;
     };
   })

   (mkIf cfgHM.bemenu.enable {
     config.programs.bemenu.settings = {
       fn = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
     };
   })

   (mkIf cfgHM.mako.enable {
     config.services.mako.font = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
   })

   (mkIf cfgHM.foot.enable {
     config.programs.foot.settings.main.font = "${cfg.monospace.name}:size=${toString cfg.size.terminal}";
   })
 ];
}
