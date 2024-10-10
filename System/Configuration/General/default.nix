{ lib
, tlp
, config
, keymap
, locale
, password
, timezone
, username
, ...
}:

let
 inherit (lib)
  mkIf;
 inherit (lib.strings)
  toLower;
in {
 config = mkIf config.general_configuration.enable {
   documentation.nixos.enable      = false;
   system.stateVersion             = "24.11";
   powerManagement.cpuFreqGovernor = "ondemand";
   i18n.defaultLocale              = "${locale}";
   time.timeZone                   = "${timezone}";

   environment.variables = {
     NIXOS_OZONE_WL = "1";
     BROWSER        = "firefox";
   };

   programs = {
     nix-ld.enable = true;

     nh = {
       enable = true;
  
       clean = {
         enable = true;
         extraArgs = "-k 3 -K 7d";
       };
     };
   };

   security = {
     rtkit.enable            = true;
     polkit.enable           = true;
     sudo.wheelNeedsPassword = false;
   };

   networking = {
     networkmanager.enable = true;
     hostName              = "vontoo";
   };

   hardware = {
     uinput.enable                 = true;
     enableRedistributableFirmware = true;

     graphics = {
       enable      = true;
       enable32Bit = true;
     };
   };

   services = {
     tlp.enable         = tlp;
     fstrim.enable      = true;
     logind.lidSwitch   = "poweroff";
     xserver.xkb.layout = "${keymap}";

     pipewire = {
       enable            = true;
       alsa.enable       = true;
       jack.enable       = true;
       pulse.enable      = true;
       alsa.support32Bit = true;
     };
   };

   home-manager = {
     backupFileExtension = "backup";

     users.${username} = {
       programs.home-manager.enable = true;

       home = {
         preferXdgDirectories = true;
         stateVersion         = "24.11";
       };
     };
   };

   boot = {
     plymouth.enable = true;

     kernelParams = [
       "quiet"
       "splash"
       "mitigations=off"
     ];

     supportedFilesystems = [
       "ntfs"
     ];

     initrd = {
       includeDefaultModules = true;

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

       grub = {
         configurationLimit    = 3;
         enable                = true;
         efiSupport            = true;
         copyKernels           = true;
         efiInstallAsRemovable = true;
         device                = "nodev";
       };
     };
   };

   nix = {
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

       extraGroups = [
         "audio"
         "video"
         "wheel"
         "networkmanager"
       ];
     };
   };
 };
}
