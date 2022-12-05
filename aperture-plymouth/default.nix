{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "aperture-plymouth";
  version = "2017-10-15";

  src = fetchFromGitHub {
    owner = "irth";
    repo = "plymouth-theme-aperture";
    rev = "edab46ca3b1f2f509958c9a9525888b3ac95fd61";
    sha256 = "";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plymouth/themes/aperture
    mv * $out/share/plymouth/themes/aperture
    runHook postInstall
  '';

  meta = with lib; {
    description = "Aperture plymouth theme";
    homepage = "https://github.com/irth/plymouth-theme-aperture";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
