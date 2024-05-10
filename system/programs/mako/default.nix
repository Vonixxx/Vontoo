{ lib
, config
, ...
}: 

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.mako.enable) {
   home-manager.users.vonix.services = {
     mako = {
       borderSize      = 3;
       borderRadius    = 10;
       maxIconSize     = 32;
       enable          = true;
       defaultTimeout  = 10000;
       textColor       = "#CDD6F4";
       borderColor     = "#CBA6F7";
       backgroundColor = "#11111B";
       anchor          = "bottom-right";
       font            = "CascadiaCode 10";
     };
   };
 };
}
