{ lib
, pkgs
, config
, argumentsCLI
, latestKernel
, userPackages
, ...
}:

let
 inherit (lib)
  mkIf
  mkMerge
  importJSON;

 inherit (pkgs)
  writeScriptBin;

 catppuccin-plymouth-mocha =
 pkgs.catppuccin-plymouth.override {
   variant = "mocha";
 };

 cfg  = config;
 args = importJSON argumentsCLI.outPath;

 vendorResetUDEV = pkgs.callPackage ../Users/Dependencies/V/WorkStation/default.nix {};

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
    alsa-utils
    brave
    chromium
    celluloid
    cosmic-edit
    cosmic-files
    eog
    evince
    grim
    gnome-calculator
    hyprsunset
    impala
    libreoffice-fresh
    slurp
    swappy
    system-config-printer
    update
    wl-clipboard
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

   (mkIf (args.gpu == "AMD") [
     amdvlk
     # rocmPackages.clr.icd
   ]) 

   (mkIf (args.gpu == "Intel") [
     intel-media-driver
     intel-vaapi-driver
   ]) 
 ];
}
