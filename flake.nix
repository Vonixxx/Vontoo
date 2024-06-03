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

 mkSystem = user: username: extraModules: extraOverlays:
   nixpkgs.lib.nixosSystem rec {
     users.users.${username}.name = username;

     specialArgs = {
       inherit
       pkgs
       arkenfox
       catppuccin
       impermanence;
     };

     pkgs = import nixpkgs {
       config.allowUnfree = true;
       overlays           = extraOverlays;
       system             = "x86_64-linux";
     };

     modules = systemModules ++ [(./users + "${user}")] ++ extraModules;
   };
in {
 nixosConfigurations = {
     U_Ofelia = mkSystem ("/U/Ofelia") "Ofelia" [] [];

     F_Jarka    = mkSystem ("/F/Jarka")    "Jarka"   [] [];
     F_Libor    = mkSystem ("/F/Libor")    "Libor"   [] [];
     F_Stepanka = mkSystem ("/F/Stepanka") "Bubinka" [] [];

     V_Lenovo    = mkSystem ("/V/Lenovo")    "Luca" []                             [];
     V_SteamDeck = mkSystem ("/V/SteamDeck") "Luca" [ jovian.nixosModules.jovian ] [ jovian.overlays.default ];
   };
 };
}
