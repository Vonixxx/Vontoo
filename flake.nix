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
   # nixpkgs.url = "/home/Luca/GitHub/nixpkgs";
   ##########################
   # Community Repositories #
   ##########################
   disko.url        = "github:nix-community/disko";
   arkenfox.url     = "github:dwarfmaster/arkenfox-nixos";
   home-manager.url = "github:nix-community/home-manager";
   jovian.url       = "github:Jovian-Experiments/Jovian-NixOS";
   mailserver.url   = "gitlab:simple-nixos-mailserver/nixos-mailserver";
 };

 outputs = {
   disko
 , jovian
 , nixpkgs
 , arkenfox
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
     arkenfox
     password
     printing
     timezone
     username
     intel_cpu
     intel_gpu
     userPackages
     extraOverlays;
   };

   pkgs = import nixpkgs {
     config.allowUnfree = true;
     overlays           = extraOverlays;
     localSystem.system = "x86_64-linux";
   };

   modules = [
    (./Users + profile)
   ] ++ [
    ./System
    disko.nixosModules.disko
    arkenfox.hmModules.arkenfox
    home-manager.nixosModules.home-manager
   ] ++ extraModules;
 };
in {
   nixosConfigurations = (
     import ./Users {
      inherit
       pkgs
       jovian
       mkSystem
       mailserver;
     }
   );
 };
}
