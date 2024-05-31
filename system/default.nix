{ ... }:

{
 imports = [
   ./ui/gnome/default.nix
   ./ui/style/default.nix
   ./ui/hyprland/default.nix

   ./.backend/options/fonts.nix
   ./.backend/options/colors.nix
   ./.backend/settings/fonts.nix
   ./.backend/settings/colors.nix
   ./.backend/options/applications.nix

   ./programs/bat/default.nix
   ./programs/git/default.nix
   ./programs/lsd/default.nix
   ./programs/zsh/default.nix
   ./programs/foot/default.nix
   ./programs/mako/default.nix
   ./programs/atuin/default.nix
   ./programs/helix/default.nix
   ./programs/bemenu/default.nix
   ./programs/waybar/default.nix
   ./programs/firefox/default.nix
   ./programs/freetube/default.nix
   ./programs/printing/default.nix
   ./programs/kdenlive-obs/default.nix

   ./configuration/disk/default.nix
   ./configuration/model/default.nix
   ./configuration/general/default.nix
   ./configuration/packages/default.nix
   ./configuration/impermanence/default.nix
 ];
}
