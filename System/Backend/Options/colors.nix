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

 cursorSettings = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };

     size = mkOption {
       type = ints.unsigned;
     };
   };
 };
in {
 options.style = {
   adwaita.enable = mkOption {
     type    = bool;
     default = config.gnome.enable;
   };

   cursor = {
     enable = mkOption {
       type    = bool;
       default = true;
     };

     settings = mkOption {
       type = cursorSettings;

       default = {
         size    = 16;
         package = pkgs.bibata-cursors;
         name    = "Bibata Modern Classic";
       };
     };
   };
 };
}
