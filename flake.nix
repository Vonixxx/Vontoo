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

   argumentsCLI = {
     flake = false;
     url   = "file+file:///dev/null";
   };
 };

 outputs = {
   disko
 , nixpkgs
 , mailserver
 , argumentsCLI
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
 latestKernel:
 keymap:
 locale:
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
     password
     printing
     username
     argumentsCLI
     latestKernel
     userPackages
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
