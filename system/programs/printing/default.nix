{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.printing.enable) {
   hardware.sane = {
     enable                  = true;
     openFirewall            = true;
     brscan4.enable          = true;
     brscan5.enable          = true;
     dsseries.enable         = true;
     disabledDefaultBackends = [ "escl" ];

     extraBackends = with pkgs; [
       epkowa
       hplipWithPlugin
       sane-airscan
       utsushi
     ];
   };

   services = {
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
         brlaser
         brgenml1lpr
         brgenml1cupswrapper
         gutenprint
         gutenprintBin
         hplip
         postscript-lexmark
       ];
     };
   };
 };
}
