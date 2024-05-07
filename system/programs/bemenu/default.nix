{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.bemenu.enable) {
   environment = {
     systemPackages = [ pkgs.bemenu ];

     variables = {
       BEMENU_BACKEND = "wayland";

       BEMENU_OPTS = ''
          -w \
          -c \
          -l 5 \
          -B 3 \
          -W 0.3 \
          -p Launch \
          --tb '#1E1E2E' \
          --tf '#CBA6F7' \
          --ab '#1E1E2E' \
          --af '#CDD6F4' \
          --sb '#1E1E2E' \
          --sf '#F38BA8' \
          --fb '#1E1E2E' \
          --ff '#CDD6F4' \
          --hb '#1E1E2E' \
          --hf '#F38BA8' \
          --cb '#CDD6F4' \
          --cf '#CDD6F4' \
          --nb '#1E1E2E' \
          --nf '#CDD6F4' \
          --bdr '#CBA6F7'
       '';
     };
   };
 };
}
