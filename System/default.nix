{ lib
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
  mkIf
  mkMerge;

 inherit (lib.strings)
  toLower;

 inherit (lib.trivial)
  importJSON;

 cfg       = config;
 cfgEnable = config.enable;
 args      = importJSON argumentsCLI.outPath;

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

 systemUpdateBoot = ''
    nix run github:nikolaiser/purga -- \
    -i argumentsCLI \
    -a cpu=$(${fetchCPU}) \
    -a gpu=$(${fetchGPU}) \
    -a hardware="$(${fetchHardware})" -- \
    sudo nixos-rebuild boot --flake github:Vonixxx/Vontoo\#${username}
 '';

 systemUpdateRealtime = ''
    nix run github:nikolaiser/purga -- \
    -i argumentsCLI \
    -a cpu=$(${fetchCPU}) \
    -a gpu=$(${fetchGPU}) \
    -a hardware="$(${fetchHardware})" -- \
    sudo nixos-rebuild switch --flake github:Vonixxx/Vontoo\#${username}
 '';
in {
 config = mkMerge [
   userConfiguration

   (mkIf cfgEnable.generalConfiguration {
     programs.dconf.enable           = true;
     documentation.nixos.enable      = false;
     i18n.defaultLocale              = locale;
     system.stateVersion             = "24.11";
     powerManagement.cpuFreqGovernor = "ondemand";

     console = {
       earlySetup = true;
       keyMap     = keymap;
     };

     networking = {
       wireless.iwd.enable = true;
       hostName            = "vontoo";
     };
  
     security = {
       rtkit.enable            = true;
       polkit.enable           = true;
       sudo.wheelNeedsPassword = false;
     };
  
     systemd.sleep.extraConfig = ''
        AllowSuspend=yes
        AllowHibernation=no
        AllowHybridSleep=no
        HibernateDelaySec=30min
        SuspendEstimationSec=60min
        AllowSuspendThenHibernate=no
        HibernateMode=platform shutdown
        SuspendState=mem standby freeze
     '';
  
     services = {
       gvfs.enable        = true;
       fstrim.enable      = true;
       tzupdate.enable    = true;
       xserver.xkb.layout = keymap;
       logind.lidSwitch   = "poweroff";
       tlp.enable         = cfgEnable.tlp;
  
       pipewire = {
         enable            = true;
         alsa.enable       = true;
         pulse.enable      = true;
         alsa.support32Bit = true;
       };

       getty = mkMerge [
         {
          greetingLine = "<<< Welcome to Vontoo! (\m) - \l >>>";
         }

         (mkIf cfgEnable.autologin {
           autologinUser = "${username}";
         })
       ];
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
         check          = systemCheck;
         updateBoot     = systemUpdateBoot;
         updateRealtime = systemUpdateRealtime;
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
          GTK_THEME      = "Adwaita:dark";
          EDITOR         = "gnome-text-editor";
          VISUAL         = "gnome-text-editor";
          PF_INFO        = "ascii title uptime pkgs kernel memory os host";
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
       plymouth.enable = true;

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

           (mkIf cfgEnable.printing [
             "lp"
             "scanner"
           ]) 

           (mkIf cfgEnable.virtualisation [
             "tss"
             "libvirtd"
           ]) 
         ];
       };
     };
   })
 ];
}
