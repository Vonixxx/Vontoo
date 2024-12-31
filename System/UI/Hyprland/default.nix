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

 mod          = "SUPER";
 terminal     = "footclient";
 kill_session = "loginctl terminate-user \"\"";
 wallpaper    = "/home/luca/Pictures/Chill.mp4";
 menu         = "source /home/luca/.nix-profile/etc/profile.d/hm-session-vars.sh && bemenu-run";
in {
 config = mkIf config.hyprland.enable {
   programs.hyprland = {
     enable   = true;
     withUWSM = true;
   };

   xdg.portal.extraPortals = with pkgs; [
     xdg-desktop-portal-gtk
   ];
  
   home-manager.users."${username}".wayland.windowManager = {
     hyprland = {
       enable         = true;
       systemd.enable = false;
  
       settings = {
         input.kb_layout = keymap;
         monitor         = ", preferred , auto , 1";

         master = {
           mfact      = 0.70;
           new_status = "master";
         };
  
         bindm = [
           "${mod} , mouse:272 , movewindow  "
           "${mod} , mouse:273 , resizewindow"
         ];

         exec-once = [
           "waybar"
           "mpvpaper '*' -o \"--loop-file=inf\" ${wallpaper}"
         ];

         windowrulev2 = [
           "float, class:org.gnome.Calculator, title:Calculator"
         ];
  
         general = {
           extend_border_grab_area = 30;
           resize_on_border        = true;
           layout                  = "master";
         };
  
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
       };
     };
   };
 };
}
