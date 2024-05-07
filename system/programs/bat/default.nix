{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;

 inherit (pkgs)
  fetchFromGitHub;
in {
 config = mkIf (config.bat.enable) {
   home-manager.users.vonix.programs = {
     bat = {
       enable       = true;
       config.theme = "Catppuccin-Mocha";

       themes.Catppuccin-Mocha = {
         file = "Catppuccin-mocha.tmTheme";

         src = fetchFromGitHub {
           repo  = "bat";
           rev   = "main";
           owner = "catppuccin";
           hash  = "sha256-Q5B4NDrfCIK3UAMs94vdXnR42k4AXCqZz6sRn8bzmf4=";
         };
       };
     };
   };
 };
}
