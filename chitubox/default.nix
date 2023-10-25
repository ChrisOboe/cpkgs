{
  autoPatchelfHook,
  fetchurl,
  fontconfig,
  glib,
  gnutar,
  lib,
  libdrm,
  libGL,
  libgpgerror,
  stdenv,
  xorg,
  zlib,
  libpulseaudio,
  libxkbcommon,
  alsa-lib,
  gst_all_1,
}:
stdenv.mkDerivation rec {
  pname = "chitubox";
  version = "1.9.5";

  src = fetchurl {
    # abuse my mail provider for this since upstream has some really wierd js
    # based authentication and github has a limit of 100mb :(
    # it's a mirror of upstream: https://www.chitubox.com/en/download/chitubox-free
    url = "https://software.oboe.email/CHITUBOX_V${version}.tar.gz";
    sha256 = "sha256-mNEMfuzRSKBo5tGITWrwg68caLx8Zjz+CaSnbt35Nis=";
  };
  sourceRoot = ".";

  nativeBuildInputs = [
    gnutar
    autoPatchelfHook
  ];

  buildInputs = [
    fontconfig
    glib
    libdrm
    libGL
    libgpgerror
    stdenv.cc.cc.lib
    xorg.libX11
    zlib
    libpulseaudio
    libxkbcommon
    alsa-lib
    xorg.libxcb
    xorg.xcbutilrenderutil
    xorg.xcbutilkeysyms
    xorg.xcbutilimage
    xorg.xcbutilwm
    gst_all_1.gst-plugins-base
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    cp -r ./ $out
    #rm -rf $out/lib
    #rm -rf $out/plugins
    mkdir -p $out/bin
    ln -s $out/CHITUBOX $out/bin/chitubox
  '';

  meta = with lib; {
    homepage = "https://www.chitubox.com";
    description = "SLA/DLP/LCD 3D printing slicer";
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
    maintainers = ["chris@oboe.email"];
  };
}
