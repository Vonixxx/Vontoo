{ jovian
, mkSystem
, ...
}:

{
 U_Ofelia = mkSystem "be"
                     "en_GB.UTF-8"
                     "Europe/Brussels"
                     "Ofelia"
                     "/U/Ofelia"
                     "$y$j9T$Bt3YhGYQoALhjeZY7MauX/$jlIcH1JuGjKz2UqTj7CEtwIbNNr8hRpqgRU7CEi0CBA"
                     []
                     [];

 F_Jarka = mkSystem "cz"
                    "cs_CZ.UTF-8"
                    "Europe/Prague"
                    "Jarka"
                    "/F/Jarka"
                    "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                    []
                    [];

 F_Libor = mkSystem "cz"
                    "cs_CZ.UTF-8"
                    "Europe/Prague"
                    "Libor"
                    "/F/Libor"
                    "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
                    []
                    [];

 F_Stepanka = mkSystem "us"
                       "en_GB.UTF-8"
                       "Europe/Prague"
                       "Bubinka"
                       "/F/Stepanka"
                       "$y$j9T$YQnrV6FSbngHwY4Y/xCR7/$b5I3pMtjPHb8YQdjXwuEZLFna9Nj2h7eT6uRP4P7n.4"
                       []
                       [];

 V_Lenovo = mkSystem "us"
                     "en_GB.UTF-8"
                     "Europe/Brussels"
                     "Luca"
                     "/V/Lenovo"
                     "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                     []
                     [];

 V_SteamDeck = mkSystem "us"
                        "en_GB.UTF-8"
                        "Europe/Brussels"
                        "Luca"
                        "/V/SteamDeck"
                        "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB"
                        [ jovian.nixosModules.jovian ]
                        [ jovian.overlays.default ];
}
