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
        packages.qt-creator = pkgs.libsForQt5.callPackage ./qt-creator/default.nix {};
        packages.oscam = pkgs.callPackage ./oscam/default.nix {};
        packages.libdvbcsa-patched = pkgs.callPackage ./libdvbcsa-patched/default.nix {};
        packages.tvheadend-patched = pkgs.callPackage ./tvheadend-patched/default.nix {libdvbcsa-patched = packages.libdvbcsa-patched;};
        packages.hyperion-ng-chris = pkgs.libsForQt5.callPackage ./hyperion-ng/default.nix {};
        packages.vlmcsd = pkgs.callPackage ./vlmcsd/default.nix {};
        packages.aigpy = pkgs.python3Packages.callPackage ./aigpy/default.nix {};
        packages.lyricsgenius = pkgs.python3Packages.callPackage ./lyricsgenius/default.nix {};
        packages.tidal-dl = pkgs.python3Packages.callPackage ./tidal-dl/default.nix {};
        packages.chicago95 = pkgs.callPackage ./chicago95/default.nix {};
        packages.se98 = pkgs.callPackage ./se98/default.nix {};
        packages.redmond97 = pkgs.callPackage ./redmond97/default.nix {};
      }
    );
}
