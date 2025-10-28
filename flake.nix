{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        formatter = pkgs.treefmt.withConfig {
          runtimeInputs = with pkgs; [
            nixfmt-rfc-style
            html-tidy
          ];
          settings = {
            formatter.nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
            formatter.tidy = {
              command = "tidy";
              includes = [ "*.html" ];
            };
          };
        };
      }
    );
}
