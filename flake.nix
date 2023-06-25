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
        packages.aigpy = pkgs.python3Packages.callPackage ./aigpy/default.nix {};
        packages.aperture-plymouth = pkgs.callPackage ./aperture-plymouth/default.nix {};
        packages.bulk_extractor2 = pkgs.callPackage ./bulk_extractor2/default.nix {};
        packages.bulk_extractor = pkgs.callPackage ./bulk_extractor/default.nix {};
        packages.chicago95 = pkgs.callPackage ./chicago95/default.nix {};
        packages.ha-mqtt-iot = pkgs.callPackage ./ha-mqtt-iot/default.nix {};
        packages.mopidyapi = pkgs.python311Packages.callPackage ./mopidyapi/default.nix {};
        packages.hyperion-ng-chris = pkgs.libsForQt5.callPackage ./hyperion-ng/default.nix {};
        packages.hyperhdr = pkgs.callPackage ./hyperhdr/default.nix {};
        packages.libdvbcsa-patched = pkgs.callPackage ./libdvbcsa-patched/default.nix {};
        packages.lycheeslicer = pkgs.callPackage ./lycheeslicer/default.nix {};
        packages.lyricsgenius = pkgs.python3Packages.callPackage ./lyricsgenius/default.nix {};
        packages.libdyson = pkgs.python311Packages.callPackage ./libdyson/default.nix {};
        packages.simple-term-menu = pkgs.python3Packages.callPackage ./simple-term-menu/default.nix {};
        packages.mopidy-tidal = pkgs.python3Packages.callPackage ./mopidy-tidal/default.nix {inherit (packages) tidalapi;};
        packages.streamrip = pkgs.python3Packages.callPackage ./streamrip/default.nix {inherit (packages) simple-term-menu;};
        packages.oscam = pkgs.callPackage ./oscam/default.nix {};
        packages.qt-creator = pkgs.libsForQt5.callPackage ./qt-creator/default.nix {};
        packages.redmond97 = pkgs.callPackage ./redmond97/default.nix {};
        packages.rkvm = pkgs.callPackage ./rkvm/default.nix {};
        packages.se98 = pkgs.callPackage ./se98/default.nix {};
        packages.tdl = pkgs.python3Packages.callPackage ./tdl/default.nix {};
        packages.tidal-dl = pkgs.python3Packages.callPackage ./tidal-dl/default.nix {
          inherit (packages) aigpy;
          inherit (packages) lyricsgenius;
        };
        packages.tidalapi = pkgs.python3Packages.callPackage ./tidalapi/default.nix {};
        packages.tvheadend-patched = pkgs.callPackage ./tvheadend-patched/default.nix {inherit (packages) libdvbcsa-patched;};
        packages.vlmcsd = pkgs.callPackage ./vlmcsd/default.nix {};
        packages.xmount = pkgs.callPackage ./xmount/default.nix {};
      }
    );
}
