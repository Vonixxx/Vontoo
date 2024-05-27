{ lib
, config
, catppuccin
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 inherit (builtins)
  toString;

 cfg = config.style.colors;
in {
 config = mkMerge [
   (mkIf cfg.enable {
     catppuccin.enable = true;

     home-manager.users.vonix = {
       imports = [ catppuccin.homeManagerModules.catppuccin ];

       catppuccin.enable                 = true;
       gtk.catppuccin.cursor.enable      = false;
       programs.waybar.catppuccin.enable = false;
     };
   })

   (mkIf cfg.cursor.enable {
     environment.variables.XCURSOR_SIZE = toString cfg.cursor.size;

     home-manager.users.vonix.home.pointerCursor = {
       gtk.enable = true;
       x11.enable = true;
       name       = cfg.cursor.name;
       size       = cfg.cursor.size;
       package    = cfg.cursor.package;
     };
   })
 ];
}
