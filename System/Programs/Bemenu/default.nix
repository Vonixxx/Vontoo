{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.bemenu.enable {
   home-manager.users."${username}".programs = {
     bemenu = {
       enable = true;
  
       settings = {
         list         = 5;
         prompt       = "";
         center       = true;
         width-factor = 0.15;
       };
     };
   };
 };
}
