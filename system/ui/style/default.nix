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
     opacity.terminal    = 0.9;
     autoEnable          = true;
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
         terminal     = 15;
         applications = 12;
       };

       emoji = {
         package = pkgs.fira-code-nerdfont;
         name    = "FiraCodeNerdFont-Bold";
       };

       serif = {
         package = pkgs.fira-code-nerdfont;
         name    = "FiraCodeNerdFont-Retina";
       };

       sansSerif = {
         package = pkgs.fira-code-nerdfont;
         name    = "FiraCodeNerdFont-Retina";
       };

       monospace = {
         package = pkgs.fira-code-nerdfont;
         name    = "FiraCodeNerdFontMono-Retina";
       };
     };

     cursor = {
       name    = "Catppuccin-Mocha-Light-Cursors";
       package = pkgs.catppuccin-cursors.mochaLight;
     };
   };
 };
}
