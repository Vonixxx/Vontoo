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
}
