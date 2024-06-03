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
         configurationLimit    = 3;
         enable                = true;
         efiSupport            = true;
         copyKernels           = true;
         efiInstallAsRemovable = true;
         device                = "nodev";
       };
     };
   };

   services = {
     udev.enable                  = true;
     fstrim.enable                = true;
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

   nix = {
     gc = {
       automatic = true;
       dates     = "daily";
       options   = "--delete-older-than 7d";
     };

     settings = {
       auto-optimise-store   = true;
       experimental-features = [ "nix-command" "flakes" ];
     };
   }; 

   environment.shellAliases = {
     "update" = "nix-shell -p nixVersions.latest --run 'sudo nixos-rebuild boot --flake github:Vonixxx/Vontoo#" + "${config.users.users.vonix.name}'";
   };
 };
}
