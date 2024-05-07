{ pkgs
, ...
}:

let
 inherit (pkgs)
  runCommandNoCC;
in {
 gnome.enable       = true;
 intel-cpu.enable   = true;
 intel-gpu.enable   = true;
 i18n.defaultLocale = "cs_CZ.UTF-8";

 services = {
   xserver.xkb.layout = "cz";
   tlp.enable         = false;
 };

 home-manager.users.vonix.programs.firefox.profiles.default.settings = {
   "general.useragent.locale" = "cs-CZ";
   "init.locale.requested"    = "cs,en-US";
 };

 hardware.firmware = [ 
   (runCommandNoCC "brcm-firmware" { } ''
      mkdir -p $out/lib/firmware/brcm
      cp ${./brcm/brcmfmac43455-sdio.txt} $out/lib/firmware/brcm
   '')
 ];

 users.users.vonix = {
   name           = "Libor";
   hashedPassword = "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4";
 };
}
