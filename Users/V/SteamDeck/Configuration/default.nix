{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkForce;

 dwl_custom = pkgs.callPackage ../../../../System/Programs_Custom/DWL/default.nix { };
in {
 foot.enable                    = true;
 style.colors.catppuccin.enable = true;
 gnome.enable                   = false;

 home-manager.users."${username}".programs = {
   chromium.enable = true;
 };

 programs = {
   gamemode.enable = true;

   nix-ld = {
     enable = true;

     libraries = with pkgs; [
       libGL         # Needed for RayLib's video functionality
       libpulseaudio # Needed for RayLib's audio functionality
       xorg.libX11   # Needed for RayLib's video functionality
     ];
   };
 };

 services.displayManager = {
   enable         = true;
   defaultSession = "dwl";

   sddm = {
     enable         = true;
     wayland.enable = true;
     theme          = "catppuccin-mocha";
   };

   sessionPackages = with pkgs; [
     dwl_custom
   ];
 };

 jovian = {
   steam = {
     enable         = true;
     autoStart      = false;
     desktopSession = "dwl";
     user           = "${username}";
   };

   devices.steamdeck = {
     enable               = true;
     autoUpdate           = true;
     enableGyroDsuService = true;
   };
 };

 environment = {
   localBinInPath                   = true;
   sessionVariables.LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
 };
}
