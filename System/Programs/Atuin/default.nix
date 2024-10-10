{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.atuin.enable {
   home-manager.users."${username}".programs = {
     atuin = {
       enable               = true;
       enableZshIntegration = true;

       settings = {
         inline_height = 10;
         update_check  = false;
         style         = "compact";
         keymap_mode   = "vim-normal";
       };
     };
   };
 };
}
