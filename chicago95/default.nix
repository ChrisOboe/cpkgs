{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "chicago95";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "grassmunk";
    repo = "Chicago95";
    rev = "v${version}";
    sha256 = "sha256-1fiefsj+WeLBL/1cTkLJf9Ab4zsLEFi1PXT5CCAmlO4=";
  };

  nativeBuildInputs = [pkgs.which];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons $out/share/themes
    mv Icons/Chicago95 $out/share/icons
    mv Cursors/* $out/share/icons
    mv Theme/Chicago95 $out/share/themes
    runHook postInstall
  '';

  meta = with lib; {
    description = "Chicago95 theme";
    homepage = "https://github.com/grassmunk/Chicago95";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
