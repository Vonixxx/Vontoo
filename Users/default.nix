{ pkgs
, mkSystem
, mailserver
, ...
}:

#
# <user> = mkSystem <bool>          toggle TLP
#                   <bool>          toggle printing capabilities
#                   <bool>          toggle latest kernel
#                   <string>        keyboard language
#                   <string>        language locale
#                   <string>        username
#                   <string>        password, encoded using `mkpasswd -m sha-256 'password'`
#                   <list>          extra NixOS modules
#                   <list>          extra groups for the user
#                   <list>          extra kernel modules
#                   <list>          extra kernel parameters
#                   <list>          packages
#                   <attribute set> user-specific configuration
#

with pkgs;
with kdePackages;

let 
 inherit (lib)
  mkForce;

 inherit (pkgs)
  runCommandNoCC;
in {
 U_Ofelia =
 mkSystem false
          true
          false
          "be"
          "en_GB.UTF-8"
          "Ofelia"
          "$y$j9T$Twyoxr/IUWR8f9v4m6d81.$8a0XA0h3fzroWoLznLUYpZ7unoEEG3E30YUhkqoH2m1"
          []
          []
          []
          []
          []
          {
            style.general.scale = mkForce 2;
            enable.laptop       = mkForce true;
          };

 BroomBear =
 mkSystem false
          false
          true
          "us"
          "en_GB.UTF-8"
          "BroomBear"
          "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
          []
          []
          [
           "vfio"
           "vfio_pci"
           "vendor-reset"
           "vfio_iommu_type1"
          ]
          [
           "iommu=pt"
           "amd_iommu=on"
           "video=efifb:off"
           "rd.driver.pre=vfio-pci"
           "vfio-pci.ids=1002:731f,1002:ab38"
          ]
          [
           curl
           du-dust
           efibootmgr
           ffmpeg
           mpvpaper
           mediainfo
           tldr
           tor-browser
           trezor-suite
           telegram-desktop
           wget
          ]
          {
            style.general.wallpaper = mkForce "/home/broombear/Pictures/Chill.mp4";
           
            environment.variables = {
              EDITOR  = mkForce "hx";
              VISUAL  = mkForce "hx";
            };

            enable = {
              bat            = mkForce true;
              git            = mkForce true;
              lsd            = mkForce true;
              atuin          = mkForce true;
              helix          = mkForce true;
              virtualisation = mkForce true;
            };

            home-manager.users."BroomBear".programs = {
              git = {
                userName  = "Vonixxx";
                userEmail = "vonixxxwork@tuta.io";
              };
            };
          };
}
