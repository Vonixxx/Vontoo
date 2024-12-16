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
 config = mkIf config.zsh.enable {
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
       enable = true;

       initExtraFirst = ''
          if uwsm check may-start && uwsm select; then
            exec systemd-cat -t uwsm_start uwsm start default
          fi

          pfetch
       '';

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
   };
 };
}
