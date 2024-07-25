{ pkgs
, userPackages
, ...
}:

let
 inherit (pkgs)
  writeScriptBin;

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
 services.udev.packages = with pkgs; [
   android-udev-rules
   game-devices-udev-rules
 ];

 environment.systemPackages = with pkgs; [
   libreoffice-fresh
   update
 ] ++ userPackages;

 hardware.graphics.extraPackages = with pkgs; [
   libvdpau-va-gl
   vaapiVdpau
 ];
}
