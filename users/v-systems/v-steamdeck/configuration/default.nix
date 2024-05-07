{ pkgs
, jovian
, ...
}:

{
 imports = [ jovian.nixosModules.jovian ];

 freetube.enable = true;

 passthru.providedSessions = [
   "hyprland"
 ];

 jovian = {
   hardware.has.amd.gpu = true;

   devices.steamdeck = {
     enable               = true;
     autoUpdate           = true;
     enableGyroDsuService = true;
   };

   steam = {
     enable         = true;
     autoStart      = true;
     user           = "Vonix";
     desktopSession = "hyprland";
   };
 };

 services = {
   tlp.enable                     = false;
   displayManager.sessionPackages = [ pkgs.hyprland ];
 };
}
