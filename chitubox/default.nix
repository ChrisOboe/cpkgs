{
  autoPatchelfHook,
  fetchurl,
  makeWrapper,
  fontconfig,
  glib,
  gnutar,
  lib,
  libdrm,
  libGL,
  cacert,
  libgpgerror,
  openssl_1_1,
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
    makeWrapper
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
    openssl_1_1
    libpulseaudio
    libxkbcommon
    alsa-lib
    xorg.libxcb
    xorg.xcbutilrenderutil
    xorg.xcbutilkeysyms
    xorg.xcbutilimage
    xorg.xcbutilwm
    gst_all_1.gst-plugins-base
    cacert
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    cp -r ./ $out
    #rm -rf $out/lib
    #rm -rf $out/plugins
    mkdir -p $out/bin
    # chitubox has no wayland plugin for its qt.
    makeWrapper $out/CHITUBOX $out/bin/chitubox \
     --set QT_QPA_PLATFORM xcb \
     --set LD_LIBRARY_PATH "${openssl_1_1.out}/lib" \
     --set SSL_CERT_FILE "${cacert}/etc/ssl/certs/ca-bundle.crt"
  '';

  meta = with lib; {
    homepage = "https://www.chitubox.com";
    description = "SLA/DLP/LCD 3D printing slicer";
    platforms = platforms.linux;
    # it's unfree, but flakes somewhat seem to ignore allowUnfree setting.
    # so unless flakes honor this seeting i outcommented the license
    #license = licenses.unfreeRedistributable;
    maintainers = ["chris@oboe.email"];
  };
}
