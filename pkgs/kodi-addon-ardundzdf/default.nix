{
  lib,
  stdenv,
  fetchFromGitHub,
  kodi ? null,
}:

let
  addonId = "plugin.video.ardundzdf";
  addonDir = if kodi != null then kodi.passthru.addonDir or "/share/kodi/addons" else "/share/kodi/addons";
in
stdenv.mkDerivation rec {
  pname = "kodi-addon-ardundzdf";
  version = "5.3.9+matrix";

  src = fetchFromGitHub {
    owner = "rols1";
    repo = "Kodi-Addon-ARDundZDF";
    rev = "5172a5359d01a1fe545cf7e6d39f47f71e3f0296";
    hash = "sha256-FG1dmnNb15hlNBK31Yj3yUZKmS4FK2km5k69a+aLDl0=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out${addonDir}/${addonId}
    cp -r * $out${addonDir}/${addonId}/

    runHook postInstall
  '';

  passthru = {
    namespace = addonId;
    addonId = addonId;
  };

  meta = with lib; {
    homepage = "https://github.com/rols1/Kodi-Addon-ARDundZDF";
    description = "ARD- und ZDF-Mediathek addon for Kodi including Live-TV with recording, watchlist, Live-Radio, Podcasts";
    longDescription = ''
      Kodi addon for German public broadcasting services ARD and ZDF media libraries.
      Includes 3Sat, children's programs (KIKA, ZDFtivi, MausLive, etc.), TagesschauXL,
      phoenix, Arte categories, Audiothek, EPG, and tools.
      
      This addon requires script.module.kodi-six and script.module.requests to function properly.
    '';
    license = licenses.mit;
    maintainers = [ "chris@oboe.email" ];
    platforms = platforms.all;
  };
}
