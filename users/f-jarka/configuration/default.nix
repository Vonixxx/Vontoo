{ ... }:

{
 gnome.enable       = true;
 printing.enable    = true;
 intel-cpu.enable   = true;
 intel-gpu.enable   = true;
 i18n.defaultLocale = "cs_CZ.UTF-8";
 time.timeZone      = "Europe/Prague";

 services = {
   xserver.xkb.layout = "cz";
   tlp.enable         = false;
 };

 home-manager.users.vonix.programs.firefox.profiles.default.settings = {
   "browser.urlbar.suggest.history"  = false;
   "general.useragent.locale"        = "cs-CZ";
   "init.locale.requested"           = "cs,en-US";
 };

 users.users = {
   root.initialHashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";

   vonix = {
     name                  = "Jarka";
     initialHashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";
   };
 };
}
