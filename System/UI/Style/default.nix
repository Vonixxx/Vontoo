{ pkgs
, ...
}:

{
 style = {
   border_thickness = 1;
   gaps             = 5;
   rounding         = 5;
   bar_position     = "top";

   colors = {
     gtk      = "dark";
     base     = "1e1e2e";
     text     = "cdd6f4";
     mauve    = "cba6f7";
     surface0 = "313244";
     crust    = "11111b";
     red      = "f38ba8";
     green    = "a6e3a1";
     yellow   = "f9e2af";
     blue     = "89b4fa";
     pink     = "f5c2e7";
     sky      = "89dceb";
     lavender = "b4befe";
   };

   # colors = {
   #   gtk      = "light";
   #   base     = "eff1f5";
   #   text     = "4c4f69";
   #   mauve    = "8839ef";
   #   surface0 = "ccd0da";
   #   crust    = "dce0e8";
   #   red      = "d20f39";
   #   green    = "40a02b";
   #   yellow   = "df8e1d";
   #   blue     = "1e66f5";
   #   pink     = "ea76cb";
   #   sky      = "04a5e5";
   #   lavender = "7287fd";
   # };

   cursor.settings = {
     size    = 32;
     name    = "Bibata-Modern-Ice";
     package = pkgs.bibata-cursors;
   };

   fonts = {
     size = {
       bar          = 20;
       titleBar     = 14;
       terminal     = 16;
       applications = 12;
     };

     monospace = {
       package = pkgs.nerd-fonts.hack;
       name    = "Hack Nerd Font Propo";
     };

     serif = {
       name    = "FiraCode Nerd Font";
       package = pkgs.nerd-fonts.fira-code;
     };

     emoji = {
       name    = "Noto Color Emoji";
       package = pkgs.noto-fonts-color-emoji;
     };

     sansSerif = {
       name    = "BitstromWera Nerd Font";
       package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
     };
   };
 };
}
