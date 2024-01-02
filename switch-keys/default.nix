{
  lib,
  stdenv,
  fetchzip,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "nintendo-switch-keys";
  version = "17.0.0";

  src = fetchzip {
    url = "https://archive.org/download/prodKeys.co-V17.0.0/prodKeys.co-V17.0.0.zip";
    hash = "sha256-+C/lludoB0YmSpZj2Yhf7dQvCzlIyVrp5SUj5O7Xcfo=";
  };

  installPhase = ''
    mkdir $out

    cp prodKeys.co-V17.0.0/prodKeys.co-V17.0.0/* $out/
  '';

  meta = with lib; {
    description = "Nintendo Switch Keys";
    license = licenses.unfree;
    maintainers = ["chris@oboe.email"];
  };
}
