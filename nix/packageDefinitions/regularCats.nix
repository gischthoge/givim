{ pkgs, utils, ... }@misc: {
  settings = {
    suffix-path = true;
    suffix-LD = true;
    # IMPURE PACKAGE: normal config reload
    # include same categories as main config,
    # will load from vim.fn.stdpath('config')
    wrapRc = false;
    # or tell it some other place to load
    # unwrappedCfgPath = "/some/path/to/your/config";

    # configDirName: will now look for nixCats-nvim within .config and .local and others
    # this can be changed so that you can choose which ones share data folders for auths
    # :h $NVIM_APPNAME
    configDirName = "nixCats-nvim";

    aliases = [ "testCat" ];

    # If you wanted nightly, uncomment this, and the flake input.
    # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    # Probably add the cache stuff they recommend too.
  };
  categories = {
    markdown = true;
    general = true;
    neonixdev = true;
    lint = true;
    format = true;
    test = true;
    # go = true; # <- disabled but you could enable it with override or module on install
    lspDebugMode = false;
    themer = true;
    colorscheme = "catppuccin";
  };
  extra = {
    # nixCats.extra("path.to.val") will perform vim.tbl_get(nixCats.extra, "path" "to" "val")
    # this is different from the main nixCats("path.to.cat") in that
    # the main nixCats("path.to.cat") will report true if `path.to = true`
    # even though path.to.cat would be an indexing error in that case.
    # this is to mimic the concept of "subcategories" but may get in the way of just fetching values.
    nixdExtras = {
      nixpkgs = "import ${pkgs.path} {}";
      # or inherit nixpkgs;
    };
    # yes even tortured inputs work.
    theBestCat = "says meow!!";
    theWorstCat = {
      thing'1 = [ "MEOW" '']]' ]=][=[HISSS]]"[['' ];
      thing2 = [
        { thing3 = [ "give" "treat" ]; }
        "I LOVE KEYBOARDS"
        (utils.mkLuaInline ''[[I am a]] .. [[ lua ]] .. type("value")'')
      ];
      thing4 = "couch is for scratching";
    };
  };
}
