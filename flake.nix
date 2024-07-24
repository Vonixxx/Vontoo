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
