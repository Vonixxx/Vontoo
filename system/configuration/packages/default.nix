{ lib
,  pkgs
, ...
}:

with pkgs;

let
 inherit (lib)
  mkDefault;
in {
# boot.kernelPackages = mkDefault linuxPackages_latest;

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
