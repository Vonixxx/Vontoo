{ ... }:

{
 programs.foot = {
   enable        = true;
   server.enable = true;

   settings = {
     csd.font  = "FiraSans-Regular";
     main.font = "FiraMono-Regular:size=16";
  
     colors = {
       bright0   = "7f849c";
       bright1   = "f38ba8";
       bright2   = "a6e3a1";
       bright3   = "f9e2af";
       bright4   = "89b4fa";
       bright5   = "cba6f7";
       bright6   = "89dceb";
       bright7   = "cdd6f4";

       flash      = "94e2d5";
       background = "1e1e2e";
       foreground = "cdd6f4";
       
       regular0   = "7f849c";
       regular1   = "f38ba8";
       regular2   = "a6e3a1";
       regular3   = "f9e2af";
       regular4   = "89b4fa";
       regular5   = "cba6f7";
       regular6   = "89dceb";
       regular7   = "cdd6f4";
     };
   };
 };
}
