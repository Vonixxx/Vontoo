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
   arkenfox.inputs.nixpkgs.follows     = "nixpkgs";
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   #########################
   # Official Repositories #
   #########################
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   ##########################
   # Community Repositories #
   ##########################
   catppuccin.url   = "github:catppuccin/nix";
   disko.url        = "github:nix-community/disko";
   arkenfox.url     = "github:dwarfmaster/arkenfox-nixos";
   home-manager.url = "github:nix-community/home-manager";
   impermanence.url = "github:nix-community/impermanence";
   jovian.url       = "github:Jovian-Experiments/Jovian-NixOS";
 };

 outputs = {
   disko
 , jovian
 , nixpkgs
 , arkenfox
 , catppuccin
 , home-manager
 , impermanence
 , ...
 }:

let
 systemModules = [
   ./system
   disko.nixosModules.disko
   arkenfox.hmModules.arkenfox
   catppuccin.nixosModules.catppuccin
   home-manager.nixosModules.home-manager
   impermanence.nixosModules.impermanence
 ];

 mkSystem = name: bool: extraOverlays: extraModules:
   nixpkgs.lib.nixosSystem rec {
     specialArgs = {
       inherit
       pkgs
       arkenfox
       catppuccin
       impermanence;
     };

     pkgs = import nixpkgs {
       config.allowUnfree = bool;
       overlays           = extraOverlays;
       system             = "x86_64-linux";
     };

     modules = systemModules ++ [(./users + "${name}")] ++ extraModules;
   };
in {
 nixosConfigurations = {
     Jarka       = mkSystem ("/f-jarka")               true  []                          [];
     Libor       = mkSystem ("/f-libor")               true  []                          [];
     Ofelia      = mkSystem ("/u-ofelia")              true  []                          [];
     Stepanka    = mkSystem ("/f-stepanka")            true  []                          [];
     V-Lenovo    = mkSystem ("/v-systems/v-laptop")    false []                          [];
     V-SteamDeck = mkSystem ("/v-systems/v-steamdeck") true  [ jovian.overlays.default ] [ jovian.nixosModules.jovian ];
   };
 };
}
