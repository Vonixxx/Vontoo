{ ... }:

{
 programs.zsh = {
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

   initExtra = ''
      export PATH="$PATH:/home/broombear/Repositories/Odin:/home/broombear/Repositories/Seek:/home/broombear/Repositories/DWL/build"

      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec slstatus -s | dwl -s "wlr-randr --output \"eDP-1\" --off"
      fi
   '';

   shellAliases = {
     ls      = "lsd";
     cat     = "bat";
     man     = "batman";
     grep    = "batgrep";
     search  = "dnf search";
     remove  = "sudo dnf remove";
     install = "sudo dnf install";
     update  = "sudo dnf update rpmfusion-nonfree-release rpmfusion-free-release fedora-repos nobara-repos --refresh && sudo dnf distro-sync --refresh && sudo dnf update --refresh";
   };
 };
}
