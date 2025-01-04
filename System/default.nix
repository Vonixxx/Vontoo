{ ... }:

{
 imports = [
   ./Backend/default.nix
   ./Programs/default.nix

   ./UI/Style/default.nix
   ./UI/Hyprland_Waybar/default.nix

   ./Configuration/Disk/default.nix
   ./Configuration/General/default.nix
   ./Configuration/Packages/default.nix
 ];
}
