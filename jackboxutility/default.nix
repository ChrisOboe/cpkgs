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
  version = "1.5.1";

  src = fetchzip {
    url = "https://github.com/JackboxUtility/JackboxUtility/releases/download/${version}/JackboxUtility_Linux.zip";
    sha256 = "sha256-nuzr3A5lvH4JzNkLvLxcR3n5w8Sx1F3nRsvu5oSv6sE=";
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
