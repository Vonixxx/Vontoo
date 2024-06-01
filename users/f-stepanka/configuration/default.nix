{ ... }:

{
 git.enable                  = true;
 helix.enable                = true;
 gnome.enable                = true;
 printing.enable             = true;
 intel-cpu.enable            = true;
 intel-gpu.enable            = true;
 kdenlive-obs.enable         = true;
 services.xserver.xkb.layout = "cz";
 time.timeZone               = "Europe/Prague";

 home-manager.users.vonix = {
   programs.git = {
     userName  = "Vonixxx";
     userEmail = "vonixxxwork@tuta.io";
   };
 };

 users.users.vonix = {
   name           = "Stepanka";
   hashedPassword = "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4";
 };
}
