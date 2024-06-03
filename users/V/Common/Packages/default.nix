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
   ghc
   ######################
   # Terminal Utilities #
   ######################
   du-dust
   efibootmgr
   ffmpeg
   mediainfo
   pfetch-rs
   tldr
   wget
 ];
}
