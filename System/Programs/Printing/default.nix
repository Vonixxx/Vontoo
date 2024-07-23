{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.printing.enable) {
   services = {
     saned.enable   = true;
     ipp-usb.enable = true;

     avahi = {
       enable   = true;
       nssmdns4 = true;
       openFirewall = true;
     };

     printing = {
       enable          = true;
       browsing        = true;
       openFirewall    = true;
       defaultShared   = true;
       startWhenNeeded = false;

       drivers = with pkgs; [
         hplip
         gutenprint
         gutenprintBin
       ];
     };
   };

   hardware.sane = {
     enable          = true;
     openFirewall    = true;
     brscan4.enable  = true;
     brscan5.enable  = true;
     dsseries.enable = true;

     disabledDefaultBackends = [
       "escl"
     ];

     extraBackends = with pkgs; [
       sane-airscan
       sane-backends
     ];
   };

   users.users."${username}".extraGroups = [
     "lp"
     "scanner"
   ];
 };
}
