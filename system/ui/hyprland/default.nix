{ lib
, config
, ...
}:


let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.hyprland.enable) {
   home-manager.users.vonix.wayland.windowManager = {
     hyprland = {
       enable = true;

       settings = {
         cursor.inactive_timeout = 5;

         decoration = {
           rounding    = 10;
           drop_shadow = false;
         };

         input = {
           scroll_method = "2fg";
           accel_profile = "adaptive";
         };

         general = {
           gaps_in          = 8;
           gaps_out         = 8;
           border_size      = 3;
           resize_on_border = true;
           layout           = "master";
         };

         bindm = [
           "ALT , mouse:272 , movewindow"
         ];

         misc = {
           force_default_wallpaper      = 0;
           disable_autoreload           = true;
           disable_hyprland_logo        = true;
           animate_manual_resizes       = true;
           animate_mouse_windowdragging = true;
         };

         monitor = [
           "HDMI-A-1 , 2560x1440@75 , 0x0    , 1"
           "eDP-1    , 1920x1080@60 , 2560x0 , 1"
         ];

         windowrulev2 = [
           "suppressevent fullscreen , class:(FreeTube)$"
           "float                    , class:(org.gnome.Calculator)$"
         ];

         exec-once = [
           "waybar"
           "wl-gammarelay-rs"
           "mpvpaper -o '--loop' '*' ~/Pictures/Wallpapers/house.gif"
         ];

         bind = [
           "SUPER , C , killactive"
           "SUPER , F , fullscreen"

           "SUPER , 1 , workspace , 1"
           "SUPER , 2 , workspace , 2"
           "SUPER , 3 , workspace , 3"
           "SUPER , 4 , workspace , 4"
           "SUPER , 5 , workspace , 5"

           "SUPER , K , movefocus , u"
           "SUPER , J , movefocus , d"
           "SUPER , H , movefocus , l"
           "SUPER , L , movefocus , r"

           "SUPER , T , exec , foot"
           "SUPER , D , exec , evince"
           "SUPER , B , exec , firefox"
           "SUPER , Y , exec , freetube"
           "SUPER , P , exec , fragments"
           "SUPER , R , exec , bemenu-run"

           "SUPER SHIFT , 1 , movetoworkspace , 1"
           "SUPER SHIFT , 2 , movetoworkspace , 2"
           "SUPER SHIFT , 3 , movetoworkspace , 3"
           "SUPER SHIFT , 4 , movetoworkspace , 4"
           "SUPER SHIFT , 5 , movetoworkspace , 5"

           "            , XF86MonBrightnessUp   , exec , light -A 5"
           "            , XF86MonBrightnessDown , exec , light -U 5"
           "            , XF86AudioLowerVolume  , exec , amixer -q sset Master 5%-"
           "            , XF86AudioRaiseVolume  , exec , amixer -q sset Master 5%+"
           "            , XF86AudioMute         , exec , amixer -q sset Master 100%-"
           "Control_L   , XF86AudioMute         , exec , amixer -q sset Master 100%+"
           "SUPER_SHIFT , S                     , exec , grimblast save area ~/screenshot.png"
           "Shift_L     , XF86MonBrightnessUp   , exec , busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500 && pkill -RTMIN+10 waybar"
           "Shift_L     , XF86MonBrightnessDown , exec , busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 1000 && pkill -RTMIN+10 waybar"
           "Control_L   , XF86MonBrightnessUp   , exec , busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n 200 && pkill -RTMIN+10 waybar"
           "Control_L   , XF86MonBrightnessDown , exec , busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -200 && pkill -RTMIN+10 waybar"
         ];
       };
     };
   };
 };
}
