{ pkgs, name, ... }@misc: {
  # these also recieve our pkgs variable
  # see :help nixCats.flake.outputs.packageDefinitions
  settings = {
    suffix-path = true;
    suffix-LD = true;
    # The name of the package, and the default launch name,
    # and the name of the .desktop file, is `nixCats`,
    # or, whatever you named the package definition in the packageDefinitions set.
    # WARNING: MAKE SURE THESE DONT CONFLICT WITH OTHER INSTALLED PACKAGES ON YOUR PATH
    # That would result in a failed build, as nixos and home manager modules validate for collisions on your path
    aliases = [ "vim" "vimcat" ];

    # explained below in the `regularCats` package's definition
    # OR see :help nixCats.flake.outputs.settings for all of the settings available
    wrapRc = true;
    configDirName = "nixCats-nvim";
    # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    hosts.python3.enable = true;
    hosts.node.enable = true;
  };
  # enable the categories you want from categoryDefinitions
  categories = {
    markdown = true;
    general = true;
    lint = true;
    format = true;
    neonixdev = true;
    test = { subtest1 = true; };

    # enabling this category will enable the go category,
    # and ALSO debug.go and debug.default due to our extraCats in categoryDefinitions.
    # go = true; # <- disabled but you could enable it with override or module on install

    # this does not have an associated category of plugins, 
    # but lua can still check for it
    lspDebugMode = false;
    # you could also pass something else:
    # see :help nixCats
    themer = true;
    #colorscheme = "onedark";
    colorscheme = "tokyonight";
  };
  extra = {
    # to keep the categories table from being filled with non category things that you want to pass
    # there is also an extra table you can use to pass extra stuff.
    # but you can pass all the same stuff in any of these sets and access it in lua
    nixdExtras = {
      nixpkgs = "import ${pkgs.path} {}";
      # or inherit nixpkgs;
    };
  };
}
