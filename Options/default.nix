{ lib
, ...
}:

let
 inherit (lib)
  mkOption;

 inherit (lib.types)
  str
  bool
  ints
  listOf
  package
  submodule;

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
   enable = {
     bat = mkOption {
       type = bool;
     };
  
     git = mkOption {
       type = bool;
     };
  
     lsd = mkOption {
       type = bool;
     };
  
     zsh = mkOption {
       type = bool;
     };
  
     foot = mkOption {
       type = bool;
     };
  
     atuin = mkOption {
       type = bool;
     };
  
     fonts = mkOption {
       type = bool;
     };

     helix = mkOption {
       type = bool;
     };
  
     bemenu = mkOption {
       type = bool;
     };

     laptop = mkOption {
       type = bool;
     };

     colors = mkOption {
       type = bool;
     };

     cursor = mkOption {
       type = bool;
     };
  
     waybar = mkOption {
       type = bool;
     };
  
     freetube = mkOption {
       type = bool;
     };
  
     hyprland = mkOption {
       type = bool;
     };
  
     printing = mkOption {
       type = bool;
     };
  
     virtualisation = mkOption {
       type = bool;
     };
  
     generalConfiguration = mkOption {
       type = bool;
     };
   };

   style = {
     general = {
       wallpaper = mkOption {
         type = str;
       };

       gaps = mkOption {
         type = ints.unsigned;
       };
  
       scale = mkOption {
         type = ints.unsigned;
       };
  
       rounding = mkOption {
         type = ints.unsigned;
       };
  
       barPosition = mkOption {
         type = str;
       };
  
       borderThickness = mkOption {
         type = ints.unsigned;
       };
     };

     colors = {
       gtk = mkOption {
         type = str;
       };
      
       red = mkOption { 
         type = str;
       };

       sky = mkOption { 
         type = str;
       };

       base = mkOption { 
         type = str;
       };
      
       blue = mkOption { 
         type = str;
       };
      
       pink = mkOption { 
         type = str;
       };
      
       text = mkOption { 
         type = str;
       };
      
       crust = mkOption { 
         type = str;
       };
      
       green = mkOption { 
         type = str;
       };
      
       mauve = mkOption { 
         type = str;
       };
      
       peach = mkOption { 
         type = str;
       };
      
       yellow = mkOption { 
         type = str;
       };
      
       lavender = mkOption { 
         type = str;
       };

       flamingo = mkOption { 
         type = str;
       };

       surface0 = mkOption { 
         type = str;
       };
     };

     cursor = mkOption {
       type = cursorSettings;
     };

     fonts = {
       serif = mkOption {
         type = fontType;
       };

       sansSerif = mkOption {
         type = fontType;
       };

       monospace = mkOption {
         type = fontType;
       };

       emoji = mkOption {
         type = fontType;
       };

       packages = mkOption {
         type = listOf package;
       };

       size = {
         bar = mkOption {
           type = ints.unsigned;
         };

         titleBar = mkOption {
           type = ints.unsigned;
         };

         terminal = mkOption {
           type = ints.unsigned;
         };

         applications = mkOption {
           type = ints.unsigned;
         };
       };
     };
   };
 };
}
