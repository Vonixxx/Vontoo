{ pkgs
, mkSystem
, mailserver
, ...
}:

#
# <user> = mkSystem <bool>   toggle TLP.
#                   <bool>   toggle printing capabilities.
#                   <bool>   toggle latest kernel.
#                   <bool>   toggle AMD CPU settings.
#                   <bool>   toggle AMD GPU settings.
#                   <bool>   toggle Intel CPU settings.
#                   <bool>   toggle Intel GPU settings.
#                   <string> keyboard language.
#                   <string> language locale.
#                   <string> location, used to determine time.
#                   <string> username.
#                   <string> folder location for other user-specific configuration.
#                   <string> password, encoded using `mkpasswd`.
#                   <list>   extra modules.
#                   <list>   overlays for nixpkgs.
#                   <list>   packages.
#

with pkgs;
with kdePackages;

let 
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
                     "/U/Ofelia"
                     "$y$j9T$Bt3YhGYQoALhjeZY7MauX/$jlIcH1JuGjKz2UqTj7CEtwIbNNr8hRpqgRU7CEi0CBA"
                     []
                     []
                     [];

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
                    null
                    "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                    []
                    []
                    [];

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
                    "/F/Libor"
                    "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
                    []
                    []
                    [];

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
                       null
                       "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
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
                       ];

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
                     "/V/Lenovo"
                     "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                     [
                      mailserver.nixosModules.mailserver
                     ]
                     []
                     [
                       curl
                       efibootmgr
                       pfetch-rs
                       tldr
                     ];

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
                          "/V/Common"
                          "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                          []
                          []
                          [
                            alsa-utils
                            bemenu
                            curl
                            du-dust
                            efibootmgr
                            ffmpeg
                            mpvpaper
                            mediainfo
                            odin_custom
                            pfetch-rs
                            protontricks
                            ps3iso-utils
                            qemu
                            tldr
                            trezor-suite
                            wget
                            hyprsunset
                          ];
}
