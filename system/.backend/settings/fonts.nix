{ lib
, config
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

   (mkIf config.gtk.enable {
     home-manager.users.vonix.gtk.font = {
       size    = cfg.size.applications;
       name    = "${cfg.sansSerif.name}";
       package = "${cfg.sansSerif.package}";
     };
   })

   (mkIf config.firefox.enable {
     home-manager.users.vonix.programs.firefox.profiles.default.settings = {
       "font.name.serif.x-western"      = cfg.serif.name;
       "font.name.monospace.x-western"  = cfg.monospace.name;
       "font.name.sans-serif.x-western" = cfg.sansSerif.name;
     };
   })

   (mkIf config.bemenu.enable {
     home-manager.users.vonix.programs.bemenu.settings = {
       fn = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
     };
   })

   (mkIf config.gnome.enable {
     home-manager.users.vonix.dconf.settings = {
       "org/gnome/desktop/interface" = {
         document-font-name  = "${cfg.serif.name}";
         font-name           = "${cfg.sansSerif.name}";
         monospace-font-name = "${cfg.monospace.name}";
       };
     };
   })

   (mkIf config.mako.enable {
     home-manager.users.vonix.services.mako.font = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
   })

   (mkIf config.foot.enable {
     home-manager.users.vonix.programs.foot.settings.main.font = "${cfg.monospace.name}:size=${toString cfg.size.terminal}";
   })
 ];
}
