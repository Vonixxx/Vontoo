{ pkgs
, ...
}:

with pkgs;

{
 environment.systemPackages = [
   pcsx2
   rpcs3
   steam-rom-manager
 ];
}
