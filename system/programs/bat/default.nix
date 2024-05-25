{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.bat.enable) {
   home-manager.users.vonix.programs = {
     bat = {
       enable        = true;

       extraPackages = with pkgs.bat-extras; [
         batdiff
         batman
         batgrep
       ];
     };
   };
 };
}
