{
  lib,
  stdenv,
  fetchzip,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "nintendo-switch-global-firmware";
  version = "17.0.1";

  src = fetchzip {
    url = "https://archive.org/download/nintendo-switch-global-firmwares/Firmware%20${version}.zip";
    stripRoot=false;
    hash = "sha256-k//3D4irRdD3AP2v2Ub/niStTjojz8o6gad0fqLO/vg=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp * $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Nintendo Switch Firmware";
    homepage = "https://archive.org/details/nintendo-switch-global-firmwares";
    license = licenses.unfree;
    maintainers = ["chris@oboe.email"];
  };
}
