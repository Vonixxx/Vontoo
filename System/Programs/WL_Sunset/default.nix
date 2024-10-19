{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.wlsunset.enable {
   home-manager.users."${username}".services = {
     wlsunset = {
       longitude         = 4.3;
       enable            = true;
       latitude          = 50.8;
       temperature.night = 1000;
     };
   };
 };
}
