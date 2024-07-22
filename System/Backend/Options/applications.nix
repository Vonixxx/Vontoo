{ lib
, ...
}:

let
 inherit (lib.types)
  bool;

 inherit (lib)
  mkOption;
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

   amd-cpu.enable = mkOption {
     type    = bool;
     default = false;
   };

   amd-gpu.enable = mkOption {
     type    = bool;
     default = false;
   };

   firefox.enable = mkOption {
     type    = bool;
     default = true;
   };

   freetube.enable = mkOption {
     type    = bool;
     default = false;
   };

   printing.enable = mkOption {
     type    = bool;
     default = false;
   };

   intel-cpu.enable = mkOption {
     type    = bool;
     default = false;
   };

   intel-gpu.enable = mkOption {
     type    = bool;
     default = false;
   };

   general-configuration.enable = mkOption {
     type    = bool;
     default = true;
   };
 };
}
