{
  config,
  lib,
  ...
}: {
  imports = [
    ./keys.nix
    ./sets.nix
    ./highlight.nix
    ./plugins
  ];
#  options = {
#    theme = lib.mkOption {
#      default = "paradise";
#      type = lib.types.enum ["paradise" "decay" "mountain" "tokyonight" "everforest" "everblush" "jellybeans" "aquarium" "gruvbox"];
#    };
#  };
#  config = {
#    # The base16 theme to use, if you want to use another theme, change it in colorscheme.nix
#    theme = "paradise";
#    extraConfigLua = ''
#      _G.theme = "${config.theme}"
#    '';
#  };
}
