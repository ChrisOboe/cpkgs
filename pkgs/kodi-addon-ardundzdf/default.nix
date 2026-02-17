{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "kodi-addon-ardundzdf";
  version = "5.3.9+matrix";

  src = fetchFromGitHub {
    owner = "rols1";
    repo = "Kodi-Addon-ARDundZDF";
    rev = "5172a5359d01a1fe545cf7e6d39f47f71e3f0296";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/kodi/addons/plugin.video.ardundzdf
    cp -r * $out/share/kodi/addons/plugin.video.ardundzdf/

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/rols1/Kodi-Addon-ARDundZDF";
    description = "ARD- und ZDF-Mediathek addon for Kodi including Live-TV with recording, watchlist, Live-Radio, Podcasts";
    longDescription = ''
      Kodi addon for German public broadcasting services ARD and ZDF media libraries.
      Includes 3Sat, children's programs (KIKA, ZDFtivi, MausLive, etc.), TagesschauXL,
      phoenix, Arte categories, Audiothek, EPG, and tools.
    '';
    license = licenses.mit;
    maintainers = [ "chris@oboe.email" ];
    platforms = platforms.all;
  };
}
