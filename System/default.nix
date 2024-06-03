{ ... }:

{
 imports = [
   ./UI/Gnome/default.nix
   ./UI/Style/default.nix

   ./.Backend/Options/fonts.nix
   ./.Backend/Options/colors.nix
   ./.Backend/Settings/fonts.nix
   ./.Backend/Settings/colors.nix
   ./.Backend/Options/applications.nix

   ./Programs/Bat/default.nix
   ./Programs/Git/default.nix
   ./Programs/LSD/default.nix
   ./Programs/ZSH/default.nix
   ./Programs/Atuin/default.nix
   ./Programs/Helix/default.nix
   ./Programs/FireFox/default.nix
   ./Programs/FreeTube/default.nix
   ./Programs/Printing/default.nix

   ./Configuration/Disk/default.nix
   ./Configuration/Model/default.nix
   ./Configuration/General/default.nix
   ./Configuration/Packages/default.nix
   ./Configuration/Impermanence/default.nix
 ];
}
