{ pkgs
, ...
}:

with pkgs;

{
 environment.systemPackages = [
   steam-rom-manager
 ];
}
