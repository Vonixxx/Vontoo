{ ... }:

{
 mail_server.enable = true;

 jovian = {
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
