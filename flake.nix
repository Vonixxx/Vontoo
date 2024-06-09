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
 userModules = profile: [
   (./Users + "${profile}")
 ];
 
 systemModules = [
   ./System
   disko.nixosModules.disko
   arkenfox.hmModules.arkenfox
   catppuccin.nixosModules.catppuccin
   home-manager.nixosModules.home-manager
   impermanence.nixosModules.impermanence
 ];

 language = keymap:
            locale:
            timezone: [
   ({ config, ...}: {
     i18n.defaultLocale          = "${locale}";
     services.xserver.xkb.layout = "${keymap}";
     time.timeZone               = "${timezone}";
   })
 ];

 userConfiguration = username:
                     password: [
   ({ config, ...}: {
     users.users = {
       root.initialHashedPassword = "${password}";

       "${username}" = {
         uid                   = 1000;
         isNormalUser          = true;
         name                  = "${username}";
         initialHashedPassword = "${password}";
         home                  = "/home/" + "${username}";
         extraGroups           = [ "audio" "video" "wheel" "networkmanager" ];
       };
     };
   })
 ];

 mkSystem = keymap:
            locale:
            timezone:
            username:
            profile:
            password:
            extraModules:
            extraOverlays:
   nixpkgs.lib.nixosSystem rec {
     specialArgs = {
       inherit
       pkgs
       arkenfox
       username
       catppuccin
       impermanence;
     };

     pkgs = import nixpkgs {
       config.allowUnfree = true;
       overlays           = extraOverlays;
       system             = "x86_64-linux";
     };

     modules = extraModules
               ++ systemModules
               ++ (userModules profile)
               ++ (language keymap locale timezone)
               ++ (userConfiguration username password);
   };
in {
   nixosConfigurations = (
     import ./Users {
      inherit
       jovian
       mkSystem;
     }
   );
 };
}
