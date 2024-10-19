{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;

 transparent = { };
 lavender    = "#b4befe";
in {
 config = mkIf config.helix.enable {
   home-manager.users."${username}".programs = {
     helix = {
       enable = true;

       themes.catppuccin_mocha = {
         inherits = "catppuccin_mocha";

         "variable.other.member" = lavender;
         "ui.background"         = transparent;
       };

       settings.editor = {
         color-modes             = true;
         cursorcolumn            = true;
         soft-wrap.enable        = true;
         lsp.display-inlay-hints = true;
         line-number             = "relative";

         whitespace.render = {
           tab   = "all";
           nbsp  = "all";
           nnbsp = "all";
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
     };
   };
 };
}
