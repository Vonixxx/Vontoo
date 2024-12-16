{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.foot.enable {
   home-manager.users."${username}".programs = {
     foot = {
       enable        = true;
       server.enable = true;
     };
   };
 };
}
