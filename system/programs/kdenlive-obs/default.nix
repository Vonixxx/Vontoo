{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.kdenlive-obs.enable) {
   environment.systemPackages = [
     pkgs.libsForQt5.kdenlive
   ];

   home-manager.users.vonix.programs = {
     obs-studio = {
       enable = true;

       plugins = with pkgs.obs-studio-plugins; [
         obs-backgroundremoval
         obs-pipewire-audio-capture
       ];
     };
   };
 };
}
