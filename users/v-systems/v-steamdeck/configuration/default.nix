{ ... }:

{
 gnome.enable        = true;
 freetube.enable     = true;
 services.tlp.enable = false;
 time.timeZone       = "Europe/Prague";

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

 users.users = {
   root.initialHashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";

   vonix = {
     name                  = "V-SteamDeck";
     initialHashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";
   };
 };
}
