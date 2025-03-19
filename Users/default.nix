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

 # raylibCustom = (pkgs.raylib.overrideAttrs {
 #    cmakeFlags = [
 #      "-DBUILD_EXAMPLES=OFF"
 #      "-DCUSTOMIZE_BUILD=ON"
 #      "-DBUILD_SHARED_LIBS=OFF"
 #      "-Draylib_USE_STATIC_LIBS=ON"
 #      "-DSUPPORT_FILEFORMAT_JPG=ON"
 #      "-DSUPPORT_FILEFORMAT_FLAC=1"
 #    ];
 # });

 # odinCustom = (pkgs.odin.overrideAttrs {
 #     src = pkgs.fetchFromGitHub {
 #       repo   = "Odin";
 #       owner  = "odin-lang";
 #       rev    = "ee76acd665911e2f28d5183b3c0a07a665dbf858";
 #       sha256 = "sha256-1UpuDeHe+gbczB7xUQQvh5VtRM1ctXKLkPBsSSmzFrQ=";
 #     };

 #     installPhase = ''
 #       runHook preInstall

 #       mkdir -p $out/bin
 #       cp odin $out/bin/odin
 #       mkdir -p $out/share
 #       cp -r {base,core,vendor,shared} $out/share
 #       cp ${raylibCustom}/lib/libraylib.a $out/share/vendor/raylib/linux/libraylib.a

 #       wrapProgram $out/bin/odin \
 #         --prefix PATH : ${
 #           pkgs.lib.makeBinPath (
 #             with pkgs.llvmPackages;
 #             [
 #               bintools
 #               llvm
 #               clang
 #               lld
 #             ]
 #           )
 #         } \
 #         --set-default ODIN_ROOT $out/share

 #       runHook postInstall
 #    '';
 # });
in {
 U_Ofelia = mkSystem false
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
                            curl
                            du-dust
                            efibootmgr
                            ffmpeg
                            mpvpaper
                            mediainfo
                            # odinCustom
                            pfetch-rs
                            qemu
                            tldr
                            tor-browser
                            trezor-suite
                            telegram-desktop
                            wget
                          ]
                          {
                            enable = {
                              bat            = mkForce true;
                              git            = mkForce true;
                              lsd            = mkForce true;
                              atuin          = mkForce true;
                              helix          = mkForce true;
                              virtualisation = mkForce true;
                            };

                            home-manager.users."BroomBear" = {
                              programs.git = {
                                userName  = "Vonixxx";
                                userEmail = "vonixxxwork@tuta.io";
                              };

                              wayland.windowManager.hyprland = {
                                settings =
                                let
                                 mod = "SUPER";
                                in {
                                  bindo = [
                                    "SUPER , S , exec , waybar"
                                  ];
                      
                                  bindr = [
                                    "SUPER , S , exec , pkill waybar"
                                  ];
                                };
                              };
                            };
                           
                            boot.extraModulePackages = [
                              pkgs.linuxKernel.packages.linux_6_13.vendor-reset
                            ];
                           
                            environment.variables = {
                              EDITOR  = mkForce "hx";
                              VISUAL  = mkForce "hx";
                              PF_INFO = "ascii title uptime pkgs kernel memory os host";
                            };
                          };
}
