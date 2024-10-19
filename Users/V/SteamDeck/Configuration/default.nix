{ pkgs
, ...
}:

{
 foot.enable                    = true;
 style.colors.catppuccin.enable = true;
 gnome.enable                   = false;

 programs = {
   gamemode.enable = true;

   nix-ld = {
     enable = true;

     libraries = with pkgs; [
       libGL
       xorg.libX11
     ];
   };
 };

 jovian = {
   steam = {
     enable         = true;
     autoStart      = false;
     user           = "Vonix";
     desktopSession = "gnome";
   };

   devices.steamdeck = {
     enable               = true;
     autoUpdate           = true;
     enableGyroDsuService = true;
   };
 };

 environment = {
   localBinInPath                   = true;
   sessionVariables.LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
 };
}
