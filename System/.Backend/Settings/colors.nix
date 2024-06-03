{ lib
, config
, username
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

     home-manager.users."${username}" = {
       catppuccin.enable                 = true;
       programs.waybar.catppuccin.enable = false;

       gtk.catppuccin = {
         size   = "compact";
         tweaks = [ "rimless" ];
       };

       imports = [
         catppuccin.homeManagerModules.catppuccin
       ];
     };
   })
 ];
}
