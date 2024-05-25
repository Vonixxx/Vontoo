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
       borderSize     = 3;
       borderRadius   = 10;
       enable         = true;
       defaultTimeout = 10000;
       anchor         = "bottom-right";
     };
   };
 };
}
