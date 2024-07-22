{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 cfg = config.style.adwaita;
in {
 config = mkMerge [
   (mkIf cfg.enable {
     home-manager.users."${username}" = {
       dconf.settings = {
         "org/gnome/desktop/interface".color-scheme = "prefer-dark";
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

         firefox.profiles.default.settings."ui.systemUsesDarkTheme" = 1;
       };
     };
   })
 ];
}
