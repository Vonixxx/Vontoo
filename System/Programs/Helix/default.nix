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
         cursorline              = true;
         color-modes             = true;
         cursorcolumn            = true;
         soft-wrap.enable        = true;
         lsp.display-inlay-hints = true;
         line-number             = "relative";

         whitespace.render = {
           tab     = "all";
           nbsp    = "all";
           nnbsp   = "all";
         };

         cursor-shape = {
           insert = "bar";
           normal = "block";
           select = "underline";
         };

         statusline = {
           mode = {
             insert = "INSERT";
             normal = "NORMAL";
             select = "SELECT";
           };

           right = [
             "diagnostics"
             "position"
             "total-line-numbers"
           ];
         };
       };

       extraPackages = with pkgs;
                       with nodePackages_latest; [
         bash-language-server
         marksman
         nil
         ols
         taplo
         vscode-langservers-extracted
       ];
     };
   };
 };
}
