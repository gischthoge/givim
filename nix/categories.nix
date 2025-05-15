{ pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
  lspsAndRuntimeDeps = {
    general = with pkgs; [ universal-ctags ripgrep fd ];
    lint = with pkgs; [ ];
    debug = with pkgs; { go = [ delve ]; };
    go = with pkgs; [ gopls gotools go-tools gccgo ];
    format = with pkgs; [ ];
    neonixdev = {
      # also you can do this.
      inherit (pkgs) nix-doc lua-language-server nixd;
      # and each will be its own sub category
    };
  };

  # This is for plugins that will load at startup without using packadd:
  startupPlugins = {
    debug = with pkgs.vimPlugins; [ nvim-nio ];
    general = with pkgs.vimPlugins; {
      always = [ lze lzextras vim-repeat plenary-nvim nvim-notify ];
      extra = [ oil-nvim nvim-web-devicons mini-icons ];
    };
    themer = with pkgs.vimPlugins;
      (builtins.getAttr (categories.colorscheme or "onedark") {
        # Theme switcher without creating a new category
        "onedark" = onedark-nvim;
        "catppuccin" = catppuccin-nvim;
        "catppuccin-mocha" = catppuccin-nvim;
        "tokyonight" = tokyonight-nvim;
        "tokyonight-day" = tokyonight-nvim;
      });
  };

  # not loaded automatically at startup.
  # use with packadd and an autocommand in config to achieve lazy loading
  # or a tool for organizing this like lze or lz.n!
  # to get the name packadd expects, use the
  # `:NixCats pawsible` command to see them all
  optionalPlugins = {
    debug = with pkgs.vimPlugins; {
      default = [ nvim-dap nvim-dap-ui nvim-dap-virtual-text ];
      go = [ nvim-dap-go ];
    };
    lint = with pkgs.vimPlugins; [ nvim-lint ];
    format = with pkgs.vimPlugins; [ conform-nvim ];
    markdown = with pkgs.vimPlugins; [ markdown-preview-nvim ];
    neonixdev = with pkgs.vimPlugins; [ lazydev-nvim ];
    general = {
      blink = with pkgs.vimPlugins; [
        luasnip
        cmp-cmdline
        blink-cmp
        blink-compat
        colorful-menu-nvim
      ];
      treesitter = with pkgs.vimPlugins; [
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        # This is for if you only want some of the grammars
        # (nvim-treesitter.withPlugins (
        #   plugins: with plugins; [
        #     nix
        #     lua
        #   ]
        # ))
      ];
      telescope = with pkgs.vimPlugins; [
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        telescope-nvim
      ];
      always = with pkgs.vimPlugins; [
        nvim-lspconfig
        lualine-nvim
        bufferline-nvim
        gitsigns-nvim
        vim-sleuth
        vim-fugitive
        vim-rhubarb
        nvim-surround
        snacks-nvim
        neo-tree-nvim
      ];
      extra = with pkgs.vimPlugins; [
        fidget-nvim
        # lualine-lsp-progress
        which-key-nvim
        comment-nvim
        undotree
        indent-blankline-nvim
        vim-startuptime
        # If it was included in your flake inputs as plugins-hlargs,
        # this would be how to add that plugin in your config.
        # pkgs.neovimPlugins.hlargs
      ];
    };
  };

  # shared libraries to be added to LD_LIBRARY_PATH
  # variable available to nvim runtime
  sharedLibraries = {
    general = with pkgs;
      [ # <- this would be included if any of the subcategories of general are
        # libgit2
      ];
  };

  # environmentVariables:
  # this section is for environmentVariables that should be available
  # at RUN TIME for plugins. Will be available to path within neovim terminal
  environmentVariables = {
    test = {
      default = { CATTESTVARDEFAULT = "It worked!"; };
      subtest1 = { CATTESTVAR = "It worked!"; };
      subtest2 = { CATTESTVAR3 = "It didn't work!"; };
    };
  };

  # If you know what these are, you can provide custom ones by category here.
  # If you dont, check this link out:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
  extraWrapperArgs = { test = [ ''--set CATTESTVAR2 "It worked again!"'' ]; };

  # lists of the functions you would have passed to
  # python.withPackages or lua.withPackages
  # do not forget to set `hosts.python3.enable` in package settings

  # get the path to this python environment
  # in your lua config via
  # vim.g.python3_host_prog
  # or run from nvim terminal via :!<packagename>-python3
  python3.libraries = { test = (_: [ ]); };
  # populates $LUA_PATH and $LUA_CPATH
  extraLuaPackages = { general = [ (_: [ ]) ]; };

  # see :help nixCats.flake.outputs.categoryDefinitions.default_values
  # this will enable test.default and debug.default
  # if any subcategory of test or debug is enabled
  # WARNING: use of categories argument in this set will cause infinite recursion
  # The categories argument of this function is the FINAL value.
  # You may use it in any of the other sets.
  extraCats = {
    test = [[ "test" "default" ]];
    debug = [[ "debug" "default" ]];
    go = [[ "debug" "go" ] # yes it has to be a list of lists
      ];
  };
}

