{ lib
, pkgs
, config
, argumentsCLI
, latestKernel
, userPackages
, ...
}:

let
 inherit (pkgs)
  writeScriptBin;

 inherit (lib)
  mkIf mkMerge importJSON;

 catppuccin-plymouth-mocha =
 pkgs.catppuccin-plymouth.override {
   variant = "mocha";
 };

 cfg  = config;
 args = importJSON argumentsCLI.outPath;

 vendorResetUDEV = pkgs.callPackage ../../../Users/Dependencies/V/WorkStation/default.nix {};

 update = writeScriptBin "update" ''
    profile=$(zenity --entry \
     --title="System Update" \
     --text="Last name's initial followed by your first name, as such:" \
     --entry-text "Richard Nixon -> N_Richard")

    if [ -n "$profile" ]; then
     sudo nix-shell -p nixVersions.latest --run 'nixos-rebuild switch --flake github:Vonixxx/Vontoo#'"$profile"
    else
     echo "No profile selected"
    fi
 '';
in {
 services.udev.packages =
 with pkgs; [
   android-udev-rules
   game-devices-udev-rules
   vendorResetUDEV
 ];

 environment.systemPackages = 
 with pkgs; mkMerge [
   userPackages

   [
    brave
    celluloid
    eog
    gnome-calculator
    gnome-text-editor
    impala
    libreoffice-fresh
    nautilus
    system-config-printer
    update
   ]
 ];

 boot = {
   plymouth.themePackages = [
     catppuccin-plymouth-mocha
   ];

   kernelPackages =
   if !latestKernel
     then pkgs.linuxPackages
     else pkgs.linuxPackages_latest;
 };

 hardware.graphics.extraPackages =
 with pkgs; mkMerge [
   [
    libvdpau-va-gl
    vaapiVdpau
   ]

   (mkIf (args.gpuAMD == "true") [
     amdvlk
     # rocmPackages.clr.icd
   ]) 

   (mkIf (args.gpuIntel == "true") [
     intel-media-driver
     intel-vaapi-driver
   ]) 
 ];
}
