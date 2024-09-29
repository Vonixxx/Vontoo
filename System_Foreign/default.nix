{ pkgs
, ...
}:

{
 targets.genericLinux.enable = true;

 imports = [
   ./Programs/Bat/default.nix
   ./Programs/Git/default.nix
   ./Programs/LSD/default.nix
   ./Programs/ZSH/default.nix
   ./Programs/Foot/default.nix
   ./Programs/Atuin/default.nix
   ./Programs/Helix/default.nix
   ./Programs/FireFox/default.nix
   ./Programs/FreeTube/default.nix
   ./Programs/StarShip/default.nix
 ];

 home = {
   stateVersion  = "24.11";
   username      = "broombear";
   homeDirectory = "/home/broombear";

   packages = with pkgs; [
     mpv
     swww
     tldr
     ffmpeg
     pfetch
     slstatus
     wlr-randr
   ];
 };
}
