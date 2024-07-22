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
   (mkIf config.amd-cpu.enable {
     hardware.cpu.amd.updateMicrocode = true;

     boot.kernelModules = [
       "kvm-amd"
     ];
   })

   (mkIf config.amd-gpu.enable {
     boot.kernelModules = [
       "amdgpu"
     ];

     hardware.graphics.extraPackages = [
       pkgs.amdvlk
     ];
   })

   (mkIf config.intel-cpu.enable {
     hardware.cpu.intel.updateMicrocode = true;

     boot.kernelModules = [
       "kvm-intel"
     ];
   })

   (mkIf config.intel-gpu.enable {
     boot.kernelModules = [
       "i915"
     ];

     hardware.graphics.extraPackages = [
       pkgs.intel-media-driver
     ];
   })
 ];
}
