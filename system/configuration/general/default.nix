{ lib
, pkgs
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
   system.stateVersion              = "23.11";
   powerManagement.cpuFreqGovernor  = "ondemand";
   nixpkgs.hostPlatform             = "x86_64-linux";
   i18n.defaultLocale               = mkDefault "en_GB.UTF-8";

   fonts.fontconfig = {
     allowBitmaps  = false;
     subpixel.rgba = "rgb";
     hinting.style = "full";
   };

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

   nix = {
     gc = {
       automatic = true;
       dates     = "weekly";
       options   = "--delete-older-than 3d";
     };

     settings = {
       auto-optimise-store   = true;
       experimental-features = [ "nix-command" "flakes" ];
     };
   }; 

   boot = {
     tmp.cleanOnBoot      = true;
     supportedFilesystems = [ "ntfs" ];

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
         configurationLimit    = 5;
         enable                = true;
         efiSupport            = true;
         copyKernels           = true;
         efiInstallAsRemovable = true;
         device                = "nodev";

         theme = pkgs.sleek-grub-theme.override {
           withStyle  = "dark";
           withBanner = "Greetings, " + "${config.users.users.vonix.name}";
         };
       };
     };
   };

   users.users.vonix = {
     uid            = 1000;
     isNormalUser   = true;
     home           = "/home/vonixos";
     extraGroups    = [ "lp" "audio" "video" "wheel" "scanner" "networkmanager" ];
   };

   home-manager.users.vonix = {
     programs.home-manager.enable = true;
     home.stateVersion            = "23.11";
     dconf.settings               = { "org/gnome/desktop/interface".color-scheme = "prefer-dark"; };
   };

   environment.shellAliases = {
     "update-v.laptop"   = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#v.laptop' --impure"; 
     "update-v.desktop"  = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#v.desktop' --impure"; 
     "update-f.libor"    = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#f.libor' --impure"; 
     "update-f.jarka"    = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#f.jarka' --impure"; 
     "update-u.ofelia"   = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#u.ofelia' --impure"; 
     "update-f.stepanka" = "sudo nix flake update 'github:Vonixxx/VonixOS' && sudo nixos-rebuild boot --no-write-lock-file --flake 'github:Vonixxx/VonixOS#f.stepanka' --impure"; 
   };
 };
}
