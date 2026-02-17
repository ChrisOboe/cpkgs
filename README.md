# cpkgs

A collection of custom Nix packages maintained as a flake.

## Available Packages

This repository contains various packages that are not available in nixpkgs or require custom configurations:

- **aperture-plymouth** - Plymouth theme
- **bulk_extractor** - Bulk data extraction tool
- **ha-mqtt-iot** - Home Assistant MQTT IoT integration
- **jackboxutility** - Jackbox utility tool
- **kodi-addon-ardundzdf** - Kodi addon for ARD and ZDF German media libraries
- **libdvbcsa-patched** - Patched DVB-CSA library
- **libdyson** - Python library for Dyson devices
- **oscam** - Open Source Conditional Access Module
- **oxyromon** - ROM organizer
- **redmond97** - Windows 97 theme
- **se98** - Temperature sensor tool
- **steamgrid** - Steam grid utility
- **tvheadend-patched** - Patched TV streaming server
- **vlmcsd** - KMS emulator
- **xmount** - Mounting tool

## Usage

### Adding to Your Flake

Add this repository as an input to your flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    cpkgs.url = "github:ChrisOboe/cpkgs";
  };

  outputs = { self, nixpkgs, cpkgs }: {
    # Your configuration
  };
}
```

Then use packages from this flake:

```nix
environment.systemPackages = [
  cpkgs.packages.${system}.oxyromon
];
```

### Building Packages Directly

You can build any package directly using:

```bash
nix build github:ChrisOboe/cpkgs#<package-name>
```

For example:

```bash
nix build github:ChrisOboe/cpkgs#oscam
```

## Automated Updates

This repository uses GitHub Actions to automatically update packages:

### Update Flake Lock

The `update-flake-lock` workflow runs daily to update the flake.lock file, keeping nixpkgs and other dependencies up to date.

### Update Packages

The `update-packages` workflow runs weekly (Sundays at 2 AM) to automatically update all packages to their latest versions:

- Updates package versions using `nix-update`
- Builds each package to verify it still works
- Creates individual PRs for each package update
- Automatically merges PRs if the build succeeds (requires PAT token)

You can also trigger manual updates via GitHub Actions workflow dispatch.

## Contributing

Contributions are welcome! Please ensure that:

1. New packages build successfully with `nix build .#<package-name>`
2. Package metadata is complete (description, homepage, license, maintainers)
3. Follow the existing package structure

## Maintenance

Packages are automatically updated weekly. Manual updates can be triggered for specific packages using:

```bash
nix-update --flake --version=unstable <package-name>
```

## License

Individual packages have their own licenses. See the `meta.license` field in each package's `default.nix` file.
