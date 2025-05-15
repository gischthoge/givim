{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    lua-language-server
    nil
    stylua # Optional: Lua formatter
    nixpkgs-fmt # Optional: Nix formatter
  ];

  shellHook = ''
    echo "🧠 LSPs for Lua and Nix are active."
  '';
}
