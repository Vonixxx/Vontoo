{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib.types)
  str bool ints package submodule;

 inherit (lib)
  mkOption;

 cursorType = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     size = mkOption {
       type = ints.unsigned;
     };

     package = mkOption {
       type = package;
     };
   };
 };
in {
 options.style = {
   adwaita.enable = mkOption {
     type    = bool;
     default = config.gnome.enable;
   };

   cursor = mkOption {
     type = cursorType;

     default = {
       size    = 16;
       package = pkgs.bibata-cursors;
       name    = "Bibata Modern Classic";
     };
   };
 };
}
