{ ... }:

{
 bat.enable                   = true;
 git.enable                   = true;
 lsd.enable                   = true;
 zsh.enable                   = true;
 atuin.enable                 = true;
 helix.enable                 = true;
 services.getty.autologinUser = "Vonix";

 environment.variables = {
   NIXOS_OZONE_WL = "1";
   EDITOR         = "hx";
   VISUAL         = "hx";
   BROWSER        = "firefox";
   PF_INFO        = "ascii title uptime pkgs kernel memory os host";
 };

 home-manager.users.vonix = {
  config
 , ...
 }: {
   programs.git = {
     userName  = "Vonixxx";
     userEmail = "vonixxxwork@tuta.io";
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
