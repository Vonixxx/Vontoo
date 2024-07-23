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
 config = mkIf (config.zsh.enable) {
   programs.zsh.enable    = true;
   users.defaultUserShell = pkgs.zsh;

   environment = {
     shells = [ pkgs.zsh ];

     systemPackages = with pkgs; [
       gnutar
       pigz
       p7zip
       pbzip2
       unar
       unzip
       xz
     ];
   };

   home-manager.users."${username}".programs = {
     zsh = {
       enable         = true;
       initExtraFirst = "pfetch";

       prezto = {
         enable        = true;
         caseSensitive = false;

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

     starship = {
       enable               = true;
       enableZshIntegration = true;

       settings = {
         add_newline = false;

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
           read_only_style = "bold red";
           style           = "bold green";
           format          = "[$path]($style) [$read_only]($read_only_style)";
         };
       };
     };
   };
 };
}
