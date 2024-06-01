{ ... }:

{
 gnome.enable    = true;
 freetube.enable = true;

 users.users.vonix = {
   name           = "V-SteamDeck";
   hashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";
 };

 hardware = {
   bluetooth.enable      = true;
   bluetooth.powerOnBoot = true;
 };

 jovian = {
   hardware.has.amd.gpu = true;

   steam = {
     enable         = true;
     autoStart      = true;
     user           = "Vonix";
     desktopSession = "gnome";
   };

   devices.steamdeck = {
     enable               = true;
     autoUpdate           = true;
     enableGyroDsuService = true;
   };
 };

 services = {
   tlp.enable = false;

   xserver = {
     enable                    = true;
     displayManager.gdm.enable = false;
   };
 };

 home-manager.users.vonix = {
   programs.freetube.settings = {
     hidePlaylists          = true;
     useSponsorBlock        = true;
     hidePopularVideos      = true;
     hideTrendingVideos     = true;
     displayVideoPlayButton = false;
     baseTheme              = "catppuccinMocha";
     mainColor              = "CatppuccinMochaRed";
     secColor               = "CatppuccinMochaLavender";

     sponsorBlockSelfPromo = {
       color = "Yellow";
       skip  = "autoSkip";
     };

     sponsorBlockInteraction = {
       color = "Green";
       skip  = "autoSkip";
     };
   };
 };
}
