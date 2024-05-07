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
       defaultTimeout  = 100;
       enable          = true;
       textColor       = "#CDD6F4";
       borderColor     = "#CBA6F7";
       backgroundColor = "#11111B";
       anchor          = "bottom-right";
       font            = "CascadiaCode 10";
     };
   };
 };
}
