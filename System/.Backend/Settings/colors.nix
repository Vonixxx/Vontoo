{ lib
, config
, username
, catppuccin
, ...
}:

let
 inherit (lib)
  mkIf mkForce mkMerge;

 cfg = config.style.colors;
in {
 config = mkMerge [
   (mkIf cfg.enable {
     catppuccin.enable = true;

     home-manager.users."${username}" = {
       imports = [
         catppuccin.homeManagerModules.catppuccin
       ];

       catppuccin.enable = true;

       gtk.catppuccin = {
         size   = "compact";
         tweaks = [ "rimless" ];
       };

       dconf.settings = {
         "org/gnome/shell/extensions/user-theme".name = "Catppuccin-Mocha-Compact-Mauve-Dark";

         "org/gnome/desktop/interface" = {
           icon-theme   = "Papirus-Dark";
           gtk-theme    = "Catppuccin-Mocha-Compact-Mauve-Dark";
           cursor-theme = mkForce "catppuccin-mocha-mauve-cursors";
         };
       };
     };
   })
 ];
}
