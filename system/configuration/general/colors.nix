{ lib
, config
, catppuccin
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.style.colors.enable {
   catppuccin.enable = true;

   home-manager.users.vonix = {
     imports = [ catppuccin.homeManagerModules.catppuccin ];

     catppuccin.enable                 = true;
     programs.waybar.catppuccin.enable = false;
   };
 };
}
