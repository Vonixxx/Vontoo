{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.git.enable) {
   home-manager.users.vonix.programs = {
     git.enable                  = true;
     git-credential-oauth.enable = true;
   };
 };
}
