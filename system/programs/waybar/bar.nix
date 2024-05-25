{ ... }:

{
 home-manager.users.vonix.programs = {
   waybar.settings = [{
      height   = 50;
      layer    = "top";
      position = "top";

      modules-right = [
        "disk"
        "network"
        "clock"
      ];

      modules-center = [
        "hyprland/workspaces"
      ];

      modules-left = [
        "custom/power"
        "custom/reboot"
        "custom/sleep"
        "battery"
        "backlight"
        "custom/nightlight"
        "pulseaudio"
      ];

      "hyprland/workspaces" = {
        all-outputs = true;
        format      = "{icon}";

        persistent-workspaces = {
          "*" = [
            1
            2
            3
            4
            5
          ];
        };

        format-icons = {
          "1" = "<big>󰬺</big>";
          "2" = "<big>󰬻</big>";
          "3" = "<big>󰬼</big>";
          "4" = "<big>󰬽</big>";
          "5" = "<big>󰬾</big>";
        };
      };

      "pulseaudio" = {
        tooltip  = false;
        format   = "{icon}";
        on-click = "foot pulsemixer";

        format-icons = {
          headphone = "";
          default = [
            ""
            ""
            ""
            ""
          ];
        };
      };

      "backlight" = {
        tooltip = false;
        format  = "<big>{icon}</big>";

        format-icons = [
          "󰃞"
          "󰃟"
          "󰃠"
        ];
      };

      "custom/reboot" = {
        tooltip  = false;
        format   = "<big>󰜉</big>";
        on-click = "systemctl reboot";
      };

      "custom/sleep" = {
        tooltip  = false;
        format   = "<big>󰜗</big>";
        on-click = "systemctl suspend";
      };

      "custom/power" = {
        tooltip  = false;
        format   = "<big>󰤆</big>";
        on-click = "systemctl poweroff";
      };

      "disk" = {
        path     = "/";
        interval = 6000;
        tooltip  = false;
        format   = "<big>󰋊</big> [{percentage_used}%]";
      };

      "clock" = {
        interval = 60;
        tooltip  = false;
        on-click = "gnome-calendar";
        format   = "<big>󰃭</big> [{:%d/%m/%y - %H:%M}]";
      };

      "network" = {
        tooltip             = false;
        on-click            = "foot nmtui connect";
        format-wifi         = "<big>󰣺</big> [{essid}]";
        format-ethernet     = "<big>󱤚</big> [{essid}]";
        format-disconnected = "<big>󰣼</big> [Disconnected]";
      };

      "battery" = {
        interval                   = 30;
        bat                        = "BAT0";
        format-charging            = "<big>󰂄</big>";
        format                     = "<big>{icon}</big>";
        tooltip-format-charging    = "Full Charge: {time}";
        tooltip-format-discharging = "Full Discharge: {time}";

        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };

      "custom/nightlight" = {
        signal      = 10;
        tooltip     = false;
        return-type = "json";
        format      = "<big>{icon}</big>";

        format-icons = [
          ""
          ""
          ""
        ];

        exec = "
          temperature=$(timeout 0.01 wl-gammarelay-rs watch {t})
          result=$(( (temperature - 1000) * 100 / 9000 ))
          echo '{\"percentage\":'\${result}'}'
        ";
      };
   }];
 };
}
