{ pkgs
, ...
}:

{
 style = {
   colors = {
     enable = true;

     cursor = {
       size    = 32;
       enable  = false;
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
       name    = "Noto Color Emoji";
       package = pkgs.noto-fonts-color-emoji;
     };
  
     monospace = {
       name    = "Hack Nerd Font Propo";
       package = pkgs.nerdfonts.override { fonts = [ "Hack" ]; };
     };
  
     serif = {
       name    = "FiraCode Nerd Font";
       package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
     };
  
     sansSerif = {
       name    = "FiraCode Nerd Font";
       package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
     };
   };
 };
}
