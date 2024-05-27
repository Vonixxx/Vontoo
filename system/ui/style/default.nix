{ pkgs
, ...
}:

{
 style.fonts = {
   size = {
     popups      = 12;
     desktop     = 12;
     terminal    = 15;
     application = 12;
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
}
