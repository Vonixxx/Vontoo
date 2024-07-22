{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkOption;

 inherit (lib.types)
  str bool ints listOf package submodule;

 cfg = config.style.fonts;
 hm  = config.home-manager.users.vonix;

 fontType = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };
   };
 };
in {
 config.style.fonts.packages = [
   cfg.emoji.package
   cfg.serif.package
   cfg.monospace.package
   cfg.sansSerif.package
 ];

 options.style.fonts = {
   enable = mkOption {
     type    = bool;
     default = true;
   };

   packages = mkOption {
     type = listOf package;
   };

   size = {
     popups = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     desktop = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     terminal = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     applications = mkOption {
       default = 10;
       type    = ints.unsigned;
     };
   };

   serif = mkOption {
     type = fontType;

     default = {
       name    = "DejaVu Serif";
       package = pkgs.dejavu_fonts;
     };
   };

   sansSerif = mkOption {
     type = fontType;
     default = {
       name    = "DejaVu Sans";
       package = pkgs.dejavu_fonts;
     };
   };

   monospace = mkOption {
     type = fontType;

     default = {
       name    = "DejaVu Mono";
       package = pkgs.dejavu_fonts;
     };
   };

   emoji = mkOption {
     type = fontType;

     default = {
       name    = "NotoColorEmoji";
       package = pkgs.noto-fonts-color-emoji;
     };
   };

   targets = {
     gtk.enable = mkOption {
       type    = bool;
       default = hm.gtk.enable;
     };

     helix.enable = mkOption {
       type    = bool;
       default = hm.programs.helix.enable;
     };
   };
 };
}
