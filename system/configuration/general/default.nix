{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf mkDefault;
in {
 config = mkIf (config.general-configuration.enable) {
   programs.dconf.enable            = true;
   networking.networkmanager.enable = true;
   documentation.nixos.enable       = false;
   system.stateVersion              = "24.11";
   powerManagement.cpuFreqGovernor  = "ondemand";
   nixpkgs.hostPlatform             = "x86_64-linux";
   i18n.defaultLocale               = mkDefault "en_GB.UTF-8";

   security = {
     rtkit.enable            = true;
     polkit.enable           = true;
     sudo.wheelNeedsPassword = false;
   };

   hardware = {
     uinput.enable                 = true;
     enableRedistributableFirmware = true;
     pulseaudio.enable             = false;

     opengl = {
       enable          = true;
       driSupport      = true;
       driSupport32Bit = true;
     };
   };

   services = {
     udev.enable                  = true;
     fstrim.enable                = true;
     automatic-timezoned.enable   = true;
     power-profiles-daemon.enable = false;
     logind.lidSwitch             = "poweroff";
     tlp.enable                   = mkDefault true;

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

     users.vonix = {
       programs.home-manager.enable = true;

       home = {
         preferXdgDirectories = true;
         stateVersion         = "24.11";
       };
     };
   };

   nix = {
     gc = {
       automatic = true;
       dates     = "weekly";
       options   = "--delete-older-than 7d";
     };

     settings = {
       auto-optimise-store   = true;
       experimental-features = [ "nix-command" "flakes" ];
     };
   }; 

   boot = {
     plymouth.enable = true;

     supportedFilesystems = [
       "ntfs"
     ];

     initrd.availableKernelModules = [
       "vmd"
       "ahci"
       "ext4"
       "nvme"
       "sd_mod"
       "usbhid"
       "xhci_pci"
       "sdhci_acpi"
       "usb_storage"
       "rtsx_usb_sdmmc"
     ];

     kernelParams = [
       "quiet"
       "mitigations=off"
     ];

     loader = {
       timeout = 5;

       grub = {
         configurationLimit    = 10;
         enable                = true;
         efiSupport            = true;
         copyKernels           = true;
         efiInstallAsRemovable = true;
         device                = "nodev";
       };
     };
   };

   users.users.vonix = {
     uid            = 1000;
     isNormalUser   = true;
     home           = "/home/vonixos";
     extraGroups    = [ "audio" "video" "wheel" "networkmanager" ];
   };

   environment.shellAliases = {
     "update" = "nix-shell -p nixVersions.latest --run 'sudo nixos-rebuild switch --flake github:Vonixxx/Vontoo#" + "${config.users.users.vonix.name}'";
   };
 };
}