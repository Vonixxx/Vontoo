{ lib
, config
, catppuccin
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;

 cfg = config.style.colors;
in {
 config = mkMerge [
   (mkIf cfg.enable {
     catppuccin.enable = true;

     home-manager.users.vonix = {
       imports = [ catppuccin.homeManagerModules.catppuccin ];

       catppuccin.enable                 = true;
       programs.waybar.catppuccin.enable = false;
       gtk.catppuccin.size               = "compact";
     };
   })
 ];
}
