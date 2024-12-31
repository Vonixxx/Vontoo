{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf mkMerge;
in {
 config = mkMerge [
   (mkIf (config.atuin.enable && config.zsh.enable) {
     home-manager.users."${username}".programs = {
       atuin.enableZshIntegration = true;
     };
   })

   (mkIf config.zsh.enable {
     programs.zsh.enable    = true;
     users.defaultUserShell = pkgs.zsh;
  
     environment = {
       shells = [
         pkgs.zsh
       ];
  
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
            if uwsm check may-start; then
              exec uwsm start hyprland-uwsm.desktop
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
   })
 ];
}
