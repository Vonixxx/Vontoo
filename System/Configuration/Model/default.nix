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
   (mkIf config.amd_cpu.enable {
     hardware.cpu.amd.updateMicrocode = true;

     boot.kernelModules = [
       "kvm-amd"
     ];
   })

   (mkIf config.amd_gpu.enable {
     boot.kernelModules = [
       "amdgpu"
     ];

     hardware.graphics.extraPackages = [
       pkgs.amdvlk
     ];
   })

   (mkIf config.intel_cpu.enable {
     hardware.cpu.intel.updateMicrocode = true;

     boot.kernelModules = [
       "kvm-intel"
     ];
   })

   (mkIf config.intel_gpu.enable {
     boot.kernelModules = [
       "i915"
     ];

     hardware.graphics.extraPackages = [
       pkgs.intel-media-driver
     ];
   })
 ];
}
