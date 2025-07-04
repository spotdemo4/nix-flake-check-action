{
  description = "Nix Flake Checker Action";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    build-systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forSystem = f:
      nixpkgs.lib.genAttrs build-systems (
        system:
          f {
            inherit system;
            pkgs = import nixpkgs {
              inherit system;
            };
          }
      );
  in {
    checks = forSystem ({pkgs, ...}: {

# Intentionally not tabbed to fail
lint = with pkgs;
  runCommandLocal "check-lint" {
    nativeBuildInputs = with pkgs; [
      alejandra
    ];
  } ''
    cd ${./.}
    HOME=$PWD

    alejandra -c .

    touch $out
  '';
    });

    formatter = forSystem ({pkgs, ...}: pkgs.alejandra);
  };
}
