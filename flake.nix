{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Automatisch alle Verzeichnisse mit default.nix finden
        packageDirs = builtins.filter (name: builtins.pathExists (./pkgs + "/${name}/default.nix")) (
          builtins.attrNames (builtins.readDir ./pkgs)
        );

        # Python Packages finden
        pythonPackageDirs =
          if builtins.pathExists ./pkgs.python3Packages then
            builtins.filter (name: builtins.pathExists (./pkgs.python3Packages + "/${name}/default.nix")) (
              builtins.attrNames (builtins.readDir ./pkgs.python3Packages)
            )
          else
            [ ];

        # Standard Packages automatisch erstellen
        autoPackages = builtins.listToAttrs (
          map (name: {
            name = name;
            value = pkgs.callPackage (./pkgs + "/${name}") { };
          }) packageDirs
        );

        # Python Packages automatisch erstellen
        pythonPackages = builtins.listToAttrs (
          map (name: {
            name = name;
            value = pkgs.python311Packages.callPackage (./pkgs.python3Packages + "/${name}") { };
          }) pythonPackageDirs
        );

        # Packages mit Overrides (liest overrides.nix falls vorhanden)
        overriddenPackages = builtins.listToAttrs (
          builtins.filter (x: x != null) (
            map (
              name:
              let
                overridePath = ./pkgs + "/${name}/overrides.nix";
              in
              if builtins.pathExists overridePath then
                {
                  name = name;
                  value =
                    let
                      overrides = import overridePath;
                      extraArgs = if overrides ? extraArgs then overrides.extraArgs autoPackages else { };
                    in
                    pkgs.callPackage (./pkgs + "/${name}") extraArgs;
                }
              else
                null
            ) packageDirs
          )
        );
      in
      rec {
        packages = autoPackages // pythonPackages // overriddenPackages;
        checks = packages;
      }
    );
}
