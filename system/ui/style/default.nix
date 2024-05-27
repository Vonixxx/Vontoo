{ pkgs
, ...
}:

{
 style = {
   colors = {
     enable = true;

     cursor = {
       size    = 32;
       enable  = true;
       name    = "Catppuccin-Mocha-Light-Cursors";
       package = pkgs.catppuccin-cursors.mochaLight;
     };
   };

   fonts = {
     size = {
       popups       = 12;
       desktop      = 12;
       terminal     = 16;
       applications = 12;
     };
  
     emoji = {
       name    = "NotoColorEmoji";
       package = pkgs.noto-fonts-color-emoji;
     };
  
     monospace = {
       name    = "HackNerdFontPropo-Regular";
       package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
     };
  
     serif = {
       name    = "FiraCodeNerdFont-Retina";
       package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
     };
  
     sansSerif = {
       name    = "FiraCodeNerdFont-Retina";
       package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
     };
   };
 };
}
