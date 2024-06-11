{ username
, ...
}:

{
 printing.enable     = true;
 intel-cpu.enable    = true;
 intel-gpu.enable    = true;
 services.tlp.enable = false;

 home-manager.users."${username}" = {
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
