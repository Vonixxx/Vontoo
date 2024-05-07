{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;
in {
config = mkMerge [
   (mkIf config.intel-cpu.enable {
     hardware.cpu.intel.updateMicrocode = true;
     boot.kernelModules                 = [ "kvm-intel" ];
   })

   (mkIf config.intel-gpu.enable {
     boot.kernelModules            = [ "i915" ];
     hardware.opengl.extraPackages = [ pkgs.intel-media-driver ];
   })
 ];
}
