{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "redmond97";
  version = "2021-02-06";

  src = fetchFromGitHub {
    owner = "matthewmx86";
    repo = "Redmond97";
    rev = "6a72f717aefee7517ff601df0156c5d09b56e78f";
    sha256 = "sha256-xCZ//tPsQsKlueOYY/reZHlQ9yeHCHKSbwnw5tE/cgM=";
  };

  #nativeBuildInputs = [ pkgs.which ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons $out/share/themes
    mv Extras/Icons/Redmond97 $out/share/icons
    mv Theme/csd/* $out/share/themes
    runHook postInstall
  '';

  meta = with lib; {
    description = "Redmond97 theme";
    homepage = "https://github.com/matthewmx86/Redmond97";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
