{ ... }:

{
 gnome.enable       = true;
 printing.enable    = true;
 intel-cpu.enable   = true;
 intel-gpu.enable   = true;
 i18n.defaultLocale = "cs_CZ.UTF-8";

 services = {
   xserver.xkb.layout = "cz";
   tlp.enable         = false;
 };

 home-manager.users.vonix.programs.firefox.profiles.default.settings = {
   "browser.urlbar.suggest.history"  = false;
   "general.useragent.locale"        = "cs-CZ";
   "init.locale.requested"           = "cs,en-US";
 };

 users.users.vonix = {
   name           = "Jarka";
   hashedPassword = "$y$j9T$uvFyKPrjFI6ShTbD3RYii/$VaM6sSvsjn.QzTkY8ZnRFLQaZB9ijUorNVGwWesIbV0";
 };
}