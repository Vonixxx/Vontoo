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
 system = "x86_64-linux";

 pkgs = import nixpkgs {
   inherit system;
   config.allowUnfree = true;
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
 password:
 extraModules:
 extraUserGroups:
 extraKernelModules:
 extraKernelParameters:
 userPackages:
 userConfiguration:
 nixpkgs.lib.nixosSystem rec {
   inherit system;

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
     latest_kernel
     extraUserGroups
     userConfiguration
     extraKernelModules
     extraKernelParameters;
   };

   modules = [
     ./System
     disko.nixosModules.disko
     home-manager.nixosModules.home-manager
   ] ++ extraModules;
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
