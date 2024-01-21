{
  lib,
  fetchzip,
  stdenv,
  makeWrapper,
  autoPatchelfHook,
  gtk3,
  pango,
  cairo,
  gdk-pixbuf,
  gobject-introspection,
  gcc,
  gst_all_1,
}:
stdenv.mkDerivation rec {
  pname = "jackboxutility";
  version = "1.3.6+6";

  src = fetchzip {
    url = "https://github.com/JackboxUtility/JackboxUtility/releases/download/1.3.6%2B6/JackboxUtility_Linux.zip";
    sha256 = "sha256-la0RnfuCnX0GyubM34ZhiEQV+03de1uUcZgtPML4knU=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  buildInputs = [
    gtk3
    pango
    cairo
    gdk-pixbuf
    gobject-introspection
    gcc
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    cp -r ./ $out
    mkdir -p $out/bin
    chmod +x $out/JackboxUtility
    makeWrapper $out/JackboxUtility $out/bin/JackboxUtility
  '';

  meta = with lib; {
    description = "Virtual KVM switch for Linux machines";
    homepage = "https://github.com/htrefil/rkvm";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
