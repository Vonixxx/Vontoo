{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.helix.enable) {
   home-manager.users.vonix.programs = {
     helix = {
       enable = true;

       extraPackages = with pkgs; [
         haskell-language-server
         marksman
         nil
       ];

       settings = {
#         theme = "catppuccin_mocha";

         editor = {
           true-color              = true;
           undercurl               = true;
           whitespace.render.space = "all";
           line-number             = "relative";
         };
       };
     };
   };
 };
}
