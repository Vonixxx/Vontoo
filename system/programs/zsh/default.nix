{ lib
, pkgs
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.zsh.enable) {
   programs.zsh.enable    = true;
   users.defaultUserShell = pkgs.zsh;

   environment = {
     shells = [ pkgs.zsh ];

     systemPackages = with pkgs; [
       gzip
       gnutar
       p7zip
       unar
       unzip
       xz
     ];
   };

   home-manager.users.vonix.programs = {
     starship = {
       enable               = true;
       enableZshIntegration = true;

       settings = {
         git_status.deleted = "";
         add_newline        = false;
         palette            = "catppuccin";

         palettes.catppuccin = {
           red    = "#F38BA8";
           blue   = "#89B4FA";
           green  = "#A6E3A1";
           mauve  = "#CBA6F7";
           yellow = "#F9E2AF";
         };

         os = {
           disabled = false;
           style    = "bold blue";
           symbols  = { NixOS = "󰜗 "; };
         };

         cmd_duration = {
           style  = "bold yellow";
           format = "[$duration]($style) ";
         };

         git_branch = {
           style   = "bold mauve";
           format  = "[$symbol$branch(:$remote_branch)]($style) ";
         };

         format = ''
            [┌](bold mauve)$os$directory$git_branch$git_status$cmd_duration
            [└](bold mauve)$character
         '';

         directory = {
           read_only       = "󰷤";
           read_only_style = "bold red";
           style           = "bold green";
           format          = "[$path]($style) [$read_only]($read_only_style)";
         };
       };
     };

     zsh = {
       enable         = true;
       initExtraFirst = "pfetch";

       shellAliases = {
         ls  = "lsd";
         cat = "bat";
       };

       prezto = {
         enable = true;

         pmodules = [
           "environment"

           "syntax-highlighting"
           "autosuggestions"

           "helper"
           "editor"
           "history"
           "utility"
           "directory"

           "archive"
           "completion"
         ];

         editor = {
           keymap       = "vi";
           dotExpansion = true;
         };
       };
     };
   };
 };
}
