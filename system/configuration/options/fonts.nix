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
     package = mkOption {
       type = package;
     };

     name = mkOption {
       type = str;
     };
   };
 };
in {
 cfg.packages = [
   cfg.emoji.name
   cfg.serif.name
   cfg.monospace.name
   cfg.sansSerif.name
 ];

 options.style.fonts = {
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
     bat.enable = mkOption {
       type    = bool;
       default = hm.programs.bat.enable;
     };

     foot.enable = mkOption {
       type    = bool;
       default = hm.programs.foot.enable;
     };

     mako.enable = mkOption {
       type    = bool;
       default = hm.programs.mako.enable;
     };

     helix.enable = mkOption {
       type    = bool;
       default = hm.programs.helix.enable;
     };

     bemenu.enable = mkOption {
       type    = bool;
       default = hm.programs.bemenu.enable;
     };

     waybar.enable = mkOption {
       type    = bool;
       default = hm.programs.waybar.enable;
     };
   };
 };
}
