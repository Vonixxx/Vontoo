{ lib
, pkgs
, config
, printing
, username
, ...
}:

let
 inherit (lib)
  mkIf
  mkMerge;

 inherit (builtins)
  toString;

 cfg       = config;
 cfgEnable = cfg.enable;
 cfgFonts  = cfg.style.fonts;
 cfgCursor = cfg.style.cursor;
 cfgColors = cfg.style.colors;
 cfgStyle  = cfg.style.general;
in {
 config =
 mkMerge [
   (mkIf cfgEnable.colors {
     boot.plymouth.theme = "catppuccin-mocha";
   })

   (mkIf cfgEnable.fonts {
     console = {
       font = "solar24x32";

       colors = [
         cfgColors.crust
         cfgColors.red
         cfgColors.green
         cfgColors.yellow
         cfgColors.blue
         cfgColors.mauve
         cfgColors.teal
         cfgColors.text
         cfgColors.crust
         cfgColors.red
         cfgColors.green
         cfgColors.yellow
         cfgColors.blue
         cfgColors.mauve
         cfgColors.teal
         cfgColors.lavender
       ];
     };

     fonts = {
       packages = [
         cfgFonts.emoji.package
         cfgFonts.serif.package
         cfgFonts.monospace.package
         cfgFonts.sansSerif.package
       ];

       fontconfig = {
         allowBitmaps  = false;
         subpixel.rgba = "rgb";
         hinting.style = "full";

         defaultFonts = {
           emoji = [
             cfgFonts.emoji.name
           ];

           serif = [
             cfgFonts.serif.name
           ];

           sansSerif = [
             cfgFonts.sansSerif.name
           ];

           monospace = [
             cfgFonts.monospace.name
           ];
         };
       };
     };
   })

   {
    home-manager.users.${username} =
    mkMerge [
     (mkIf cfgEnable.cursor {
        home.pointerCursor = {
          x11.enable        = true;
          gtk.enable        = true;
          hyprcursor.enable = true;
 
          inherit (cfgCursor) name;
          inherit (cfgCursor) size;
          inherit (cfgCursor) package;
        };
      })

      (mkIf cfgEnable.fonts (mkMerge [
         {
          gtk.font = {
            name    = cfgFonts.serif.name;
            package = cfgFonts.serif.package;
            size    = cfgFonts.size.applications;
          };
         }
 
         (mkIf cfgEnable.foot {
           programs.foot.settings = {
             csd.font  = cfgFonts.monospace.name;
             main.font = "${cfgFonts.monospace.name}:size=16";
           };
         })
      ]))

      (mkIf (cfgStyle.wallpaper == null) {
        services.wpaperd = {
          enable = true;
        
          settings.default = {
            duration = "10m";
            mode     = "center";
            path     = "${pkgs.kdePackages.plasma-workspace-wallpapers}/";
          };
        };
      }) 

      (mkIf cfgEnable.colors (mkMerge [
         {
          dconf.settings."org/gnome/desktop/interface" = {
            color-scheme = "prefer-${cfgColors.gtk}";
          };
         }
 
         (mkIf cfgEnable.zsh {
           programs.zsh.initExtra = ''
              PROMPT="%F{#${cfgColors.blue}}%B%n@%m%b %F{#${cfgColors.red}}%~%f%F{#${cfgColors.blue}} >%f "
           '';
         })

         (mkIf cfgEnable.bemenu {
           programs.bemenu.settings = {
             border-radius = cfgStyle.rounding;
             hf            = "#${cfgColors.red}";
             hb            = "#${cfgColors.base}";
             af            = "#${cfgColors.text}";
             ff            = "#${cfgColors.text}";
             nf            = "#${cfgColors.text}";
             ab            = "#${cfgColors.crust}";
             fb            = "#${cfgColors.crust}";
             nb            = "#${cfgColors.crust}";
             bdr           = "#${cfgColors.surface0}";
             border        = cfgStyle.borderThickness;
           };
         })

         (mkIf cfgEnable.hyprland {
           wayland.windowManager.hyprland = {
             plugins =
             with pkgs.hyprlandPlugins; [
               hyprbars        
             ];
      
             settings = {
               monitor = ", preferred , auto , ${toString(cfgStyle.scale)}";

               misc = {
                 force_default_wallpaper = 0;
                 disable_hyprland_logo   = true;
                 animate_manual_resizes  = true;
               };
    
               decoration = {
                 blur.enabled = false;
                 rounding     = cfgStyle.rounding;
                 shadow.color = "rgb(${cfgColors.base})";
               };
    
               general = {
                 gaps_in               = cfgStyle.gaps;
                 gaps_out              = cfgStyle.gaps;
                 "col.inactive_border" = "rgb(${cfgColors.crust})";
                 border_size           = cfgStyle.borderThickness;
                 "col.active_border"   = "rgb(${cfgColors.surface0})";
               };
   
               exec-once = mkMerge [
                 [
                  "waybar"
                  "systemctl start tzupdate"
                 ]

                 (mkIf (cfgStyle.wallpaper != null) [
                   "mpvpaper '*' -o \"--loop-file=inf\" ${cfgStyle.wallpaper}"
                 ])
               ];
             };
 
             extraConfig = ''
                plugin {
                 hyprbars {
                  bar_padding                = 8
                  bar_button_padding         = 8
                  bar_height                 = 30
                  bar_part_of_window         = true
                  bar_precedence_over_border = true
                  col.text                   = rgb(${cfgColors.text})
                  bar_color                  = rgb(${cfgColors.crust})
                  bar_text_size              = ${toString(cfgFonts.size.titleBar)}
                  bar_text_font              = ${cfgFonts.sansSerif.name}:style=Bold
      
                  hyprbars-button = rgb(${cfgColors.red})   , 20 , 󰖭 , hyprctl dispatch killactive     , rgb(${cfgColors.text})
                  hyprbars-button = rgb(${cfgColors.green}) , 20 , 󰖯 , hyprctl dispatch fullscreen 1   , rgb(${cfgColors.text})
                  hyprbars-button = rgb(${cfgColors.blue})  , 20 , 󰖲 , hyprctl dispatch togglefloating , rgb(${cfgColors.text})
                 }
                }
             '';
           };
         })

         (mkIf cfgEnable.bat {
           programs.bat.config = {
             style       = "full";
             theme       = "base16";
             color       = "always";
             decorations = "always";
             italic-text = "always";
           };
         })

         (mkIf cfgEnable.freetube {
           programs.freetube.settings = {
             baseTheme = "catppuccinMocha";
             mainColor = "CatppuccinMochaRed";
             secColor  = "CatppuccinMochaLavender";
           };
         })

         (mkIf cfgEnable.helix {
           programs.helix = {
             settings = {
               editor.true-color = true;
               theme             = "catppuccin_mocha";
             };
    
             themes.catppuccin_mocha = {
               inherits = "catppuccin_mocha";
      
               "ui.background"         = {};
               "variable.other.member" = "#${cfgColors.lavender}";
             };
           };
         })

         (mkIf cfgEnable.foot {
           programs.foot.settings.colors = {
             alpha = 0.9;
             flash = "${cfgColors.red}";

             foreground = "${cfgColors.text}";
             background = "${cfgColors.crust}";

             bright0 = "${cfgColors.surface0}";
             bright1 = "${cfgColors.red}";
             bright2 = "${cfgColors.green}";
             bright3 = "${cfgColors.yellow}";
             bright4 = "${cfgColors.blue}";
             bright5 = "${cfgColors.pink}";
             bright6 = "${cfgColors.sky}";
             bright7 = "${cfgColors.text}";

             regular0 = "${cfgColors.surface0}";
             regular1 = "${cfgColors.red}";
             regular2 = "${cfgColors.green}";
             regular3 = "${cfgColors.yellow}";
             regular4 = "${cfgColors.blue}";
             regular5 = "${cfgColors.pink}";
             regular6 = "${cfgColors.sky}";
             regular7 = "${cfgColors.text}";
           };
         })

         (mkIf cfgEnable.waybar {
           programs.waybar = {
             settings.mainBar = {
               margin-left  = cfgStyle.gaps;
               margin-right = cfgStyle.gaps;
               position     = cfgStyle.barPosition;
    
               margin-top = if (cfgStyle.barPosition != "top")
                                 then 0
                                 else cfgStyle.gaps;
    
               margin-bottom = if (cfgStyle.barPosition != "bottom")
                                 then 0
                                 else cfgStyle.gaps;
             };
    
             style = mkMerge [
               ''
                 * {
                     font-weight: bold; 
                     font-family: ${cfgFonts.serif.name};
                     font-size:   ${toString(cfgFonts.size.bar)};
                 }
                  
                 window#waybar {
                     background:    #${cfgColors.crust}; 
                     border-radius: ${toString(cfgStyle.rounding)}px;
                     border:        ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.surface0};
                 }
                 
                 #custom-spacer {
                     opacity: 0.0;
                 }
 
                 #custom-powermenu {
                   padding-right: 3px;
                 }
       
                 #custom-temperature {
                   padding-right: 4px;
                 }
       
                 #custom-launcher {
                     padding-right: 2px;
                 }
 
                 #network,
                 #custom-printing {
                     padding-right: 8px;
                 } 
                 
                 #custom-pdf,
                 #custom-web,
                 #custom-clock,
                 #custom-reboot,
                 #custom-office,
                 #custom-youtube,
                 #custom-poweroff,
                 #custom-terminal,
                 #custom-hibernate,
                 #custom-calculator,
                 #custom-text_editor,
                 #custom-image_viewer {
                     padding-right: 5px;
                 }
                 
                 #pulseaudio {
                     padding-right: 13px;
                 }
 
                 #custom-file_manager {
                     padding-right: 5px;
                 }
                 #custom-video_player {
                     padding-right: 10px;
                 }
                 
                 #custom-temperature_warm,
                 #custom-temperature_warmest,
                 #custom-temperature_standard {
                     padding-right: 7px; 
                 }
                 
                 tooltip {
                     color:         #${cfgColors.text};
                     background:    #${cfgColors.crust}; 
                     border-radius: ${toString(cfgStyle.rounding)}px;
                     border:        ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.surface0};
                 }
                 
                 #workspaces {
                     border-radius: 10px;
                     background:    #${cfgColors.base};
                     border:        ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.surface0};
                 }
  
                 #workspaces button {
                     color: #${cfgColors.mauve};
                 }
 
                 #workspaces button.urgent {
                     color:  #${cfgColors.red};
                     border: ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.red};
                 }
                 
                 #workspaces button.active {
                     color:  #${cfgColors.peach};
                     border: ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.peach};
                 }
                 
                 #workspaces button:hover {
                     background: none;
                     box-shadow: none;
                     color:      #${cfgColors.peach};
                     border:     ${toString(cfgStyle.borderThickness)}px solid #${cfgColors.peach};
                 }
  
                 #custom-poweroff {
                     color: #${cfgColors.red};
                 }
       
                 #custom-hibernate {
                     color: #${cfgColors.blue};
                 }
       
                 #custom-media,
                 #custom-system,
                 #custom-leisure,
                 #custom-powermenu,
                 #custom-productivity {
                     color: #${cfgColors.peach};
                 }
 
                 #custom-reboot { 
                     color: #${cfgColors.yellow};
                 }
       
                 #clock,
                 #custom-temperature_warm,
                 #custom-temperature_warmest,
                 #custom-temperature_standard {
                     color: #${cfgColors.flamingo};
                 }
       
                 #network,
                 #custom-pdf,
                 #custom-web,
                 #pulseaudio,
                 #custom-tray,
                 #custom-clock,
                 #custom-office,
                 #custom-youtube,
                 #custom-launcher,
                 #custom-printing, 
                 #custom-terminal,
                 #custom-calculator,
                 #custom-temperature,
                 #custom-text_editor,
                 #custom-file_manager,
                 #custom-image_viewer, 
                 #custom-video_player { 
                     color: #${cfgColors.lavender};
                 }
       
                 #pulseaudio-slider trough {
                     background: transparent;
                 }
 
                 #pulseaudio-slider slider {
                     background: #${cfgColors.flamingo};
                 }
                 
                 #pulseaudio-slider highlight {
                     background: #${cfgColors.flamingo};
                 }
 
                 #pulseaudio-slider {
                     min-height:    10px;
                     min-width:     100px;
                     border-radius: ${toString(cfgStyle.rounding)}px;
                 }
               ''

               (mkIf cfgEnable.laptop ''
                  #backlight { 
                      color: #${cfgColors.lavender};
                  }

                  #backlight-slider trough {
                      background: transparent;
                  }
  
                  #backlight-slider slider {
                      background: #${cfgColors.flamingo};
                  }
                  
                  #backlight-slider highlight {
                      background: #${cfgColors.flamingo};
                  }
  
                  #backlight-slider {
                      min-height:    10px;
                      min-width:     100px;
                      border-radius: ${toString(cfgStyle.rounding)}px;
                  }
               '')
             ];
           };
         })
      ]))
    ];
   }
 ];
}
