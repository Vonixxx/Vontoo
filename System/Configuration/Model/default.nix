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

     boot.kernelParams = [
       "radeon.si_support=0"
       "amdgpu.si_support=1"
       "radeon.cik_support=0"
       "amdgpu.cik_support=1"
     ];

     environment.variables = {
       ROC_ENABLE_PRE_VEGA = "1";
     };

     hardware.graphics.extraPackages = 
     with pkgs; [
       amdvlk
       rocmPackages.clr.icd
       driversi686Linux.amdvlk
     ];

     systemd.tmpfiles.rules = [
       "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
     ];
   })

   (mkIf config.intel_cpu.enable {
     hardware.cpu.intel.updateMicrocode = true;

     boot.kernelModules = [
       "kvm-intel"
     ];
   })

   (mkIf config.intel_gpu.enable {
     environment.variables.LIBVA_DRIVER_NAME = "iHD";

     boot.kernelModules = [
       "i915"
     ];

     hardware.graphics.extraPackages = with pkgs; [
       libvdpau-va-gl
       intel-media-driver
       intel-vaapi-driver
     ];
   })
 ];
}
