{ pkgs
, config
, username
, ...
}:

let
 home = config.users.users.${username}.home;
in {
 style = {
   gaps             = 5;
   scale            = 1;
   rounding         = 5;
   border_thickness = 1;
   bar_position     = "top";
   wallpaper        = "${home}/Pictures/Chill.mp4";

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
