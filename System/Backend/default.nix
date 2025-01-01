{ lib
, pkgs
, config
, amd_cpu
, amd_gpu
, printing
, username
, intel_cpu
, intel_gpu
, ...
}:

let
 inherit (builtins)
  toString;

 inherit (lib)
  mkIf mkMerge mkOption;

 inherit (lib.types)
  str bool ints listOf package submodule;

 fontType = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };
   };
 };

 cursorSettings = submodule {
   options = {
     name = mkOption {
       type = str;
     };

     package = mkOption {
       type = package;
     };

     size = mkOption {
       type = ints.unsigned;
     };
   };
 };

 cfg       = config;
 cfgStyle  = config.style;
 cfgFonts  = config.style.fonts;
 cfgCursor = config.style.cursor;
 cfgTheme  = config.style.colors;
in {
 options = {
   bat.enable = mkOption {
     type    = bool;
     default = false;
   };

   git.enable = mkOption {
     type    = bool;
     default = false;
   };

   lsd.enable = mkOption {
     type    = bool;
     default = false;
   };

   zsh.enable = mkOption {
     type    = bool;
     default = false;
   };

   foot.enable = mkOption {
     type    = bool;
     default = true;
   };

   atuin.enable = mkOption {
     type    = bool;
     default = false;
   };

   helix.enable = mkOption {
     type    = bool;
     default = false;
   };

   amd_cpu.enable = mkOption {
     type    = bool;
     default = amd_cpu;
   };

   amd_gpu.enable = mkOption {
     type    = bool;
     default = amd_gpu;
   };

   freetube.enable = mkOption {
     type    = bool;
     default = true;
   };

   bemenu.enable = mkOption {
     type    = bool;
     default = true;
   };

   hyprland.enable = mkOption {
     type    = bool;
     default = true;
   };

   waybar.enable = mkOption {
     type    = bool;
     default = config.hyprland.enable;
   };

   printing.enable = mkOption {
     type    = bool;
     default = printing;
   };

   intel_cpu.enable = mkOption {
     type    = bool;
     default = intel_cpu;
   };

   intel_gpu.enable = mkOption {
     type    = bool;
     default = intel_gpu;
   };

   general_configuration.enable = mkOption {
     type    = bool;
     default = true;
   };

   style = {
     gaps = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     scale = mkOption {
       default = 1;
       type    = ints.unsigned;
     };

     rounding = mkOption {
       default = 10;
       type    = ints.unsigned;
     };

     bar_position = mkOption {
       type    = str;
       default = "top";
     };

     border_thickness = mkOption {
       default = 1;
       type    = ints.unsigned;
     };

     colors = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       gtk = mkOption {
         type    = str;
         default = "dark";
       };

       base = mkOption { 
         type    = str;
         default = "1e1e2e";
       };
      
       text = mkOption { 
         type    = str;
         default = "cdd6f4";
       };
      
       mauve = mkOption { 
         type    = str;
         default = "cba6f7";
       };
      
       surface0 = mkOption { 
         type    = str;
         default = "313244";
       };
      
       crust = mkOption { 
         type    = str;
         default = "11111b";
       };
      
       red = mkOption { 
         type    = str;
         default = "f38ba8";
       };

       flamingo = mkOption { 
         type    = str;
         default = "f2cdcd";
       };

       peach = mkOption { 
         type    = str;
         default = "fab387";
       };
      
       green = mkOption { 
         type    = str;
         default = "a6e3a1";
       };
      
       yellow = mkOption { 
         type    = str;
         default = "f9e2af";
       };
      
       blue = mkOption { 
         type    = str;
         default = "89b4fa";
       };
      
       pink = mkOption { 
         type    = str;
         default = "f5c2ef";
       };
      
       sky = mkOption { 
         type    = str;
         default = "89dceb";
       };
      
       lavender = mkOption { 
         type    = str;
         default = "b4befe";
       };
     };


     cursor = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       settings = mkOption {
         type = cursorSettings;

         default = {
           size    = 32;
           name    = "Bibata-Modern-Ice";
           package = pkgs.bibata-cursors;
         };
       };
     };

     fonts = {
       enable = mkOption {
         type    = bool;
         default = true;
       };

       packages = mkOption {
         type = listOf package;
       };

       size = {
         terminal = mkOption {
           default = 16;
           type    = ints.unsigned;
         };

         applications = mkOption {
           default = 12;
           type    = ints.unsigned;
         };

         titleBar = mkOption {
           default = 14;
           type    = ints.unsigned;
         };

         bar = mkOption {
           default = 20;
           type    = ints.unsigned;
         };
       };

       serif = mkOption {
         type = fontType;

         default = {
           name    = "FiraCode Nerd Font";
           package = pkgs.nerd-fonts.fira-code;
         };
       };

       sansSerif = mkOption {
         type = fontType;

         default = {
           name    = "BitstromWera Nerd Font";
           package = pkgs.nerd-fonts.bitstream-vera-sans-mono;
         };
       };

       monospace = mkOption {
         type = fontType;

         default = {
           name    = "Hack Nerd Font Propo";
           package = pkgs.nerd-fonts.hack;
         };
       };

       emoji = mkOption {
         type = fontType;

         default = {
           name    = "Noto Color Emoji";
           package = pkgs.noto-fonts-color-emoji;
         };
       };
     };
   };
 };

 config =
 mkMerge [
   (mkIf cfgFonts.enable {
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
     (mkIf cfgCursor.enable {
        home.pointerCursor = {
          x11.enable        = true;
          gtk.enable        = true;
          hyprcursor.enable = true;
 
          inherit (cfgCursor.settings) name;
          inherit (cfgCursor.settings) size;
          inherit (cfgCursor.settings) package;
        };
      })

      (mkIf cfgFonts.enable (mkMerge [
         {
          gtk.font = {
            name    = cfgFonts.serif.name;
            package = cfgFonts.serif.package;
            size    = cfgFonts.size.applications;
          };
         }
 
         (mkIf cfg.foot.enable {
           programs.foot.settings = {
             csd.font  = cfgFonts.monospace.name;
             main.font = "${cfgFonts.monospace.name}:size=16";
           };
         })
      ]))

      (mkIf cfgTheme.enable (mkMerge [
         {
          dconf.settings."org/gnome/desktop/interface" = {
            color-scheme = "prefer-${cfgTheme.gtk}";
          };
         }
 
         (mkIf cfg.zsh.enable {
           programs.zsh.initExtra = ''
              PROMPT="%F{#${cfgTheme.blue}}%B%n@%m%b %F{#${cfgTheme.red}}%~%f%F{#${cfgTheme.blue}} >%f "
           '';
         })

         (mkIf cfg.bemenu.enable {
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
         })

         (mkIf cfg.hyprland.enable {
           wayland.windowManager.hyprland = {
             plugins =
             with pkgs.hyprlandPlugins; [
               hyprbars        
             ];
      
             settings.monitor = ''
                ,preferred
                ,auto
                ,${toString(cfgStyle.scale)}
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
           };
         })

         (mkIf cfg.bat.enable {
           programs.bat.config = {
             style       = "full";
             theme       = "base16";
             color       = "always";
             decorations = "always";
             italic-text = "always";
           };
         })

         (mkIf cfg.freetube.enable {
           programs.freetube.settings = {
             baseTheme = "catppuccinMocha";
             mainColor = "CatppuccinMochaRed";
             secColor  = "CatppuccinMochaLavender";
           };
         })

         (mkIf cfg.helix.enable {
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
         })

         (mkIf cfg.foot.enable {
           programs.foot.settings.colors = {
             alpha = 0.9;
             flash = "${cfgTheme.red}";

             foreground = "${cfgTheme.text}";
             background = "${cfgTheme.crust}";

             bright0 = "${cfgTheme.surface0}";
             bright1 = "${cfgTheme.red}";
             bright2 = "${cfgTheme.green}";
             bright3 = "${cfgTheme.yellow}";
             bright4 = "${cfgTheme.blue}";
             bright5 = "${cfgTheme.pink}";
             bright6 = "${cfgTheme.sky}";
             bright7 = "${cfgTheme.text}";

             regular0 = "${cfgTheme.surface0}";
             regular1 = "${cfgTheme.red}";
             regular2 = "${cfgTheme.green}";
             regular3 = "${cfgTheme.yellow}";
             regular4 = "${cfgTheme.blue}";
             regular5 = "${cfgTheme.pink}";
             regular6 = "${cfgTheme.sky}";
             regular7 = "${cfgTheme.text}";
           };
         })

         (mkIf cfg.waybar.enable {
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

                #custom-file_manager,
                #custom-video_player {
                    padding-right: 10px;
                }
                
                #custom-temperature_warm,
                #custom-temperature_warmest,
                #custom-temperature_standard {
                    padding-right: 7px; 
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

                #workspaces button.urgent {
                    color:  #${cfgTheme.red};
                    border: ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.red};
                }
                
                #workspaces button.active {
                    color:  #${cfgTheme.peach};
                    border: ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.peach};
                }
                
                #workspaces button:hover {
                    background: none;
                    box-shadow: none;
                    color:      #${cfgTheme.peach};
                    border:     ${toString(cfgStyle.border_thickness)}px solid #${cfgTheme.peach};
                }
 
                #custom-poweroff {
                    color: #${cfgTheme.red};
                }
      
                #custom-hibernate {
                    color: #${cfgTheme.blue};
                }
      
                #custom-media,
                #custom-system,
                #custom-leisure,
                #custom-powermenu,
                #custom-productivity {
                    color: #${cfgTheme.peach};
                }

                #custom-reboot { 
                    color: #${cfgTheme.yellow};
                }
      
                #clock,
                #custom-temperature_warm,
                #custom-temperature_warmest,
                #custom-temperature_standard {
                    color: #${cfgTheme.flamingo};
                }
      
                #network,
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
                    color: #${cfgTheme.lavender};
                }
      
                #pulseaudio-slider trough {
                    background: transparent;
                }

                #pulseaudio-slider slider {
                    background: #${cfgTheme.flamingo};
                }
                
                #pulseaudio-slider highlight {
                    background: #${cfgTheme.flamingo};
                }

                #pulseaudio-slider {
                    min-height:    10px;
                    min-width:     100px;
                    border-radius: ${toString(cfgStyle.rounding)}px;
                }
             '';
           };
         })
      ]))
    ];
   }
 ];
}
