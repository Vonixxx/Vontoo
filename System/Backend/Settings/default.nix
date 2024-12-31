{ lib
, pkgs
, config
, username
, ...
}:

let
 inherit (builtins)
  toString;

 inherit (lib)
  mkIf mkMerge;

 cfg       = config;
 cfgStyle  = config.style;
 cfgFonts  = config.style.fonts;
 cfgCursor = config.style.cursor;
 cfgTheme  = config.style.colors;
in {
 config = mkMerge [
   (mkIf cfgCursor.enable {
     home-manager.users.${username} = {
       home.pointerCursor = {
         x11.enable        = true;
         gtk.enable        = true;
         hyprcursor.enable = true;

         inherit (cfgCursor.settings) name;
         inherit (cfgCursor.settings) size;
         inherit (cfgCursor.settings) package;
       };
     };
   })

   (mkIf cfgFonts.enable (mkMerge [
      {
       home-manager.users.${username}.gtk = {
         font = {
           name    = cfgFonts.serif.name;
           package = cfgFonts.serif.package;
           size    = cfgFonts.size.applications;
         };
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
      }

      (mkIf cfg.foot.enable {
        home-manager.users.${username}.programs = {
          foot.settings = {
            csd.font  = cfgFonts.monospace.name;
            main.font = "${cfgFonts.monospace.name}:size=16";
          };
        };
      })
   ]))

   (mkIf cfgTheme.enable (mkMerge [
      {
       home-manager.users.${username}.dconf.settings."org/gnome/desktop/interface" = {
         color-scheme = "prefer-${cfgTheme.gtk}";
       };
      }

      (mkIf cfg.zsh.enable {
        home-manager.users.${username}.programs = {
          zsh.initExtra = ''
             PROMPT="%F{#${cfgTheme.blue}}%B%n@%m%b %F{#${cfgTheme.red}}%~%f%F{#${cfgTheme.blue}} >%f "
          '';
        };
      })

      (mkIf cfg.hyprland.enable {
        home-manager.users.${username}.wayland.windowManager = {
          hyprland = {
            plugins = with pkgs.hyprlandPlugins; [
              hyprbars        
            ];
     
            extraConfig = ''
               plugin {
                hyprbars {
                 bar_padding                = 8
                 bar_button_padding         = 8
                 bar_height                 = 30
                 bar_part_of_window         = true
                 bar_precedence_over_border = true
                 col.text                   = rgb(${cfgTheme.text})
                 bar_color                  = rgb(${cfgTheme.crust})
                 bar_text_size              = ${toString(cfgFonts.size.titleBar)}
                 bar_text_font              = ${cfgFonts.sansSerif.name}:style=Bold
     
                 hyprbars-button = rgb(${cfgTheme.red})   , 20 , 󰖭 , hyprctl dispatch killactive
                 hyprbars-button = rgb(${cfgTheme.green}) , 20 , 󰖯 , hyprctl dispatch fullscreen 1
                 hyprbars-button = rgb(${cfgTheme.blue})  , 20 , 󰖲 , hyprctl dispatch togglefloating
                }
               }
            '';
     
            settings = {
              misc = {
                force_default_wallpaper = 0;
                disable_hyprland_logo   = true;
                animate_manual_resizes  = true;
              };
   
              decoration = {
                blur.enabled = false;
                rounding     = cfgStyle.rounding;
                shadow.color = "rgb(${cfgTheme.base})";
              };
   
              general = {
                gaps_in               = cfgStyle.gaps;
                gaps_out              = cfgStyle.gaps;
                "col.inactive_border" = "rgb(${cfgTheme.crust})";
                border_size           = cfgStyle.border_thickness;
                "col.active_border"   = "rgb(${cfgTheme.surface0})";
              };
            };
          };
        };
      })

      (mkIf cfg.bemenu.enable {
       home-manager.users.${username} = {
         programs.bemenu.settings = {
            border-radius = cfgStyle.rounding;
            hf            = "#${cfgTheme.red}";
            hb            = "#${cfgTheme.base}";
            af            = "#${cfgTheme.text}";
            ff            = "#${cfgTheme.text}";
            nf            = "#${cfgTheme.text}";
            ab            = "#${cfgTheme.crust}";
            fb            = "#${cfgTheme.crust}";
            nb            = "#${cfgTheme.crust}";
            bdr           = "#${cfgTheme.surface0}";
            border        = cfgStyle.border_thickness;
          };
        };
      })

      (mkIf cfg.waybar.enable {
        home-manager.users.${username} = {
          programs.waybar = {
            settings.mainBar = {
              margin-left  = cfgStyle.gaps;
              margin-right = cfgStyle.gaps;
              position     = cfgStyle.bar_position;
   
              margin-top = if (cfgStyle.bar_position != "top")
                                then 0
                                else cfgStyle.gaps;
   
              margin-bottom = if (cfgStyle.bar_position != "bottom")
                                then 0
                                else cfgStyle.gaps;
            };
   
            style = ''
               * {
                   font-weight: bold; 
                   font-family: ${cfgFonts.serif.name};
                   font-size:   ${toString(cfgFonts.size.bar)};
               }
               
               window#waybar {
                   background:    #${cfgTheme.crust}; 
                   border-radius: ${toString(cfgStyle.rounding)}px;
                   border:        ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.surface0};
               }
               
               tooltip {
                   background:    #${cfgTheme.crust}; 
                   border-radius: ${toString(cfgStyle.rounding)}px;
                   border:        ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.surface0};
               }
               
               #workspaces {
                   border-radius: 10px;
                   background:    #${cfgTheme.base};
                   border:        ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.surface0};
               }
               
               #workspaces button {
                   color: #${cfgTheme.mauve};
               }
               
               #workspaces button.active {
                   color:  #${cfgTheme.red};
                   border: ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.red};
               }
               
               #workspaces button:hover {
                   background: none;
                   box-shadow: none;
                   color:      #${cfgTheme.flamingo};
                   border:     ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.flamingo};
               }
               
               #custom-spacer {
                   opacity: 0.0;
               }
               
               #custom-office {
                 padding-right: 5px;
               }
               
               #custom-file_manager {
                   padding-right: 10px;
               }
     
               #custom-youtube {
                   padding-right: 5px;
               }
     
               #custom-video_player {
                   padding-right: 10px;
               }
     
               #custom-image_viewer {
                 padding-right: 5px;
               } 
               
               #custom-printing {
                 padding-right: 8px;
               } 
     
               #custom-calculator {
                   padding-right: 5px;
               }
     
               #custom-web {
                   padding-right: 5px;
               }
     
               #custom-launcher {
                   padding-right: 2px;
               }
               
               #pulseaudio {
                   padding-right: 13px;
               }
     
               #custom-clock {
                   padding-right: 5px;
               }
     
               #network {
                   padding-right: 8px;
               }
               
               #custom-hibernate {
                 color: #${cfgTheme.blue};
               }
     
               #custom-hibernate {
                 padding-right: 5px;
               }
     
               #custom-reboot {
                 padding-right: 5px;
               }
     
               #custom-poweroff {
                 padding-right: 5px;
               }
   
               #custom-terminal {
                 padding-right: 5px;
               }
     
               #custom-reboot {
                 color: #${cfgTheme.yellow};
               }
     
               #custom-poweroff {
                 color: #${cfgTheme.red};
               }
     
               #custom-powermenu {
                 color: #${cfgTheme.red};
               }
     
               #custom-powermenu {
                 padding-right: 3px;
               }
     
               #custom-temperature {
                 padding-right: 4px;
               }
     
               #custom-temperature_warm,
               #custom-temperature_warmest,
               #custom-temperature_standard {
                padding-right: 7px; 
                 
               }
     
               #custom-text_editor {
                 padding-right: 5px;
               }
     
               #clock,
               #network,
               #custom-web,
               #pulseaudio,
               #custom-tray,
               #custom-clock,
               #custom-office,
               #custom-youtube,
               #custom-launcher,
               #custom-calculator,
               #custom-temperature,
               #custom-productivity,
               #custom-system,
               #custom-terminal,
               #custom-leisure,
               #custom-media,
               #custom-file_manager,
               #custom-text_editor,
               #custom-video_player, 
               #custom-image_viewer, 
               #custom-printing, 
               #custom-temperature_warm,
               #custom-temperature_warmest,
               #custom-temperature_standard {
                   color: #${cfgTheme.lavender};
               }
     
               
               #pulseaudio-slider slider {
                   background: #${cfgTheme.lavender};
               }
               
               #pulseaudio-slider trough {
                 min-height:    10px;
                 min-width:     100px;
                 color:         transparent;
                 background:    transparent;
                 border-radius: ${toString(cfgStyle.rounding)}px;
               }
               
               #pulseaudio-slider highlight {
                 color:         transparent;
                 background:    #${cfgTheme.lavender};
                 border-radius: ${toString(cfgStyle.rounding)}px;
               }
            '';
          };
        };
      })

      (mkIf cfg.bat.enable {
        home-manager.users.${username} = {
          programs.bat.config = {
            style       = "full";
            theme       = "base16";
            color       = "always";
            decorations = "always";
            italic-text = "always";
          };
        };
      })

      (mkIf cfg.freetube.enable {
        home-manager.users.${username} = {
          programs.freetube.settings = {
            baseTheme = "catppuccinMocha";
            mainColor = "CatppuccinMochaRed";
            secColor  = "CatppuccinMochaLavender";
          };
        };
      })

      (mkIf cfg.helix.enable {
        home-manager.users.${username} = {
          programs.helix = {
            settings = {
              editor.true-color = true;
              theme             = "catppuccin_mocha";
            };
   
            themes.catppuccin_mocha = {
              inherits = "catppuccin_mocha";
     
              "ui.background"         = {};
              "variable.other.member" = "#${cfgTheme.lavender}";
            };
          };
        };
      })

      (mkIf cfg.foot.enable {
        home-manager.users.${username}.programs = {
          foot.settings.colors = {
            alpha      = 0.9;
            flash      = "${cfgTheme.red}";
            background = "${cfgTheme.crust}";
            foreground = "${cfgTheme.text}";
            bright0    = "${cfgTheme.surface0}";
            bright1    = "${cfgTheme.red}";
            bright2    = "${cfgTheme.green}";
            bright3    = "${cfgTheme.yellow}";
            bright4    = "${cfgTheme.blue}";
            bright5    = "${cfgTheme.pink}";
            bright6    = "${cfgTheme.sky}";
            bright7    = "${cfgTheme.text}";
            regular0   = "${cfgTheme.surface0}";
            regular1   = "${cfgTheme.red}";
            regular2   = "${cfgTheme.green}";
            regular3   = "${cfgTheme.yellow}";
            regular4   = "${cfgTheme.blue}";
            regular5   = "${cfgTheme.pink}";
            regular6   = "${cfgTheme.sky}";
            regular7   = "${cfgTheme.text}";
          };
        };
      })
   ]))
 ];
}
