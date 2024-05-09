{ lib
, ...
}:

let
 inherit (lib)
  mkOption;

 inherit (lib.types)
  bool;
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

   mako.enable = mkOption {
     type    = bool;
     default = false;
   };

   atuin.enable = mkOption {
     type    = bool;
     default = false;
   };

   gnome.enable = mkOption {
     type    = bool;
     default = false;
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

   bemenu.enable = mkOption {
     type    = bool;
     default = false;
   };

   sioyek.enable = mkOption {
     type    = bool;
     default = false;
   };

   waybar.enable = mkOption {
     type    = bool;
     default = false;
   };

   freetube.enable = mkOption {
     type    = bool;
     default = true;
   };

   firefox.enable = mkOption {
     type    = bool;
     default = true;
   };

   hyprland.enable = mkOption {
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

   kdenlive-obs.enable = mkOption {
     type    = bool;
     default = false;
   };

   general-configuration.enable = mkOption {
     type    = bool;
     default = true;
   };
 };
}
