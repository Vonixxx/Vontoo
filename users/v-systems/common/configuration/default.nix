{ pkgs
, ...
}:

{
 bat.enable      = true;
 git.enable      = true;
 lsd.enable      = true;
 zsh.enable      = true;
 foot.enable     = true;
 mako.enable     = true;
 atuin.enable    = true;
 helix.enable    = true;
 bemenu.enable   = true;
 waybar.enable   = true;
 hyprland.enable = true;

 services = {
   gvfs.enable         = true;
   getty.autologinUser = "Vonix";
 };

 xdg.portal = {
   enable                = true;
   config.common.default = [ "gtk" ];

   extraPortals = with pkgs; [
     xdg-desktop-portal-gtk
     xdg-desktop-portal-hyprland
   ];
 };

 environment.variables = {
   NIXOS_OZONE_WL = "1";
   EDITOR         = "hx";
   VISUAL         = "hx";
   BROWSER        = "firefox";
   PF_INFO        = "ascii title uptime pkgs kernel memory os host";
 };

 users.users.vonix = {
   name           = "Vonix";
   hashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";
 };

 home-manager.users.vonix = {
  config
 , ...
 }: {
   programs.git = {
     userName  = "Vonixxx";
     userEmail = "vonixxxwork@tuta.io";
   };

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

   gtk = {
     enable = true;

     iconTheme = {
       name    = "Adwaita";
       package = pkgs.gnome.adwaita-icon-theme;
     };
   };

   programs.firefox = {
     profiles.default.settings = {
       "browser.urlbar.suggest.bookmark" = true;
       "browser.urlbar.suggest.history"  = false;
       "browser.urlbar.suggest.openpage" = false;
       "browser.urlbar.suggest.topsites" = false;
     };

     policies = {
       DisplayBookmarksToolbar = "never";

       ExtensionSettings = {
         "webextension@metamask.io" = {
           installation_mode = "force_installed";
           install_url       = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
         };
       };
     };
   };
 };
}
