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
      in {
        packages = rec {
          aigpy = pkgs.python3Packages.callPackage ./aigpy/default.nix {};
          aperture-plymouth = pkgs.callPackage ./aperture-plymouth/default.nix {};
          bulk_extractor = pkgs.callPackage ./bulk_extractor/default.nix {};
          chicago95 = pkgs.callPackage ./chicago95/default.nix {};
          chitubox = pkgs.callPackage ./chitubox/default.nix {};
          ha-mqtt-iot = pkgs.callPackage ./ha-mqtt-iot/default.nix {};
          hyperhdr = pkgs.callPackage ./hyperhdr/default.nix {};
          libdvbcsa-patched = pkgs.callPackage ./libdvbcsa-patched/default.nix {};
          lycheeslicer = pkgs.callPackage ./lycheeslicer/default.nix {};
          lyricsgenius = pkgs.python3Packages.callPackage ./lyricsgenius/default.nix {};
          libdyson = pkgs.python311Packages.callPackage ./libdyson/default.nix {};
          simple-term-menu = pkgs.python3Packages.callPackage ./simple-term-menu/default.nix {};
          streamrip = pkgs.python3Packages.callPackage ./streamrip/default.nix {inherit simple-term-menu;};
          steamgrid = pkgs.callPackage ./steamgrid/default.nix {};
          oscam = pkgs.callPackage ./oscam/default.nix {};
          redmond97 = pkgs.callPackage ./redmond97/default.nix {};
          rkvm = pkgs.callPackage ./rkvm/default.nix {};
          se98 = pkgs.callPackage ./se98/default.nix {};
          switch-firmware = pkgs.callPackage ./switch-firmware/default.nix {};
          switch-keys = pkgs.callPackage ./switch-keys/default.nix {};
          tidal-dl = pkgs.python3Packages.callPackage ./tidal-dl/default.nix {
            inherit aigpy;
            inherit lyricsgenius;
          };
          tvheadend-patched = pkgs.callPackage ./tvheadend-patched/default.nix {inherit libdvbcsa-patched;};
          vlmcsd = pkgs.callPackage ./vlmcsd/default.nix {};
          xmount = pkgs.callPackage ./xmount/default.nix {};
        };
      }
    );
}
