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

   (mkIf config.bemenu.enable {
     home-manager.users."${username}".programs.bemenu.settings = {
       fn = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
     };
   })

   (mkIf config.gnome.enable {
     home-manager.users."${username}".dconf.settings = {
       "org/gnome/desktop/interface" = {
         monospace-font-name = "${cfg.monospace.name} ${toString cfg.size.terminal}";
         document-font-name  = "${cfg.serif.name}     ${toString cfg.size.applications}";
         font-name           = "${cfg.sansSerif.name} ${toString cfg.size.applications}";
       };
     };
   })

   (mkIf config.mako.enable {
     home-manager.users."${username}".services.mako.font = "${cfg.sansSerif.name} ${toString cfg.size.popups}";
   })

   (mkIf config.foot.enable {
     home-manager.users."${username}".programs.foot.settings.main.font = "${cfg.monospace.name}:size=${toString cfg.size.terminal}";
   })
 ];
}
