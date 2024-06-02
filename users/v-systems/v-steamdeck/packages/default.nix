{ pkgs
, ...
}:

with pkgs;

{
 environment.systemPackages = [
   dolphin-emu
   pcsx2
   rpcs3
   steam-rom-manager
 ];
}
