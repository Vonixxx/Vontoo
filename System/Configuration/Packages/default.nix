{ pkgs
, ...
}:

let
 inherit (pkgs)
  writeScriptBin;
in {
 hardware.opengl.extraPackages = with pkgs; [
   libvdpau-va-gl
   vaapiVdpau
 ];

 environment.systemPackages = let
  update = writeScriptBin "update" ''
     #!/bin/sh
    
     if zenity --entry \
     --title="Update System" \
     --text="Enter name: (Format: Richard Nixon ->" \
     --entry-text "N_Richard"
       then nix-shell -p nixVersions.latest --run 'sudo nixos-rebuild boot --flake github:Vonixxx/Vontoo#$?'
       else echo "Enter a valid username."
     fi
  '';
 in with pkgs; [
   libreoffice-fresh
   update
 ];

 services.udev.packages = with pkgs; [
   android-udev-rules
   game-devices-udev-rules
 ];
}
