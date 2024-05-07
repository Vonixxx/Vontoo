{ ... }:

{
 home-manager.users.vonix.programs = {
   waybar.style = ''
      /* Colors */
      @define-color red      rgba(243,139,168,1);
      @define-color blue     rgba(137,180,250,1);
      @define-color teal     rgba(148,226,213,1);
      @define-color crust    rgba(17 ,17 ,27 ,1);
      @define-color green    rgba(166,227,161,1);
      @define-color mauve    rgba(203,166,247,1);
      @define-color peach    rgba(250,179,135,1);
      @define-color white    rgba(205,214,244,1);
      @define-color yellow   rgba(249,226,175,1);
      @define-color lavender rgba(180,190,254,1);


      /* Modules */
      #disk,
      #clock,
      #battery,
      #network,
      #backlight,
      #pulseaudio,
      #custom-power,
      #custom-sleep,
      #custom-reboot,
      #custom-nightlight {
       padding: 0px 12px;
      }


      /* Base */
      * {
       padding:       0px;
       min-height:    0px;
       border-radius: 0px;
       border:        none;
       margin:        1px 1px 1px 1px;
      }


      /* Whole Bar */
      #waybar {
       background: rgba(0,0,0,0);
      }

      .modules-right {
       font-size:     20px;
       font-weight:   bold;
       border-radius: 50px;
       background:    @crust;
       font-family:   CascadiaCode;
       border:        3px solid @mauve;
      }

      .modules-left {
       font-size:     20px;
       font-weight:   bold;
       border-radius: 50px;
       background:    @crust;
       font-family:   CascadiaCode;
       border:        3px solid @mauve;
      }

      .modules-center {
       font-size:     20px;
       font-weight:   bold;
       border-radius: 50px;
       background:    @crust;
       font-family:   CascadiaCode;
       border:        3px solid @mauve;
      }


      /* Icon Color */
      #custom-power      { color: @red;      }
      #custom-sleep      { color: @blue;     }
      #battery           { color: @green;    }
      #pulseaudio        { color: @mauve;    }
      #backlight         { color: @peach;    }
      #disk              { color: @white;    }
      #clock             { color: @white;    }
      #network           { color: @white;    }
      #custom-reboot     { color: @yellow;   }
      #custom-nightlight { color: @lavender; }


      /* Icon Position */
      #backlight         { margin-right: -4px;  }
      #pulseaudio        { margin-right: 10px;  }
      #custom-sleep      { margin-right: 10px;  }
      #custom-nightlight { margin-right: -8px;  }
      #disk              { margin-right: -10px; }
      #battery           { margin-right: -12px; }
      #network           { margin-right: -10px; }


      /* Workspaces */
      #workspaces button {
       margin-left:  15px;
       margin-right: 15px;
       color:        @white;
      }

      #workspaces button.urgent {
       color:         @red;
       border-bottom: 3px solid @red;
      }

      #workspaces button.active {
       color:         @teal;
       border-bottom: 3px solid @teal;
      }
   '';
 };
}
