{ lib
, tlp
, pkgs
, config
, keymap
, locale
, password
, timezone
, username
, extraUserGroups
, userConfiguration
, extraKernelModules
, extraKernelParameters
, ...
}:

let
 cfg = config;

 inherit (lib.strings)
  toLower;

 inherit (lib)
  mkIf mkMerge;
in {
 config = mkMerge [
   (mkIf cfg.general_configuration.enable {
     programs.dconf.enable           = true;
     documentation.nixos.enable      = false;
     system.stateVersion             = "24.11";
     powerManagement.cpuFreqGovernor = "ondemand";
     i18n.defaultLocale              = "${locale}";
     time.timeZone                   = "${timezone}";
  
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
       tlp.enable         = tlp;
       gvfs.enable        = true;
       fstrim.enable      = true;
       logind.lidSwitch   = "poweroff";
       xserver.xkb.layout = "${keymap}";
  
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
     };
  
     environment.variables = {
       NIXOS_OZONE_WL = "1";
       BROWSER        = "brave";
       EDITOR         = "gnome-text-editor";
       VISUAL         = "gnome-text-editor";
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
       kernelParams = [
        "quiet"
        "splash"
        "mitigations=off"
       ] ++ extraKernelParameters;
  
       supportedFilesystems = [
         "ntfs"
       ];
  
       plymouth = {
         enable = true;
         theme  = "catppuccin-mocha";
       };
  
       initrd = {
         includeDefaultModules = true;

         kernelModules = [
         ] ++ extraKernelModules;
  
         availableKernelModules = [
           "vmd"
           "xfs"
           "sdhci_acpi"
           "usb_storage"
           "rtsx_usb_sdmmc"
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
            "network"
           ] 

           extraUserGroups

           (mkIf cfg.printing.enable [
            "lp"
            "scanner"
           ]) 
         ];
       };
     };
   })

   userConfiguration
 ];
}
