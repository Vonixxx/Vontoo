{ pkgs
, ...
}:

with pkgs;
with gnome;

{
 environment.systemPackages = [
   ###############
   # Programming #
   ###############
   cabal-install
   ghc
   ######################
   # Terminal Utilities #
   ######################
   alsa-utils
   du-dust
   efibootmgr
   ffmpeg
   grimblast
   mediainfo
   pfetch-rs
   pulsemixer
   tldr
   unar
   xdg-utils
   yt-dlp
   unzip
   ################
   # Applications #
   ################
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
