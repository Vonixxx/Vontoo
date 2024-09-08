{ pkgs
, ...
}:

let
 inherit (pkgs)
  runCommandNoCC;
in {
 hardware.firmware = [
   (runCommandNoCC "brcm-firmware" { } ''
      mkdir -p $out/lib/firmware/brcm
      cp ${./BRCM/brcmfmac43455-sdio.txt} $out/lib/firmware/brcm
   '')
 ];
}
