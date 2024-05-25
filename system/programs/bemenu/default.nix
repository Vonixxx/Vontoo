{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.bemenu.enable) {
   home-manager.users.vonix.programs = {
     bemenu = {
       enable = true;

       settings = {
         list         = 5;
         border       = 3;
         width-factor = 0.3;
         wrap         = true;
         center       = true;
         prompt       = "Launch";
       };
     };
   };
 };
}
