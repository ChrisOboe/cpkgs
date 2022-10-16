{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.oscam = pkgs.callPackage ./oscam/default.nix {};
        packages.libdvbcsa-patched = pkgs.callPackage ./libdvbcsa-patched/default.nix {};
        packages.tvheadend-patched = pkgs.callPackage ./tvheadend-patched/default.nix {libdvbcsa-patched = packages.libdvbcsa-patched;};
      }
    );
}
