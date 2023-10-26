{
  stdenv,
  lib,
  fetchurl,
  appimageTools,
  makeDesktopItem,
}: let
  pname = "lycheeslicer";
  version = "5.4.0";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://mango-lychee.nyc3.digitaloceanspaces.com/LycheeSlicer-${version}.AppImage";
    sha256 = "sha256-IsfYPeW77ks2pObAQQKpUVFtgCXZiIZ5GMwNOpiwCIs=";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = "${name}";
    icon = "${pname}";
    desktopName = "LycheeSlicer";
    categories = ["Utility"];
  };
in
  appimageTools.wrapType2 rec {
    inherit name src;

    extraInstallCommands = "
      mkdir -p $out/share/applications $out/share/icons/hicolor/512x512/apps
      ln -s ${desktopItem}/share/applications/* $out/share/applications/
      cp ${appimageContents}/lycheeslicer.png $out/share/icons/hicolor/512x512/apps/lycheeslicer.png
    ";

    meta = with lib; {
      description = "Lychee Slicer for SLA/Resin 3D Printers";
      homepage = "https://lychee.mango3d.io";
      platforms = platforms.linux;
    };
  }
