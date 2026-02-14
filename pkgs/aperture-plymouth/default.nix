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
    sha256 = "sha256-QpaLTMR6cOKo9cD48djowUV+7dgGtqrF0+ZoQGpKifw=";
  };

  installPhase = ''
    runHook preInstall
    sed -i "s,/usr,$out,g" aperture.plymouth
    mkdir -p $out/share/plymouth/themes/aperture
    mv * $out/share/plymouth/themes/aperture
    runHook postInstall
  '';

  meta = with lib; {
    description = "Aperture plymouth theme";
    homepage = "https://github.com/irth/plymouth-theme-aperture";
    license = licenses.gpl2;
    maintainers = ["chris@oboe.email"];
  };
}
