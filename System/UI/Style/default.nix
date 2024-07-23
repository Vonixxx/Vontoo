{ pkgs
, ...
}:

{
 style = {
   colors.cursor = {
     settings = {
       size    = 32;
       name    = "Bibata-Modern-Ice";
       package = pkgs.bibata-cursors;
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
