{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.foot.enable) {
   home-manager.users.vonix.programs = {
     foot = {
       enable        = true;
       server.enable = true;

       settings = {
         cursor = {
           blink = true;
           style = "block";
         };

         scrollback = {
           multiplier = 3;
           lines      = 3000;
         };
       };
     };
   };
 };
}
