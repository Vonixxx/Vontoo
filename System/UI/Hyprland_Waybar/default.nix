{ lib
, pkgs
, config
, keymap
, username
, ...
}:

let
 cfg = config;

 inherit (lib)
  mkIf mkMerge;

 mod          = "SUPER";
 cfgStyle     = cfg.style;
 terminal     = "footclient";
 kill_session = "loginctl terminate-user \"\"";
 menu         = "source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh && bemenu-run";
in {
 config =
 mkMerge [ 
   (mkIf cfg.hyprland.enable {
     programs.hyprland = {
       enable   = true;
       withUWSM = true;
     };
  
     xdg.portal.extraPortals = with pkgs; [
       xdg-desktop-portal-gtk
     ];
   })

   {
    home-manager.users.${username} =
    mkMerge [
      (mkIf cfg.waybar.enable {
        programs.waybar = {
          enable = true;
     
          settings = {
            mainBar = {
              layer = "top";
     
              modules-left = [
                "custom/spacer"
                "group/poweroptions"
                "custom/spacer"
                "custom/spacer"
                "network"
                "custom/spacer"
                "group/clock"
                "custom/spacer"
                "group/temperature"
                "custom/spacer"
                "group/audio"
              ];
     
              modules-center = [
                "hyprland/workspaces"
              ];
     
              modules-right = [
                "group/shortcuts"
                "custom/spacer"
                "custom/launcher"
                "custom/spacer"
              ];
     
              "custom/spacer" = {
                format  = "|";
                tooltip = false;
              };
   
              "custom/launcher" = {
                tooltip  = false;
                format   = "<big>󰻀</big>";
                on-click = "source /home/luca/.nix-profile/etc/profile.d/hm-session-vars.sh && bemenu-run";
              };
   
              "custom/terminal" = {
                tooltip  = false;
                on-click = "footclient";
                format   = "<big>󰆍</big>";
              };
   
              "custom/poweroff" = {
                tooltip  = false;
                format   = "<big>󰤆</big>";
                on-click = "systemctl poweroff";
              };
   
              "custom/reboot" = {
                tooltip  = false;
                format   = "<big>󰜉</big>";
                on-click = "systemctl reboot";
              };
   
              "custom/hibernate" = {
                tooltip  = false;
                format   = "<big>󰜗</big>";
                on-click = "systemctl sleep";
              };
   
              "custom/powermenu" = {
                tooltip = false;
                format  = "<big>󰐦</big>";
              };
   
              "custom/file_manager" = {
                tooltip  = false;
                on-click = "nautilus";
                format   = "<big>󰉋</big>";
              };
         
              "custom/youtube" = {
                tooltip  = false;
                on-click = "freetube";
                format   = "<big>󰗃</big>";
              };
   
              "custom/text_editor" = {
                tooltip  = false;
                format   = "<big>󱩼</big>";
                on-click = "gnome-text-editor";
              };
   
              "custom/video_player" = {
                tooltip  = false;
                on-click = "celluloid";
                format   = "<big>󰿎</big>";
              };
   
              "custom/image_viewer" = {
                tooltip  = false;
                on-click = "eog";
                format   = "<big>󰋩</big>";
              };
   
              "custom/printing" = {
                tooltip  = false;
                format   = "<big>󰐪</big>";
                on-click = "system-config-printer";
              };
   
              "custom/calculator" = {
                tooltip  = false;
                format   = "<big>󰪚</big>";
                on-click = "gnome-calculator";
              };
   
              "custom/office" = {
                tooltip  = false;
                on-click = "libreoffice";
                format   = "<big>󰈬</big>";
              };
   
              "custom/web" = {
                tooltip  = false;
                on-click = "brave";
                format   = "<big>󰖟</big>";
              };
   
              "custom/tray" = {
                tooltip  = false;
                format   = "<big>󰅁</big>";
              };
   
              "hyprland/workspaces" = {
                format = "{icon}";
          
                persistent-workspaces = {
                  "1" = [];
                  "2" = [];
                  "3" = [];
                  "4" = [];
                };
   
                format-icons = {
                  "1"     = "1";
                  "2"     = "2";
                  "3"     = "3";
                  "4"     = "4";
                };
              };
   
              clock = {
                format         = "{:%H:%M}";
                tooltip-format = "<tt>{calendar}</tt>";
   
                actions = {
                  on-click-right = "mode";
                  on-scroll-up   = "shift_up";
                  on-scroll-down = "shift_down";
                };
   
                calendar = {
                  mode-mon-col   = 3;
                  on-click-right = "mode";
          
                  format = {
                    days     = "<span color='#cdd6f4'><b>{}</b></span>";
                    today    = "<span color='#f38ba8'><b>{}</b></span>";
                    months   = "<span color='#f9e2af'><b>{}</b></span>";
                    weekdays = "<span color='#fab387'><b>{}</b></span>";
                  };
                };
              };
   
              "custom/clock" = {
                tooltip = false;
                format  = "<big>󱑃</big>";
              };
   
              "custom/productivity" = {
                tooltip = false;
                format  = "Productivity";
              };
   
              "custom/leisure" = {
                tooltip = false;
                format  = "Leisure";
              };
   
              "custom/media" = {
                tooltip = false;
                format  = "Media";
              };
   
              "custom/system" = {
                tooltip = false;
                format  = "System";
              };
   
              "group/media" = {
                orientation = "horizontal";
   
                modules = [
                  "custom/media"
                  "custom/video_player"
                  "custom/spacer"
                  "custom/image_viewer"
                  "custom/spacer"
                ];
   
                drawer = {
                  click-to-reveal          = true;
                  transition-left-to-right = false;
                };
              };
   
              "group/system" = {
                orientation = "horizontal";
   
                modules = [
                  "custom/system"
                  "custom/file_manager"
                  "custom/spacer"
                  "custom/printing"
                  "custom/spacer"
                  "custom/terminal"
                  "custom/spacer"
                ];
   
                drawer = {
                  click-to-reveal          = true;
                  transition-left-to-right = false;
                };
              };
   
              "group/productivity" = {
                orientation = "horizontal";
   
                modules = [
                  "custom/productivity"
                  "custom/web"
                  "custom/spacer"
                  "custom/text_editor"
                  "custom/spacer"
                  "custom/calculator"
                  "custom/spacer"
                  "custom/office"
                  "custom/spacer"
                ];
   
                drawer = {
                  click-to-reveal          = true;
                  transition-left-to-right = false;
                };
              };
   
              "group/leisure" = {
                orientation = "horizontal";
   
                modules = [
                  "custom/leisure"
                  "custom/youtube"
                  "custom/spacer"
                ];
   
                drawer = {
                  click-to-reveal          = true;
                  transition-left-to-right = false;
                };
              };
        
              "group/shortcuts" = {
                orientation = "horizontal";
   
                modules = [
                  "custom/tray"
                  "group/media"
                  "custom/spacer"
                  "group/system"
                  "custom/spacer"
                  "group/leisure"
                  "custom/spacer"
                  "group/productivity"
                  "custom/spacer"
                ];
   
                drawer = {
                  click-to-reveal          = true;
                  transition-left-to-right = false;
                };
              };
   
              "group/audio" = {
                drawer.click-to-reveal = false;
                orientation            = "horizontal";
          
                modules = [
                  "pulseaudio"
                  "pulseaudio/slider"
                ];
              };
   
              "custom/temperature" = {
                tooltip = false;
                format  = "<big>󱩌</big>";
              };
   
              "custom/temperature_warmest" = {
                tooltip  = false;
                format   = "<big>󰃞</big>";
                on-click = "hyprsunset -t 1000";
              };
   
              "custom/temperature_warm" = {
                tooltip  = false;
                format   = "<big>󰃟</big>";
                on-click = "hyprsunset -t 3000";
              };
   
              "custom/temperature_standard" = {
                tooltip  = false;
                format   = "<big>󰃠</big>";
                on-click = "hyprsunset -t 6500";
              };
   
              "group/temperature" = {
                drawer.click-to-reveal = false;
                orientation            = "horizontal";
          
                modules = [
                  "custom/temperature"
                  "custom/spacer"
                  "custom/temperature_warmest"
                  "custom/spacer"
                  "custom/temperature_warm"
                  "custom/spacer"
                  "custom/temperature_standard"
                ];
              };
     
              "group/clock" = {
                drawer.click-to-reveal = false;
                orientation            = "horizontal";
          
                modules = [
                  "custom/clock"
                  "custom/spacer"
                  "clock"
                ];
              };
   
              "group/poweroptions" = {
                drawer.click-to-reveal = false;
                orientation            = "horizontal";
          
                modules = [
                  "custom/powermenu"
                  "custom/spacer"
                  "custom/poweroff"
                  "custom/spacer"
                  "custom/hibernate"
                  "custom/spacer"
                  "custom/reboot"
                ];
              };
   
              network = {
                interval                    = 600;
                format-disconnected         = "󰤩";
                tooltip                     = true;
                on-click                    = "foot impala";
                tooltip-format-disconnected = "Disconnected";
                format                      = "<big>{icon}</big>";
                tooltip-format              = "Network: <b>{essid}</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>";
          
                format-icons = [
                  "󰤟"
                  "󰤢"
                  "󰤥"
                  "󰤨"
                ];
              };
     
              pulseaudio = {
                scroll-step    = 5;
                format-muted   = "󰖁";
                format         = "<big>{icon}</big>";
                tooltip-format = "{desc} | {volume}%";
          
                format-icons = {
                  default = [
                    ""
                    ""
                    ""
                  ];
                };
              };
     
              "pulseaudio/slider" = {
                min         = 0;
                scroll-step = 1;
                max         = 100;
                device      = "pulseaudio";
              };
            };
          };
        };
      })

      (mkIf cfg.hyprland.enable {
        wayland.windowManager.hyprland = {
          enable         = true;
          systemd.enable = false;
     
          settings = {
            input.kb_layout = keymap;
   
            master = {
              mfact      = 0.70;
              new_status = "master";
            };
     
            bindm = [
              "${mod} , mouse:272 , movewindow  "
              "${mod} , mouse:273 , resizewindow"
            ];
     
            general = {
              extend_border_grab_area = 30;
              resize_on_border        = true;
              layout                  = "master";
            };
   
            windowrulev2 = [
              "float , class:org.gnome.Calculator , title:Calculator"
            ];
     
            bindr = [ "${mod}       , S     , exec            , pkill waybar"];
            bindo = [ "${mod}       , S     , exec            , waybar"];
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
              "mpvpaper '*' -o \"--loop-file=inf\" ${cfgStyle.wallpaper}"
            ];
          };
        };
      })
    ];
   }
 ];
}
