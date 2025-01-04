{ lib
, tlp
, pkgs
, config
, keymap
, locale
, password
, username
, argumentsCLI
, extraUserGroups
, userConfiguration
, extraKernelModules
, extraKernelParameters
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 inherit (lib.strings)
  toLower;

 inherit (lib.asserts)
  assertMsg;

 inherit (lib.trivial)
  importJSON;

 cfg  = config;
 args = importJSON argumentsCLI.outPath;

 fetchHardware = ''
    nixos-generate-config --show-hardware-config | grep boot.initrd.availableKernelModules | awk -F '[][]' '{gsub(/"/, "", $2); gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}'
 '';

 fetchGPUAMD = ''
    lspci | grep -q "AMD" && echo "true" || echo "false"
 '';

 fetchGPUIntel = ''
    lspci | grep -q "Intel" && echo "true" || echo "false"
 '';

 fetchCPUAMD = ''
    grep -q "AMD" /proc/cpuinfo && echo "true" || echo "false"
 '';

 fetchCPUIntel = ''
    grep -q "Intel" /proc/cpuinfo && echo "true" || echo "false"
 '';

 systemUpdate = ''
    nix run github:nikolaiser/purga -- -i argumentsCLI -a hardware="$(${fetchHardware})" -a cpuAMD=$(${fetchCPUAMD}) -a cpuIntel=$(${fetchCPUIntel}) -a gpuIntel=$(${fetchGPUIntel}) -a gpuAMD=$(${fetchGPUAMD}) -- sudo nixos-rebuild switch --flake "./#V_WorkStation"
 '';
in {
 config = mkMerge [
   userConfiguration

   (mkIf cfg.general_configuration.enable {
     programs.dconf.enable           = true;
     documentation.nixos.enable      = false;
     system.stateVersion             = "24.11";
     powerManagement.cpuFreqGovernor = "ondemand";
     i18n.defaultLocale              = "${locale}";
  
     networking = {
       wireless.iwd.enable = true;
       hostName            = "vontoo";
     };
  
     security = {
       rtkit.enable            = true;
       polkit.enable           = true;
       sudo.wheelNeedsPassword = false;
     };
  
     services = {
       tlp.enable                 = tlp;
       gvfs.enable                = true;
       fstrim.enable              = true;
       automatic-timezoned.enable = true;
       logind.lidSwitch           = "poweroff";
       xserver.xkb.layout         = "${keymap}";
  
       pipewire = {
         enable            = true;
         alsa.enable       = true;
         pulse.enable      = true;
         alsa.support32Bit = true;
       };
     };
  
     hardware = {
       uinput.enable     = true;
       enableAllFirmware = true;
  
       graphics = {
         enable      = true;
         enable32Bit = true;
       };

       cpu = mkMerge [ 
         (mkIf (args.cpuAMD == "true") {
           amd.updateMicrocode = true;
         })

         (mkIf (args.cpuIntel == "true") {
           intel.updateMicrocode = true;
         })
       ];
     };
  
     environment = {
       shellAliases = {
         update = systemUpdate;
       };

       variables = mkMerge [
         (mkIf (args.gpuAMD == "true") {
           ROC_ENABLE_PRE_VEGA = "1";
         })
  
         (mkIf (args.gpuIntel == "true") {
           LIBVA_DRIVER_NAME = "iHD";
         })
  
         {
          NIXOS_OZONE_WL = "1";
          BROWSER        = "brave";
          EDITOR         = "gnome-text-editor";
          VISUAL         = "gnome-text-editor";
         }
       ];
     };
  
     home-manager = {
       backupFileExtension = "backup";
  
       users.${username} = {
         programs.home-manager.enable = true;
  
         home = {
           preferXdgDirectories = true;
           stateVersion         = "24.11";
         };
  
         gtk = {
           enable = true;
  
           iconTheme = {
             name    = "Adwaita";
             package = pkgs.adwaita-icon-theme;
           };
         };
       };
     };
  
     boot = {
       supportedFilesystems = [
         "ntfs"
       ];

       kernelModules = mkMerge [
         (mkIf (args.gpuAMD == "true") [
           "amdgpu"
         ]) 

         (mkIf (args.cpuAMD == "true") [
           "kvm-amd"
         ]) 

         (mkIf (args.gpuIntel == "true") [
           "i915"
         ]) 

         (mkIf (args.cpuIntel == "true") [
           "kvm-intel"
         ]) 
       ];

       kernelParams = mkMerge [
         extraKernelParameters

         [
          "quiet"
          "splash"
          "mitigations=off"
         ]

         (mkIf (args.gpuAMD == "true") [
           "radeon.si_support=0"
           "amdgpu.si_support=1"
           "radeon.cik_support=0"
           "amdgpu.cik_support=1"
         ]) 
       ];
  
       plymouth = {
         enable = true;
         theme  = "catppuccin-mocha";
       };
  
       initrd = {
         includeDefaultModules = false;
         kernelModules         = extraKernelModules;

         availableKernelModules = [
           args.hardware
         ];
       };
  
       loader = {
         timeout = 5;
  
         systemd-boot = {
           configurationLimit = 10;
           enable             = true;
           memtest86.enable   = true;
         };
       };
     };
  
     nix = {
       channel.enable = false;
  
       gc = {
         options   = "-d";
         automatic = true;
         dates     = "weekly";
       };
  
       settings = {
         auto-optimise-store = true;
  
         experimental-features = [
           "flakes"
           "nix-command"
         ];
       };
     };
  
     users.users = {
       root.initialHashedPassword = "${password}";
  
       ${username} = {
         uid                   = 1000;
         isNormalUser          = true;
         name                  = "${username}";
         initialHashedPassword = "${password}";
         home                  = "/home/" + toLower"${username}";
  
         extraGroups = mkMerge [
           [
            "audio"
            "video"
            "wheel"
           ] 

           extraUserGroups

           (mkIf cfg.printing.enable [
             "lp"
             "scanner"
           ]) 

           (mkIf cfg.virtualisation.enable [
             "tss"
             "libvirtd"
           ]) 
         ];
       };
     };
   })
 ];
}
