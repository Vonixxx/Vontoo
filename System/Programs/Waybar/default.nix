{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 imports = [
   ./bar.nix
   ./style.nix
 ];

 config = mkIf (config.waybar.enable) {
   programs.light.enable      = true;
   environment.systemPackages = [ pkgs.wl-gammarelay-rs ];

   home-manager.users.vonix.programs.waybar.enable = true;
 };
}
