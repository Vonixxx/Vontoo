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
    nixos-generate-config --show-hardware-config | \
    grep boot.initrd.availableKernelModules | \
    awk -F '[][]' '{gsub(/"/, "", $2); gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}'
 '';

 fetchGPU = ''
    (lspci | grep -q "Intel" && echo "Intel") || (lspci | grep -q "AMD" && echo "AMD")
 '';

 fetchCPU = ''
    (grep -q "AMD" /proc/cpuinfo && echo "AMD") || (grep -q "Intel" /proc/cpuinfo && echo "Intel")
 '';

 systemCheck = ''
    nix run github:nikolaiser/purga -- \
    -i argumentsCLI \
    -a cpu=$(${fetchCPU}) \
    -a gpu=$(${fetchGPU}) \
    -a hardware="$(${fetchHardware})" -- \
    nix flake check
 '';

 systemUpdate = ''
    nix run github:nikolaiser/purga -- \
    -i argumentsCLI \
    -a cpu=$(${fetchCPU}) \
    -a gpu=$(${fetchGPU}) \
    -a hardware="$(${fetchHardware})" -- \
    sudo nixos-rebuild switch --flake "./#V_WorkStation"
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
         (mkIf (args.cpu == "AMD") {
           amd.updateMicrocode = true;
         })

         (mkIf (args.cpu == "Intel") {
           intel.updateMicrocode = true;
         })
       ];
     };
  
     environment = {
       shellAliases = {
         check  = systemCheck;
         update = systemUpdate;
       };

       variables = mkMerge [
         (mkIf (args.gpu == "AMD") {
           ROC_ENABLE_PRE_VEGA = "1";
         })
  
         (mkIf (args.gpu == "Intel") {
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
         (mkIf (args.gpu == "AMD") [
           "amdgpu"
         ]) 

         (mkIf (args.cpu == "AMD") [
           "kvm-amd"
         ]) 

         (mkIf (args.gpu == "Intel") [
           "i915"
         ]) 

         (mkIf (args.cpu == "Intel") [
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

         (mkIf (args.gpu == "AMD") [
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
  
       loader = {
         timeout = 5;
  
         systemd-boot = {
           configurationLimit = 10;
           enable             = true;
           memtest86.enable   = true;
         };
       };
  
       initrd = {
         includeDefaultModules = false;
         kernelModules         = extraKernelModules;

         availableKernelModules = [
           args.hardware
         ];
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
