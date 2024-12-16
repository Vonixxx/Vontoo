{ username
, ...
}:

{
 bat.enable   = true;
 git.enable   = true;
 lsd.enable   = true;
 zsh.enable   = true;
 foot.enable  = true;
 atuin.enable = true;
 helix.enable = true;

 environment.variables = {
   EDITOR  = "hx";
   VISUAL  = "hx";
   PF_INFO = "ascii title uptime pkgs kernel memory os host";
 };

 home-manager.users."${username}" = {
  config
 , ...
 }: {
   programs.git = {
     userName  = "Vonixxx";
     userEmail = "vonixxxwork@tuta.io";
   };
 };
}
