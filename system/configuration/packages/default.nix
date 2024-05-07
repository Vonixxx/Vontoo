{ pkgs
, ...
}:

with pkgs;

{
 boot.kernelPackages = linuxPackages_latest;

 hardware.opengl.extraPackages = [
   libvdpau-va-gl
   vaapiVdpau
 ];

 environment.systemPackages = [
   libreoffice-fresh
 ];

 services.udev.packages = [
   android-udev-rules
   game-devices-udev-rules
 ];

 home-manager.users.vonix.home = {
   pointerCursor = {
     gtk.enable = true;
     x11.enable = true;
     package    = catppuccin-cursors.mochaLight;
     name       = "Catppuccin-Mocha-Light-Cursors";
   };
 };

 fonts.packages = [
   liberation_ttf
   (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
 ];
}
