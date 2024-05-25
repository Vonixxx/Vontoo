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
   home-manager.users.vonix.stylix = {
     targets.waybar.enable = false;
   };

   stylix = {
     autoEnable          = true;
     opacity.terminal    = 0.90;
     targets.grub.enable = false;
     image               = ./Space.jpg;
     base16Scheme        = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

     override = {
       base0A = "cba6f7";
       base0E = "f9e2af";
     };

     fonts = {
       sizes = {
         popups       = 12;
         desktop      = 12;
         terminal     = 16;
         applications = 12;
       };

       emoji = {
         package = pkgs.noto-fonts-color-emoji;
         name    = "NotoColorEmoji";
       };

       serif = {
         package = pkgs.nerdfonts.override { fonts = ["FiraCode"]; };
         name    = "FiraCodeNerdFont-Retina";
       };

       sansSerif = {
         package = pkgs.nerdfonts.override { fonts = ["FiraCode"]; };
         name    = "FiraCodeNerdFont-Retina";
       };

       monospace = {
         package = pkgs.nerdfonts.override { fonts = ["Hack"]; };
         name    = "HackNerdFontPropo-Regular";
       };
     };

     cursor = {
       name    = "Catppuccin-Mocha-Light-Cursors";
       package = pkgs.catppuccin-cursors.mochaLight;
     };
   };
 };
}
