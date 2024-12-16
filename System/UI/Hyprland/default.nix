{ lib
, pkgs
, config
, keymap
, username
, ...
}:

let
 inherit (lib)
  mkIf;

 terminal     = "foot";
 mod          = "SUPER";
 kill_session = "uwsm stop";
 menu         = "bemenu-run";

 mocha = {
   blue     = "rgb(89b4fa)";
   white    = "rgb(cdd6f4)";
   green    = "rgb(a6e3a1)";
   red      = "rgb(f38ba8)";
   crust    = "rgb(171727)";
   surface0 = "rgb(495068)";
   base     = "rgba(30 , 30 , 46 , 1)";
 };
in {
 config = mkIf config.hyprland.enable {
   programs.hyprland = {
     enable   = true;
     withUWSM = true;
   };
  
   home-manager.users."${username}".wayland.windowManager = {
     hyprland = {
       enable         = true;
       systemd.enable = false;
  
       plugins = with pkgs.hyprlandPlugins; [
         hyprbars        
       ];

       settings = {
         input.kb_layout = keymap;
         monitor         = "HDMI-A-1 , 1920x1080@60 , 0x0 , 1";
  
         master = {
           mfact      = 0.70;
           new_status = "master";
         };
  
         general = {
           resize_on_border = true;
           layout           = "master";
         };
  
         bindm = [
           "${mod} , mouse:272 , movewindow  "
           "${mod} , mouse:273 , resizewindow"
         ];

         bind = [
           "${mod}       , M     , exec            , ${kill_session}"
           "${mod}       , C     , killactive      ,                "
           "${mod}       , D     , exec            , ${menu}        "
           "${mod}       , T     , exec            , ${terminal}    "
           "${mod}       , left  , movefocus       , l              "
           "${mod}       , right , movefocus       , r              "
           "${mod}       , up    , movefocus       , u              "
           "${mod}       , down  , movefocus       , d              "
           "${mod}       , 1     , workspace       , 1              "
           "${mod}       , 2     , workspace       , 2              "
           "${mod}       , 3     , workspace       , 3              "
           "${mod}       , 4     , workspace       , 4              "
           "${mod} SHIFT , 1     , movetoworkspace , 1              "
           "${mod} SHIFT , 2     , movetoworkspace , 2              "
           "${mod} SHIFT , 3     , movetoworkspace , 3              "
           "${mod} SHIFT , 4     , movetoworkspace , 4              "
         ];
  
         exec-once = [
           "waybar"
           "mpvpaper '*' -o \"--loop-file=inf\" /home/luca/Pictures/Moonlake.mp4"
         ];
       };
     };
   };
 };
}
