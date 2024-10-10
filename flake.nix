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
   nix-alien.url    = "github:thiagokokada/nix-alien";
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
 , nix-alien
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
     localSystem.system = "x86_64-linux";

     overlays = [ 
      nix-alien.overlays.default
     ] ++ extraOverlays;
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

   homeConfigurations."V_SteamDeck_Foreign" = home-manager.lib.homeManagerConfiguration {
     modules = [
        arkenfox.hmModules.arkenfox
        ./System_Foreign/default.nix
     ];

     pkgs = import nixpkgs {
       config.allowUnfree = true;
       localSystem.system = "x86_64-linux";
     };
   };
 };
}
