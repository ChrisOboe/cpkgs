{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "se98";
  version = "0.2.16";

  src = fetchFromGitHub {
    owner = "nestoris";
    repo = "Win98SE";
    rev = "v${version}";
    sha256 = "sha256-8vaSb2W9/ievnbiCq6vu7YqDMbxgwrNJWB/JiTL31FQ=";
  };

  #nativeBuildInputs = [ pkgs.which ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    mv SE98 $out/share/icons
    runHook postInstall
  '';

  meta = with lib; {
    description = "SE98 Icon theme";
    homepage = "https://github.com/nestoris/Win98SE";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
