{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.style.enable) {
   stylix = {
     opacity.terminal = 0.8;
     autoEnable       = true;
     image            = ./Space.jpg;
     base16Scheme     = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

     targets.waybar.enable = false;

     cursor = {
       name    = "Catppuccin-Mocha-Light-Cursors";
       package = pkgs.catppuccin-cursors.mochaLight;
     };

     fonts = {
       emoji     = config.stylix.fonts.monospace;
       serif     = config.stylix.fonts.monospace;
       sansSerif = config.stylix.fonts.monospace;

       monospace = {
         name    = "CascadiaCode";
         package = (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; });
       };
     };
   };
 };
}
