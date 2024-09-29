{ ... }:

{
 imports = [
   ./theme.nix
   ./arkenfox.nix
 ];

 programs.firefox = {
   enable = true;

   profiles.default = {
     search = {
       force   = true;
       default = "DuckDuckGo";
     };

     settings = {
       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
       "browser.urlbar.suggest.history"                      = false;
       "browser.newtabpage.activity-stream.feeds.topsites"   = false;
     };
   };

   policies = {
     DisableProfileImport     = true;
     DisablePocket            = true;
     OfferToSaveLoginsDefault = false;
     DisplayBookmarksToolbar  = "always";

     ExtensionSettings = {
       "addon@darkreader.org" = {
         installation_mode = "normal_installed";
         install_url       = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
       };

       "uBlock0@raymondhill.net" = {
         installation_mode = "force_installed";
         install_url       = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
       };

       "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
         installation_mode = "normal_installed";
         install_url       = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
       };
     };
   };
 };
}
