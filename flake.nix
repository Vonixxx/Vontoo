##########
# Vontoo #
########################
# A Flake-based NixOS  #
# System Configuration #
########################
# flake.nix
# │
# ├/users
# │ └<user>
# │
# └/system
#   ├/ui
#   │ ├/gnome
#   │ └/hyprland
#   │
#   ├/configuration
#   │ ├/disk
#   │ ├/model
#   │ ├/general
#   │ ├/options
#   │ └/packages
#   │
#   └/programs
#     ├/bat
#     ├/lsd
#     ├/git
#     ├/zsh
#     ├/foot
#     ├/mako
#     ├/atuin
#     ├/helix
#     ├/bemenu
#     ├/waybar
#     ├/firefox
#     ├/freetube
#     ├/printing
#     └/kdenlive-obs
{
 inputs = {
   ##########################
   # Synchronizing Packages #
   ##########################
   disko.inputs.nixpkgs.follows        = "nixpkgs";
   jovian.inputs.nixpkgs.follows       = "nixpkgs";
   stylix.inputs.nixpkgs.follows       = "nixpkgs";
   arkenfox.inputs.nixpkgs.follows     = "nixpkgs";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   #########################
   # Official Repositories #
   #########################
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   ##########################
   # Community Repositories #
   ##########################
   stylix.url       = "github:danth/stylix";
   disko.url        = "github:nix-community/disko";
   arkenfox.url     = "github:dwarfmaster/arkenfox-nixos";
   home-manager.url = "github:nix-community/home-manager";
   jovian.url       = "github:Jovian-Experiments/Jovian-NixOS";
 };

 outputs = {
   disko
 , jovian
 , stylix
 , nixpkgs
 , arkenfox
 , home-manager
 , ...
 }:

let
 systemModules = [
   ./system
   disko.nixosModules.disko
   stylix.nixosModules.stylix
   arkenfox.hmModules.arkenfox
   home-manager.nixosModules.home-manager
 ];

 mkSystem = name: bool: overlays: extraModules:
   nixpkgs.lib.nixosSystem rec {
     specialArgs = {
       inherit
       pkgs
       jovian
       arkenfox;
     };

     pkgs = import nixpkgs {
       overlays           = [];
       config.allowUnfree = bool;
       system             = "x86_64-linux";
     };

     modules = systemModules ++ [(./users + "${name}")] ++ extraModules;
   };
in {
 nixosConfigurations = {
     f-jarka     = mkSystem ("/f-jarka")               true  []                          [];
     f-libor     = mkSystem ("/f-libor")               true  []                          [];
     u-ofelia    = mkSystem ("/u-ofelia")              true  []                          [];
     f-stepanka  = mkSystem ("/f-stepanka")            true  []                          [];
     v-laptop    = mkSystem ("/v-systems/v-laptop")    true  []                          [];
     v-steamdeck = mkSystem ("/v-systems/v-steamdeck") true  [ jovian.overlays.default ] [ jovian.nixosModules.jovian ];
   };
 };
}
