{ pkgs
, ...
}:

with pkgs;

{
 environment.systemPackages = [
   dolphin-emu
   pcsx2
   protontricks
   rpcs3
 ];
}
