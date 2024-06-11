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
 config = mkIf (config.helix.enable) {
   home-manager.users."${username}".programs = {
     helix = {
       enable = true;

       extraPackages = with pkgs;
                       with nodePackages_latest; [
         bash-language-server
         marksman
         nil
       ];

       settings.editor = {
         true-color              = true;
         undercurl               = true;
         whitespace.render.space = "all";
         line-number             = "relative";
       };
     };
   };
 };
}
