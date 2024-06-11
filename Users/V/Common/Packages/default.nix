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
   curl
   du-dust
   efibootmgr
   ffmpeg
   mediainfo
   pfetch-rs
   tldr
   wget
 ];
}
