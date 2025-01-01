{ pkgs
, mkSystem
, mailserver
, ...
}:

#
# <user> = mkSystem <bool>          toggle TLP
#                   <bool>          toggle printing capabilities
#                   <bool>          toggle latest kernel
#                   <bool>          toggle AMD CPU settings
#                   <bool>          toggle AMD GPU settings
#                   <bool>          toggle Intel CPU settings
#                   <bool>          toggle Intel GPU settings
#                   <string>        keyboard language
#                   <string>        language locale
#                   <string>        location, used to determine time
#                   <string>        username
#                   <string>        password, encoded using `mkpasswd`
#                   <list>          extra modules
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
                     false
                     false
                     true
                     true
                     "be"
                     "en_GB.UTF-8"
                     "Europe/Brussels"
                     "Ofelia"
                     "$y$j9T$Bt3YhGYQoALhjeZY7MauX/$jlIcH1JuGjKz2UqTj7CEtwIbNNr8hRpqgRU7CEi0CBA"
                     []
                     []
                     []
                     []
                     []
                     {};

 F_Jarka = mkSystem false
                    true
                    false
                    false
                    false
                    true
                    true
                    "cz"
                    "cs_CZ.UTF-8"
                    "Europe/Prague"
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
                    false
                    false
                    true
                    true
                    "cz"
                    "cs_CZ.UTF-8"
                    "Europe/Prague"
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
                       false
                       false
                       true
                       true
                       "us"
                       "en_GB.UTF-8"
                       "Europe/Prague"
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
                     true
                     true
                     false
                     false
                     "us"
                     "en_GB.UTF-8"
                     "Europe/Brussels"
                     "Luca"
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
                      
                       home-manager.users."Luca" = {
                         programs.git = {
                           userName  = "Vonixxx";
                           userEmail = "vonixxxwork@tuta.io";
                         };
                       };
                     };

 V_WorkStation = mkSystem false
                          false
                          true
                          false
                          false
                          false
                          false
                          "us"
                          "en_GB.UTF-8"
                          "Europe/Brussels"
                          "Luca"
                          "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                          []
                          [
                           "tss"
                           "libvirtd"
                          ]
                          [
                           "vfio"
                           "vfio_pci"
                           "vfio_iommu_type1"
                           "vendor-reset"
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
                            bat.enable                   = true;
                            git.enable                   = true;
                            lsd.enable                   = true;
                            zsh.enable                   = true;
                            atuin.enable                 = true;
                            helix.enable                 = true;
                            programs.virt-manager.enable = true;

                            boot.extraModulePackages = with pkgs; [
                              linuxKernel.packages.linux_6_12.vendor-reset
                            ];

                            security.tpm2 = {
                              enable                 = true;
                              abrmd.enable           = true;
                              pkcs11.enable          = true;
                              tctiEnvironment.enable = true;
                            };
                         
                            virtualisation = {
                              spiceUSBRedirection.enable = true;
                         
                              libvirtd = {
                                enable = true;
                         
                                qemu = {
                                  swtpm.enable = true;
                                  package      = pkgs.qemu_kvm;
                         
                                  ovmf.packages = [
                                    (pkgs.OVMFFull.override {
                                      secureBoot = true;
                                      tpmSupport = true;
                                    }).fd
                                  ];
                                };
                              };
                            };
                           
                            home-manager.users."Luca" = {
                              programs.git = {
                                userName  = "Vonixxx";
                                userEmail = "vonixxxwork@tuta.io";
                              };
                            };
                           
                            environment.variables = {
                              EDITOR  = mkForce "hx";
                              VISUAL  = mkForce "hx";
                              PF_INFO = "ascii title uptime pkgs kernel memory os host";
                            };
                          };
}
