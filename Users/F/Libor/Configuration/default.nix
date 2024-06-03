{ pkgs
, ...
}:

let
 inherit (pkgs)
  runCommandNoCC;
in {
 gnome.enable        = true;
 intel-cpu.enable    = true;
 intel-gpu.enable    = true;
 services.tlp.enable = false;

 hardware.firmware = [ 
   (runCommandNoCC "brcm-firmware" { } ''
      mkdir -p $out/lib/firmware/brcm
      cp ${./BRCM/brcmfmac43455-sdio.txt} $out/lib/firmware/brcm
   '')
 ];
}
