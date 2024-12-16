{ lib
, config
, username
, ...
}:

let
 inherit (builtins)
  toString;

 inherit (lib)
  mkIf mkForce mkMerge;

 cfgFonts  = config.style.fonts;
 cfgCursor = config.style.colors.cursor;
 cfgTheme  = config.style.colors.catppuccin;
in {
 config = mkMerge [
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

   (mkIf cfgCursor.enable {
     home-manager.users."${username}" = {
       home.pointerCursor = {
         x11.enable = true;
         gtk.enable = true;
         inherit (cfgCursor.settings) name;
         inherit (cfgCursor.settings) size;
         inherit (cfgCursor.settings) package;
       };
     };
   })

   (mkIf (cfgFonts.enable && config.foot.enable) {
     home-manager.users."${username}".programs = {
       foot = {
         settings = {
           csd.font  = "${cfgFonts.monospace.name}";
           main.font = "${cfgFonts.monospace.name}:size=16";
         };
       };
     };
   })

   (mkIf (cfgTheme.enable && config.zsh.enable) {
     home-manager.users."${username}".programs = {
       zsh.initExtra = ''
          PROMPT="%F{#${cfgTheme.blue}}%B%n@%m%b %F{#${cfgTheme.red}}%~%f%F{#${cfgTheme.blue}} >%f "
       '';
     };
   })
   
   (mkIf (cfgTheme.enable && config.hyprland.enable) {
     home-manager.users."${username}".wayland.windowManager = {
       hyprland = {
         extraConfig = ''
            plugin {
             hyprbars {
              bar_padding                = 8
              bar_button_padding         = 8
              bar_height                 = 30
              bar_text_size              = 12
              bar_part_of_window         = true
              bar_precedence_over_border = true
              bar_text_font              = "FiraCode Nerd Font"
              col.text                   = rgb(${cfgTheme.text})
              bar_color                  = rgb(${cfgTheme.crust})
  
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
             rounding     = 10;
             shadow.color = "rgb(${cfgTheme.base})";
           };

           general = {
             gaps_out              = 10;
             "col.inactive_border" = "rgb(${cfgTheme.crust})";
             "col.active_border"   = "rgb(${cfgTheme.surface0})";
           };
    
           env = [
             "QT_STYLE_OVERRIDE , breeze-dark"
             "XCURSOR_SIZE      , 24"
             "HYPRCURSOR_SIZE   , 24"
           ];
         };
       };
     };
   })

   (mkIf (cfgTheme.enable && config.bemenu.enable) {
    home-manager.users."${username}" = {
      programs.bemenu.settings = {
         border-radius = 10;
         hf            = "#${cfgTheme.red}";
         hb            = "#${cfgTheme.base}";
         af            = "#${cfgTheme.text}";
         ff            = "#${cfgTheme.text}";
         nf            = "#${cfgTheme.text}";
         ab            = "#${cfgTheme.crust}";
         fb            = "#${cfgTheme.crust}";
         nb            = "#${cfgTheme.crust}";
         bdr           = "#${cfgTheme.surface0}";
       };
     };
   })

   (mkIf (cfgTheme.enable && config.waybar.enable) {
     home-manager.users."${username}" = {
       programs.waybar.style = ''
          * {
              font-size:   20px;
              font-weight: bold; 
              font-family: "JetBrains Mono Nerd Font";
          }
          
          window#waybar {
              border-radius: 10px;
              background:    #${cfgTheme.crust}; 
              border:        1px solid #${cfgTheme.surface0};
          }
          
          tooltip {
              border-radius: 10px;
              background:    #${cfgTheme.crust}; 
              border:        1px solid #${cfgTheme.surface0};
          }
          
          #workspaces {
              padding-right: 5px;
              border-radius: 10px;
              background:    #${cfgTheme.base};
              border:        1px solid #${cfgTheme.surface0};
          }
          
          #workspaces button {
              color: #${cfgTheme.mauve};
          }
          
          #workspaces button.active {
              color: #${cfgTheme.mauve};
          }
          
          #workspaces button:hover {
              border:     none;
              background: none;
              box-shadow: none;
              color:      #${cfgTheme.mauve};
          }
          
          #custom-spacer {
              opacity: 0.0;
          }
          
          #clock {
              color: #${cfgTheme.lavender};
          }
          
          #pulseaudio {
              padding-right: 12px;
              color:         #${cfgTheme.lavender};
          }
          
          #mpris {
              animation-duration:        3s;
              animation-name:            blink;
              animation:                 repeat;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction:       alternate;
              color:                     #${cfgTheme.text};
          }
          
          @keyframes blink {
              to {
                  color: #6c7086;
              }
          }
          
          #network {
              padding-right: 10px;
              color:         #${cfgTheme.lavender};
          }
          
          #pulseaudio-slider slider {
              background: #${cfgTheme.lavender};
          }
          
          #pulseaudio-slider trough {
            min-height:    10px;
            border-radius: 10px;
            min-width:     100px;
            color:         transparent;
            background:    transparent;
          }
          
          #pulseaudio-slider highlight {
            border-radius: 10px;
            color:         transparent;
            background:    #${cfgTheme.lavender};
          }
       '';
     };
   })

   (mkIf (cfgTheme.enable && config.bat.enable) {
     home-manager.users."${username}" = {
       programs.bat.config = {
         style       = "full";
         theme       = "base16";
         color       = "always";
         decorations = "always";
         italic-text = "always";
       };
     };
   })

   (mkIf (cfgTheme.enable && config.freetube.enable) {
     home-manager.users."${username}" = {
       programs.freetube.settings = {
         baseTheme = mkForce "catppuccinMocha";
         mainColor = mkForce "CatppuccinMochaRed";
         secColor  = mkForce "CatppuccinMochaLavender";
       };
     };
   })

   (mkIf (cfgTheme.enable && config.helix.enable) {
     home-manager.users."${username}" = {
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
    
   (mkIf (cfgTheme.enable && config.foot.enable) {
     home-manager.users."${username}".programs = {
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
 ];
}
