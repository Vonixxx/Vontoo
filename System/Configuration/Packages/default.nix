{ pkgs
, userPackages
, extraOverlays
, latest_kernel
, ...
}:

let
 inherit (pkgs)
  writeScriptBin;

 catppuccin-plymouth-mocha = pkgs.catppuccin-plymouth.override { variant = "mocha"; };
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
 boot = {
   kernelPackages =
   if !latest_kernel
     then pkgs.linuxPackages
     else pkgs.linuxPackages_latest;

   plymouth.themePackages = [
     catppuccin-plymouth-mocha
   ];
 };

 services.udev.packages =
 with pkgs; [
   android-udev-rules
   game-devices-udev-rules
 ];

 environment.systemPackages = 
 with pkgs; [
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
 ] ++ userPackages;

 hardware.graphics.extraPackages =
 with pkgs; [
   libvdpau-va-gl
   vaapiVdpau
 ];
}
