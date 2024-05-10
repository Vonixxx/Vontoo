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

 fonts.packages = [
   liberation_ttf
   (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
 ];

 home-manager.users.vonix.home = {
   pointerCursor = {
     gtk.enable = true;
     package    = catppuccin-cursors.mochaLight;
     name       = "Catppuccin-Mocha-Light-Cursors";

     x11 = {
       enable        = true;
       defaultCursor = "Catppuccin-Mocha-Light-Cursors";
     };
   };
 };
}
