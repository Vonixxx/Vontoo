{ lib
, pkgs
, config
, amd_cpu
, amd_gpu
, printing
, intel_cpu
, intel_gpu
, ...
}:


let
 inherit (lib.types)
  str bool ints listOf package submodule;

 inherit (lib)
  mkOption;

 fontType = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };
   };
 };

 cursorSettings = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };

     size = mkOption {
       type = ints.unsigned;
     };
   };
 };
in {
 options = {
   bat.enable = mkOption {
     type    = bool;
     default = false;
   };

   git.enable = mkOption {
     type    = bool;
     default = false;
   };

   lsd.enable = mkOption {
     type    = bool;
     default = false;
   };

   zsh.enable = mkOption {
     type    = bool;
     default = false;
   };

   foot.enable = mkOption {
     type    = bool;
     default = false;
   };

   atuin.enable = mkOption {
     type    = bool;
     default = false;
   };

   gnome.enable = mkOption {
     type    = bool;
     default = true;
   };

   helix.enable = mkOption {
     type    = bool;
     default = false;
   };

   amd_cpu.enable = mkOption {
     type    = bool;
     default = amd_cpu;
   };

   amd_gpu.enable = mkOption {
     type    = bool;
     default = amd_gpu;
   };

   firefox.enable = mkOption {
     type    = bool;
     default = true;
   };

   freetube.enable = mkOption {
     type    = bool;
     default = true;
   };

   printing.enable = mkOption {
     type    = bool;
     default = printing;
   };

   intel_cpu.enable = mkOption {
     type    = bool;
     default = intel_cpu;
   };

   intel_gpu.enable = mkOption {
     type    = bool;
     default = intel_gpu;
   };

   general_configuration.enable = mkOption {
     type    = bool;
     default = true;
   };

   style = {
     colors = {
       catppuccin.enable = mkOption {
         type    = bool;
         default = false;
       };

       adwaita.enable = mkOption {
         type    = bool;
         default = config.gnome.enable;
       };

       cursor = {
         enable = mkOption {
           type    = bool;
           default = true;
         };

         settings = mkOption {
           type = cursorSettings;

           default = {
             size    = 16;
             package = pkgs.bibata-cursors;
             name    = "Bibata Modern Classic";
           };
         };
       };
     };

     fonts = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       packages = mkOption {
         type = listOf package;
       };

       size = {
         popups = mkOption {
           default = 10;
           type    = ints.unsigned;
         };

         desktop = mkOption {
           default = 10;
           type    = ints.unsigned;
         };

         terminal = mkOption {
           default = 10;
           type    = ints.unsigned;
         };

         applications = mkOption {
           default = 10;
           type    = ints.unsigned;
         };
       };

       serif = mkOption {
         type = fontType;

         default = {
           name    = "DejaVu Serif";
           package = pkgs.dejavu_fonts;
         };
       };

       sansSerif = mkOption {
         type = fontType;

         default = {
           name    = "DejaVu Sans";
           package = pkgs.dejavu_fonts;
         };
       };

       monospace = mkOption {
         type = fontType;

         default = {
           name    = "DejaVu Mono";
           package = pkgs.dejavu_fonts;
         };
       };

       emoji = mkOption {
         type = fontType;

         default = {
           name    = "NotoColorEmoji";
           package = pkgs.noto-fonts-color-emoji;
         };
       };
     };
   };
 };
}
