{ pkgs
, jovian
, mkSystem
, mailserver
, ...
}:

#
# <user> = mkSystem <bool> toggle TLP.
#                   <bool> toggle printing capabilities.
#                   <bool> toggle AMD CPU settings.
#                   <bool> toggle AMD GPU settings.
#                   <bool> toggle Intel CPU settings.
#                   <bool> toggle Intel GPU settings.
#                   <string> keyboard language.
#                   <string> language locale.
#                   <string> location, used to determine time.
#                   <string> username.
#                   <string> folder location for other user-specific configuration.
#                   <string> password, encoded using `mkpasswd`.
#                   <list> extra modules.
#                   <list> overlays for nixpkgs.
#                   <list> packages.
#

with pkgs;
with kdePackages;

let 
 sddm_catppuccin_custom = (pkgs.slstatus.overrideAttrs {
    fontSize        = "12";
    background      = null;
    loginBackground = false;
    flavor          = "mocha";
    font            = "FiraCode Nerd Font";
 });

 launch_dwl = pkgs.writeShellScriptBin "launch_dwl" ''
    exec slstatus -s | dwl -s "wlr-randr --output \"eDP-1\" --off && mpvpaper -o \"no-audio --loop-file=inf\" '*' /home/luca/Pictures/Lost_Cat.mp4"
 '';

 slstatus_custom = (pkgs.slstatus.overrideAttrs {
    src = fetchgit {
      rev  = "94501a405c2768014ff121d4d811e6b390cf36f2";
      url  = "https://codeberg.org/BroomBear/SL_Status.git";
      hash = "sha256-HxzBHz3XwmWKob3VyW+wPHUBcCDiWb+3SEYvsgcg7LE=";
    };
 });

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

 dwl_custom = pkgs.callPackage ../System/Programs_Custom/DWL/default.nix {  };
in {
 U_Ofelia = mkSystem false
                     true
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
                    true
                    true
                    "cz"
                    "cs_CZ.UTF-8"
                    "Europe/Prague"
                    "Jarka"
                    "/F/Jarka"
                    "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                    []
                    []
                    [];

 F_Libor = mkSystem false
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
                       true
                       true
                       "us"
                       "en_GB.UTF-8"
                       "Europe/Prague"
                       "Bubinka"
                       "/F/Stepanka"
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

 V_SteamDeck = mkSystem false
                        false
                        false
                        false
                        false
                        false
                        "us"
                        "en_GB.UTF-8"
                        "Europe/Brussels"
                        "Luca"
                        "/V/SteamDeck"
                        "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                        [
                         jovian.nixosModules.jovian
                        ]
                        [
                         jovian.overlays.default
                        ]
                        [
                          asdf-vm
                          alsa-utils
                          blobdrop
                          curl
                          du-dust
                          dwl_custom
                          dolphin-emu
                          efibootmgr
                          ffmpeg
                          launch_dwl
                          mpvpaper
                          mediainfo
                          odin_custom
                          pcsx2
                          pfetch-rs
                          pulseaudio
                          protontricks
                          ps3iso-utils
                          qemu
                          rpcs3
                          slstatus_custom
                          sddm_catppuccin_custom
                          tldr
                          trezor-suite
                          wget
                          wlsunset
                          wlr-randr
                        ];
}
