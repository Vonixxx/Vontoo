{ ... }:

{
 gnome.enable                = true;
 printing.enable             = true;
 intel-cpu.enable            = true;
 intel-gpu.enable            = true;
 kdenlive-obs.enable         = true;
 services.xserver.xkb.layout = "cz";

 users.users.vonix = {
   name           = "Bubinka";
   hashedPassword = "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4";
 };
}
