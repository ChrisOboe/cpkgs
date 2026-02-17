# Kodi Addon ARDundZDF

This package provides the ARDundZDF Kodi addon, which allows access to German public broadcasting services (ARD and ZDF) media libraries.

## Features

- Access to ARD and ZDF media libraries
- Live-TV with recording functionality
- Watchlist support
- Live-Radio
- Podcasts
- 3Sat, children's programs (KIKA, ZDFtivi, MausLive, etc.)
- TagesschauXL, phoenix, Arte categories
- Audiothek, EPG, and tools

## Installation

### Option 1: Add to your NixOS configuration

Add the addon to your Kodi installation:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    cpkgs.url = "github:ChrisOboe/cpkgs";
  };

  outputs = { self, nixpkgs, cpkgs }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            cpkgs.packages.x86_64-linux.kodi-addon-ardundzdf
          ];
        }
      ];
    };
  };
}
```

### Option 2: Direct installation

Build and install directly:

```bash
nix build github:ChrisOboe/cpkgs#kodi-addon-ardundzdf
```

After building, the addon will be located in:
```
result/share/kodi/addons/plugin.video.ardundzdf/
```

You can then manually copy this to your Kodi addons directory, typically at:
```
~/.kodi/addons/plugin.video.ardundzdf/
```

## Dependencies

This addon requires the following Kodi modules to function:
- `xbmc.python` (version 3.0.0 or higher) - provided by Kodi
- `script.module.kodi-six` - available in official Kodi repositories
- `script.module.requests` - available in official Kodi repositories

Make sure these dependencies are installed in your Kodi installation.

## Usage

After installation:
1. Open Kodi
2. Navigate to Add-ons > Video add-ons
3. Select "ARDundZDF"
4. Browse available content from ARD and ZDF media libraries

## License

This addon is licensed under the MIT License. See the [upstream repository](https://github.com/rols1/Kodi-Addon-ARDundZDF) for more details.

## Support

For issues specific to the addon functionality, please refer to:
- GitHub: https://github.com/rols1/Kodi-Addon-ARDundZDF
- Forum: https://www.kodinerds.net/index.php/Thread/64244-RELEASE-Kodi-Addon-ARDundZDF/

For issues with the Nix package, please open an issue in the cpkgs repository.
