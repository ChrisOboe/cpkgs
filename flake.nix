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
          aperture-plymouth = pkgs.callPackage ./aperture-plymouth/default.nix {};
          bulk_extractor = pkgs.callPackage ./bulk_extractor/default.nix {};
          oxyromon = pkgs.callPackage ./oxyromon/default.nix {};
          ha-mqtt-iot = pkgs.callPackage ./ha-mqtt-iot/default.nix {};
          jackboxutility = pkgs.callPackage ./jackboxutility/default.nix {};
          libdvbcsa-patched = pkgs.callPackage ./libdvbcsa-patched/default.nix {};
          lycheeslicer = pkgs.callPackage ./lycheeslicer/default.nix {};
          libdyson = pkgs.python311Packages.callPackage ./libdyson/default.nix {};
          steamgrid = pkgs.callPackage ./steamgrid/default.nix {};
          oscam = pkgs.callPackage ./oscam/default.nix {};
          redmond97 = pkgs.callPackage ./redmond97/default.nix {};
          se98 = pkgs.callPackage ./se98/default.nix {};
          tvheadend-patched = pkgs.callPackage ./tvheadend-patched/default.nix {inherit libdvbcsa-patched;};
          vlmcsd = pkgs.callPackage ./vlmcsd/default.nix {};
          xmount = pkgs.callPackage ./xmount/default.nix {};
        };
      }
    );
}
