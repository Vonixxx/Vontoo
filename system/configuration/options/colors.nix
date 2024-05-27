{ lib
, pkgs
, ...
}:

let
 inherit (lib.types)
  int str bool package;

 inherit (lib)
  mkOption;
in {
 options.style.colors = {
   enable = mkOption {
     type    = bool;
     default = false;
   };

   cursor = {
     enable = mkOption {
       type    = bool;
       default = false;
     };

     size = mkOption {
       default = 32;
       type    = int;
     };

     name = mkOption {
       type    = str;
       default = "Vanilla-DMZ";
     };

     package = mkOption {
       default = package;
       type    = pkgs.vanilla-dmz;
     };
   };
 };
}
