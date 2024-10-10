{ _ }:

{
 programs.starship = {
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
}
