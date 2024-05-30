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
   (mkIf config.amd-gpu.enable {
     boot.kernelModules            = [ "amdgpu" ];
     hardware.opengl.extraPackages = [ pkgs.amdvlk ];
   })

   (mkIf config.amd-cpu.enable {
     hardware.cpu.amd.updateMicrocode = true;
     boot.kernelModules               = [ "kvm-amd" ];
   })

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
