{ pkgs
, ...
}:

with pkgs;
with gnome;

{
 environment.systemPackages = [
   ######################
   # Terminal Utilities #
   ######################
   alsa-utils
   grimblast
   pulsemixer
   xdg-utils
   ################
   # Applications #
   ################
   apostrophe
   celluloid
   eog
   evince
   fragments
   gnome-calendar
   gnome-calculator
   gnome-disk-utility
   mpvpaper
   nautilus
   wike
 ];
}
