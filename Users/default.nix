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

with pkgs; {
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
                         freecad
                         gimp
                         inkscape
                         krita
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
                     []
                     []
                     [];

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
                         mailserver.nixosModules.mailserver
                        ]
                        [
                         jovian.overlays.default
                        ]
                        [
                          asdf-vm
                          curl
                          du-dust
                          dolphin-emu
                          efibootmgr
                          ffmpeg
                          mediainfo
                          pcsx2
                          pfetch-rs
                          protontricks
                          rpcs3
                          tldr
                          wget
                        ];
}
