##########
# Vontoo #
####################################
# NixOS Flake System Configuration #
####################################
# flake.nix
# │
# ├/Users
# │ └<user>
# │
# └/System
#   ├/UI
#   │ ├/Gnome
#   │ └/Hyprland
#   │
#   ├/Configuration
#   │ ├/Disk
#   │ ├/Model
#   │ ├/General
#   │ ├/Packages
#   │ └/Impermanence
#   │
#   └/Programs
#     ├/Bat
#     ├/LSD
#     ├/Git
#     ├/ZSH
#     ├/Foot
#     ├/Atuin
#     ├/Helix
#     ├/Firefox
#     ├/Freetube
#     ├/Printing
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
