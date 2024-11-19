{config, ...}: let
  colors = import ../../colors/${config.theme}.nix {};
in {
  plugins.lualine = {
    enable = true;
    settings = {
      globalstatus = true;
      disabledFiletypes = {
        statusline = ["dashboard" "alpha" "starter"];
      };
      theme = {
        normal = {
          a = {
            bg = "#b4befe";
            fg = "#1c1d21";
          };
          b = {
            bg = "nil";
          };
          c = {
            bg = "nil";
          };
          z = {
            bg = "nil";
          };
          y = {
            bg = "nil";
          };
        };
      };
      sections = {
        lualine_a = [
          ''
            {'mode'},''
        ];
        lualine_b = [
          ''
            { 'branch', icon = , diff,}.''
        ];
        lualine_c = [
          ''
            "diagnostic",
            extraConfig = {
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = "󰝶 ";
              },
            },
          ''
        ];
        lualine_x = [
          ''
            "filetype",
            extraConfig = {
              icon_only = true,
            },
          ''
        ];


                lualine_y = [
                  ''
                    "filename"
                    extraConfig = {
                      symbols = {
                        modified = "",
                        readonly = "",
                        unnamed = "",
                      },
                    },
                    separator.left = "",
                  ''
                ];
                lualine_z = [
                    "location"
                ];
      };
    };
  };
}
