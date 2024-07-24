{ pkgs
, ...
}:

with pkgs;

{
 environment.systemPackages = [
   gimp
   inkscape
   krita
   obs-studio
 ];
}
