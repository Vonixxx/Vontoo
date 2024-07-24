##########
# Vontoo #
######################################
# NixOS Flake - System Configuration #
######################################

#
# The structure of the configuration is as such:
#

#
# flake.nix
# │
# ├/Users
# │ └/<surname initial>
# │   └<user>
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
#

#
# flake.nix lies at the root of this directory, and
# each / represents a subfolder. Within each subfolder
# lies a default.nix, wherein lies the configuration for
# the given aspect of the system as described in the parent directory.
#
# The `System` and `Users` folders each have a default.nix file at their base,
# they serve the role of importing all the files that lie within the subfolders,
# which then get imported back to flake.nix in order to instantiate the system. The structure
# is arbitrary and its simply meant to provide clarity.
#

#
# User-specific configurations, which can be found in Users/default.nix are done as such:
#

#
# <user> = mkSystem <bool> toggle TLP.
#                   <bool> toggle printing capabilities.
#                   <bool> toggle AMD CPU settings.
#                   <bool> toggle AMD GPU settings.
#                   <bool> toggle Intel CPU settings.
#                   <bool> toggle Intel GPU settings.
#                   <string> keyboard language.
#                   <string> locale settings.
#                   <string> location, used to determine time.
#                   <string> username.
#                   <string> folder location for other user-specific configuration.
#                   <string> password, encoded using `mkpasswd`.
#                   <list> extra modules.
#                   <list> overlays for nixpkgs.
#

#
# These options are provided as such, and not in their respective user folders,
# simply because I deemed it more convenient. These are basic settings each
# user needs to have setup for a functional system. The configuration within the respective
# user directories consists of bookmarks (for FireFox) and highly specific configuration when deemed necessary
# by the given user. For example if someone has accesibility issues, those settings would be toggled in their respective folder.
#
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
 userProfile =
 profile: [
   (./Users + profile)
 ];

 defaultModules =
 extraModules:[
  ./System
  disko.nixosModules.disko
  arkenfox.hmModules.arkenfox
  home-manager.nixosModules.home-manager
  impermanence.nixosModules.impermanence
 ] ++ extraModules;

 mkSystem =
 tlp:
 printing:
 amd_cpu:
 amd_gpu:
 intel_cpu:
 intel_gpu:
 keymap:
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
     tlp
     pkgs
     keymap
     locale
     amd_cpu
     amd_gpu
     arkenfox
     password
     printing
     timezone
     username
     intel_cpu
     intel_gpu
     impermanence;
   };

   pkgs = import nixpkgs {
     config.allowUnfree = true;
     overlays           = extraOverlays;
     system             = "x86_64-linux";
   };

   modules = (userProfile profile)
             ++ (defaultModules extraModules);
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
