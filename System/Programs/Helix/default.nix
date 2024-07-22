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

       settings.editor = {
         undercurl               = true;
         whitespace.render.space = "all";
         line-number             = "relative";
       };

       extraPackages = with pkgs;
                       with nodePackages_latest; [
         bash-language-server
         marksman
         nil
       ];
     };
   };
 };
}
