{ lib
, pkgs
, config
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

       extraConfig = ''
          plugin {
           hyprbars {
            bar_padding                = 8
            bar_button_padding         = 8
            bar_height                 = 30
            bar_text_size              = 12
            bar_part_of_window         = true
            bar_precedence_over_border = true
            col.text                   = ${mocha.white}
            bar_color                  = ${mocha.crust}
            bar_text_font              = "FiraCode Nerd Font"

            hyprbars-button = ${mocha.red}   , 20 , 󰅘 , hyprctl dispatch killactive
            hyprbars-button = ${mocha.green} , 20 , 󰖯 , hyprctl dispatch fullscreen 1
           }
          }
       '';

       settings = {
         monitor = "HDMI-A-1 , 1920x1080@60 , 0x0 , 1";
  
         input = {
           sensitivity  = 0;
           follow_mouse = 1;
           kb_layout    = "us";
         };
  
         dwindle = {
           pseudotile     = true;
           preserve_split = true;
         };
  
         master = {
           new_status = "master";
         };
  
         misc = {
           force_default_wallpaper = -1;
           disable_hyprland_logo   = true;
         };

         bindm = [
           "${mod} , mouse:272 , movewindow  "
           "${mod} , mouse:273 , resizewindow"
         ];

         general = {
           border_size           = 1;
           gaps_in               = 10;
           gaps_out              = 10;
           allow_tearing         = true;
           resize_on_border      = true;
           layout                = "dwindle";
           "col.inactive_border" = "${mocha.crust}";
           "col.active_border"   = "${mocha.surface0}";
         };
  
         decoration = {
           rounding         = 10;
           active_opacity   = 1.0;
           inactive_opacity = 1.0;
         
           blur = {
             size     = 3;
             passes   = 1;
             enabled  = true;
             vibrancy = 0.1696;
           };
         
           shadow = {
             range        = 3;
             render_power = 3;
             enabled      = true;
             color        = "${mocha.base}";
           };
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
  
         exec-once = [
           "waybar"
           "mpvpaper '*' -o \"--loop-file=inf\" /home/luca/Pictures/Moonlake.mp4"
         ];
  
         env = [
           "XCURSOR_SIZE    , 24"
           "HYPRCURSOR_SIZE , 24"
           "BEMENU_OPTS     ,-c -l 5 -W 0.15 -p \"\" -B 1 --fb \"#11111bff\" --nb \"#11111bff\" --hb \"#11111bff\" --fbb \"#11111bff\" --sb \"#11111bff\" --ab \"#11111bff\""
         ];
       };
     };
   };
 };
}
