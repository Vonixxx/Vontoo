{ pkgs
, config
, printing
, username
, ...
}:

let
 cfg  = config;
 home = cfg.users.users.${username}.home;
in {
 enable = {
   git                  = true;
   zsh                  = true;
   foot                 = true;
   fonts                = true;
   bemenu               = true;
   colors               = true;
   cursor               = true;
   waybar               = true;
   freetube             = true;
   hyprland             = true;
   generalConfiguration = true;
   bat                  = false;
   lsd                  = false;
   atuin                = false;
   helix                = false;
   virtualisation       = false;
   printing             = printing;
 };

 style = {
   colors = {
     gtk      = "dark";
     red      = "f38ba8";
     sky      = "89dceb";
     base     = "1e1e2e";
     blue     = "89b4fa";
     pink     = "f5c2e7";
     mauve    = "cba6f7";
     text     = "cdd6f4";
     crust    = "11111b";
     green    = "a6e3a1";
     peach    = "fab387";
     yellow   = "f9e2af";
     flamingo = "f2cdcd";
     lavender = "b4befe";
     surface0 = "313244";
   };

   cursor = {
     size    = 32;
     name    = "Bibata-Modern-Ice";
     package = pkgs.bibata-cursors;
   };

   general = {
     gaps             = 5;
     scale            = 1;
     rounding         = 5;
     borderThickness  = 1;
     barPosition      = "top";
     wallpaper        = "${home}/Pictures/Chill.mp4";
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
