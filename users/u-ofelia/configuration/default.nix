{ ... }:

{
 gnome.enable     = true;
 printing.enable  = true;
 intel-cpu.enable = true;
 intel-gpu.enable = true;

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

 users.users.vonix = {
   name           = "Ofelia";
   hashedPassword = "$y$j9T$Bt3YhGYQoALhjeZY7MauX/$jlIcH1JuGjKz2UqTj7CEtwIbNNr8hRpqgRU7CEi0CBA";
 };
}
