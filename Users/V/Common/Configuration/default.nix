{ pkgs
, username
, ...
}:

{
 bat.enable   = true;
 git.enable   = true;
 lsd.enable   = true;
 zsh.enable   = true;
 foot.enable  = true;
 bemenu.enable  = true;
 atuin.enable = true;
 helix.enable = true;

 environment.variables = {
   EDITOR  = "hx";
   VISUAL  = "hx";
   PF_INFO = "ascii title uptime pkgs kernel memory os host";
 };

 home-manager.users."${username}" = {
   qt = {
     enable = true;

     style = {
       name    = "breeze-dark";
       package = with pkgs; [
         # libsForQt5.breeze-qt5
         # libsForQt5.breeze-icons
         kdePackages.breeze
         kdePackages.breeze-icons
       ];
     };
   };

   programs.git = {
     userName  = "Vonixxx";
     userEmail = "vonixxxwork@tuta.io";
   };
 };
}
