{pkgs, ...}: {
  plugins.nvim-tree = {
    enable = true;
    openOnSetup = true;
    autoClose = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>NvimTreeToggle<CR>";
      options.desc = "Toggle file tree";
    }
    {
      mode = "n";
      key = "<leader>tg";
      action = "<cmd>NvimTreeFindFile<CR>";
      options.desc = "Show current file in tree";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>NvimTreeFocus<CR>";
      options.desc = "Focus tree";
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = "<cmd>NvimTreeRefresh<CR>";
      options.desc = "Refresh tree";
    }
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvim-web-devicons
  ];
}
