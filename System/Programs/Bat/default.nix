{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.bat.enable) {
   environment.shellAliases = {
     cat  = "bat";
     man  = "batman";
     grep = "batgrep";
   };

   home-manager.users."${username}".programs = {
     bat = {
       enable = true;

       extraPackages = with pkgs.bat-extras; [
         batman
         batgrep
       ];
     };
   };
 };
}
