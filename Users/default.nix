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
#                   <string>        password, encoded using `mkpasswd`
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

 raylib_custom = (pkgs.raylib.overrideAttrs {
    cmakeFlags = [
      "-DBUILD_EXAMPLES=OFF"
      "-DCUSTOMIZE_BUILD=ON"
      "-DBUILD_SHARED_LIBS=OFF"
      "-Draylib_USE_STATIC_LIBS=ON"
      "-DSUPPORT_FILEFORMAT_JPG=ON"
      "-DSUPPORT_FILEFORMAT_FLAC=1"
    ];
 });

 odin_custom = (pkgs.odin.overrideAttrs {
     src = pkgs.fetchFromGitHub {
       repo   = "Odin";
       owner  = "odin-lang";
       rev    = "ee76acd665911e2f28d5183b3c0a07a665dbf858";
       sha256 = "sha256-1UpuDeHe+gbczB7xUQQvh5VtRM1ctXKLkPBsSSmzFrQ=";
     };

     installPhase = ''
       runHook preInstall

       mkdir -p $out/bin
       cp odin $out/bin/odin
       mkdir -p $out/share
       cp -r {base,core,vendor,shared} $out/share
       cp ${raylib_custom}/lib/libraylib.a $out/share/vendor/raylib/linux/libraylib.a

       wrapProgram $out/bin/odin \
         --prefix PATH : ${
           pkgs.lib.makeBinPath (
             with pkgs.llvmPackages;
             [
               bintools
               llvm
               clang
               lld
             ]
           )
         } \
         --set-default ODIN_ROOT $out/share

       runHook postInstall
    '';
 });
in {
 U_Ofelia = mkSystem false
                     true
                     false
                     "be"
                     "en_GB.UTF-8"
                     "Ofelia"
                     "$y$j9T$Bt3YhGYQoALhjeZY7MauX/$jlIcH1JuGjKz2UqTj7CEtwIbNNr8hRpqgRU7CEi0CBA"
                     []
                     []
                     []
                     []
                     []
                     {
                       style.scale = mkForce 2;
                     };

 F_Jarka = mkSystem false
                    true
                    false
                    "cz"
                    "cs_CZ.UTF-8"
                    "Jarka"
                    "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                    []
                    []
                    []
                    []
                    []
                    {};

 F_Libor = mkSystem false
                    false
                    false
                    "cz"
                    "cs_CZ.UTF-8"
                    "Libor"
                    "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
                    []
                    []
                    []
                    []
                    []
                    {
                      hardware.firmware = [
                        (runCommandNoCC "brcm-firmware" { } ''
                           mkdir -p $out/lib/firmware/brcm
                           cp ${./Dependencies/F/Libor/brcmfmac43455-sdio.txt} $out/lib/firmware/brcm
                        '')
                      ];
                    };

 F_Stepanka = mkSystem true
                       true
                       false
                       "us"
                       "en_GB.UTF-8"
                       "Bubinka"
                       "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
                       []
                       []
                       []
                       []
                       [
                         ffmpeg
                         freecad
                         gimp
                         inkscape
                         krita
                         kdenlive
                         obs-studio
                       ]
                       {};

 V_Lenovo = mkSystem false
                     false
                     false
                     "us"
                     "en_GB.UTF-8"
                     "BroomBear"
                     "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                     [
                      mailserver.nixosModules.mailserver
                     ]
                     []
                     []
                     []
                     [
                       curl
                       efibootmgr
                       pfetch-rs
                       tldr
                     ]
                     {
                       bat.enable   = true;
                       git.enable   = true;
                       lsd.enable   = true;
                       zsh.enable   = true;
                       atuin.enable = true;
                       helix.enable = true;
                      
                       environment.variables = {
                         EDITOR  = mkForce "hx";
                         VISUAL  = mkForce "hx";
                         PF_INFO = "ascii title uptime pkgs kernel memory os host";
                       };
                      
                       home-manager.users."BroomBear" = {
                         programs.git = {
                           userName  = "Vonixxx";
                           userEmail = "vonixxxwork@tuta.io";
                         };
                       };
                     };

 V_WorkStation = mkSystem false
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
                            alsa-utils
                            curl
                            du-dust
                            efibootmgr
                            ffmpeg
                            mpvpaper
                            mediainfo
                            odin_custom
                            pfetch-rs
                            qemu
                            tldr
                            trezor-suite
                            wget
                            hyprsunset
                            soulseekqt
                          ]
                          {
                            bat.enable            = true;
                            git.enable            = true;
                            lsd.enable            = true;
                            zsh.enable            = true;
                            atuin.enable          = true;
                            helix.enable          = true;
                            virtualisation.enable = true;

                            home-manager.users."BroomBear" = {
                              programs.git = {
                                userName  = "Vonixxx";
                                userEmail = "vonixxxwork@tuta.io";
                              };
                            };
                           
                            boot.extraModulePackages = [
                              pkgs.linuxKernel.packages.linux_6_12.vendor-reset
                            ];
                           
                            environment.variables = {
                              EDITOR  = mkForce "hx";
                              VISUAL  = mkForce "hx";
                              PF_INFO = "ascii title uptime pkgs kernel memory os host";
                            };
                          };
}
