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
  callPackage
  writeScriptBin;

 catppuccin-plymouth-mocha =
 pkgs.catppuccin-plymouth.override {
   variant = "mocha";
 };

 cfg             = config;
 cfgEnable       = cfg.enable;
 args            = importJSON argumentsCLI.outPath;
 vendorResetUDEV = callPackage ../Users/Dependencies/V/WorkStation/default.nix {};

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
 with pkgs; mkMerge [
   [
    android-udev-rules
    game-devices-udev-rules
   ]

   (mkIf cfgEnable.virtualisation [
     vendorResetUDEV
   ])
 ];

 environment.systemPackages = 
 with pkgs;
 with kdePackages;
 mkMerge [
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
    pfetch-rs
    plasma-workspace-wallpapers
    slurp
    swappy
    system-config-printer
    update
    wl-clipboard
   ]
 ];

 boot = mkMerge [
   {
    plymouth.themePackages = [
      catppuccin-plymouth-mocha
    ];

    kernelPackages =
    if !latestKernel
      then pkgs.linuxPackages
      else pkgs.linuxPackages_latest;
   }

   (mkIf cfgEnable.virtualisation {
     extraModulePackages = [
       pkgs.linuxKernel.packages.linux_6_13.vendor-reset
     ];
   })
 ];

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
