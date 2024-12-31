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
 inherit (lib)
  mkOption;

 inherit (lib.types)
  str bool ints listOf package submodule;

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
     default = true;
   };

   atuin.enable = mkOption {
     type    = bool;
     default = false;
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

   freetube.enable = mkOption {
     type    = bool;
     default = true;
   };

   bemenu.enable = mkOption {
     type    = bool;
     default = true;
   };

   hyprland.enable = mkOption {
     type    = bool;
     default = true;
   };

   waybar.enable = mkOption {
     type    = bool;
     default = config.hyprland.enable;
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
     gaps = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     rounding = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     bar_position = mkOption {
       type    = str;
       default = "top";
     };

     border_thickness = mkOption {
       default = 1;
       type    = ints.unsigned;
     };

     colors = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       gtk = mkOption {
         type    = str;
         default = "dark";
       };

       base = mkOption { 
         type    = str;
         default = "1e1e2e";
       };
      
       text = mkOption { 
         type    = str;
         default = "cdd6f4";
       };
      
       mauve = mkOption { 
         type    = str;
         default = "cba6f7";
       };
      
       surface0 = mkOption { 
         type    = str;
         default = "313244";
       };
      
       crust = mkOption { 
         type    = str;
         default = "11111b";
       };
      
       red = mkOption { 
         type    = str;
         default = "f38ba8";
       };

       flamingo = mkOption { 
         type    = str;
         default = "f2cdcd";
       };
      
       green = mkOption { 
         type    = str;
         default = "a6e3a1";
       };
      
       yellow = mkOption { 
         type    = str;
         default = "f9e2af";
       };
      
       blue = mkOption { 
         type    = str;
         default = "89b4fa";
       };
      
       pink = mkOption { 
         type    = str;
         default = "f5c2ef";
       };
      
       sky = mkOption { 
         type    = str;
         default = "89dceb";
       };
      
       lavender = mkOption { 
         type    = str;
         default = "b4befe";
       };
     };


     cursor = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       settings = mkOption {
         type = cursorSettings;

         default = {
           size    = 32;
           name    = "Bibata-Modern-Ice";
           package = pkgs.bibata-cursors;
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
         terminal = mkOption {
           default = 16;
           type    = ints.unsigned;
         };

         applications = mkOption {
           default = 12;
           type    = ints.unsigned;
         };

         titleBar = mkOption {
           default = 14;
           type    = ints.unsigned;
         };

         bar = mkOption {
           default = 20;
           type    = ints.unsigned;
         };
       };

       serif = mkOption {
         type = fontType;

         default = {
           name    = "FiraCode Nerd Font";
           package = pkgs.nerd-fonts.fira-code;
         };
       };

       sansSerif = mkOption {
         type = fontType;

         default = {
           name    = "BitstromWera Nerd Font";
           package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
         };
       };

       monospace = mkOption {
         type = fontType;

         default = {
           name    = "Hack Nerd Font Propo";
           package = pkgs.nerd-fonts.hack;
         };
       };

       emoji = mkOption {
         type = fontType;

         default = {
           name    = "Noto Color Emoji";
           package = pkgs.noto-fonts-color-emoji;
         };
       };
     };
   };
 };
}
