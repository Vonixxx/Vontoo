{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.git.enable) {
   home-manager.users."${username}".programs = {
     git.enable                  = true;
     git-credential-oauth.enable = true;
   };
 };
}
