{ lib
, ...
}:

let
 inherit (lib.types)
  bool;

 inherit (lib)
  mkOption;
in {
 options.style.colors = {
   enable = mkOption {
     type    = bool;
     default = true;
   };
 };
}
