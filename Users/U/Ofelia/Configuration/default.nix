{ ... }:

{
 gnome.enable     = true;
 printing.enable  = true;
 intel-cpu.enable = true;
 intel-gpu.enable = true;
 time.timeZone    = "Europe/Brussels";

 services = { 
   xserver.xkb.layout = "be";
   tlp.enable         = false;
 };

 home-manager.users.vonix = {
   dconf.settings = {
     "org/gnome/desktop/interface" = {
       text-scaling-factor = 1.5;
     };

     "org/gnome/settings-daemon/plugins/color" = {
       night-light-enabled = false;
     };
   };
 };
}
