{ ... }:

{
 gnome.enable        = true;
 freetube.enable     = true;
 services.tlp.enable = false;

 hardware = {
   bluetooth.enable      = true;
   bluetooth.powerOnBoot = true;
 };

 jovian = {
   hardware.has.amd.gpu = true;

   steam = {
     enable         = true;
     autoStart      = false;
     user           = "Vonix";
     desktopSession = "gnome";
   };

   devices.steamdeck = {
     enable               = true;
     autoUpdate           = true;
     enableGyroDsuService = true;
   };
 };
}
