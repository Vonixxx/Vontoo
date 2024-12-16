##########
# Vontoo #
######################################
# NixOS Flake - System Configuration #
######################################
{
 inputs = {
   ##########################
   # Synchronizing Packages #
   ##########################
   home-manager.inputs.nixpkgs.follows = "nixpkgs";
   #########################
   # Official Repositories #
   #########################
   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   ##########################
   # Community Repositories #
   ##########################
   disko.url        = "github:nix-community/disko";
   home-manager.url = "github:nix-community/home-manager";
   mailserver.url   = "gitlab:simple-nixos-mailserver/nixos-mailserver";
 };

 outputs = {
   disko
 , nixpkgs
 , mailserver
 , home-manager
 , ...
 }:

let
 pkgs = import nixpkgs {
   config.allowUnfree = true;
   localSystem.system = "x86_64-linux";
 };

 mkSystem =
 tlp:
 printing:
 latest_kernel:
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
 userPackages:
 nixpkgs.lib.nixosSystem rec {
   system = "x86_64-linux";

   specialArgs = {
     inherit
     tlp
     pkgs
     keymap
     locale
     amd_cpu
     amd_gpu
     password
     printing
     timezone
     username
     intel_cpu
     intel_gpu
     userPackages
     extraOverlays
     latest_kernel;
   };

   pkgs = import nixpkgs {
     config.allowUnfree = true;
     overlays           = extraOverlays;
     localSystem.system = "x86_64-linux";
   };

   modules = (if profile == null
     then [
      ./System
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
     ] ++ extraModules
     else [
       ./System
       (./Users + profile)
       disko.nixosModules.disko
       home-manager.nixosModules.home-manager
     ] ++ extraModules
   );
 };
in {
   nixosConfigurations = (
     import ./Users {
      inherit
       pkgs
       mkSystem
       mailserver;
     }
   );
 };
}
