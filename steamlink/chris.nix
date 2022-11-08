{ stdenv
, lib
, fetchurl
, fetchpatch
, mkDerivation
, libGL
, SDL2
, SDL2_ttf
, SDL2_image
, SDL2_mixer
, ffmpeg_3
, zlib
, bzip2
, dbus
, freetype
, libopus
, qtbase
, qtsvg
, autoPatchelfHook
}:

mkDerivation rec {
  name = "steamlink-${version}";
  version = "1.1.77.191";

  src = fetchurl {
    url = "https://repo.steampowered.com/steamlink/${version}/${name}.tgz";
    sha256 = "1mUwlyNiIL6zxsWarLYqIWYSVGVJ4bL4pjHLX0zaWDw=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    stdenv.cc.cc.lib
    libGL
    SDL2
    SDL2_ttf
    SDL2_image
    SDL2_mixer
    ffmpeg_3
    zlib
    bzip2
    dbus
    freetype
    libopus
    (qtbase.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "mtoyoda";
        repo = "sl";
        rev = "923e7d7ebc5c1f009755bdeb789ac25658ccce03";
        sha256 = "173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4";`
      };

      patches = [ ./qt-everywhere-src-5.14.1.patch ];
    }))
    qtsvg
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp ./bin/steamlink $out/bin
    cp ./lib/libsteamwebrtc.so $out/lib
  '';

  meta = with lib; {
    homepage = "https://www.steampowered.com";
    description = "Streaming intended for games";
    platforms = platforms.linux;
    license = licenses.unfreeRedistributable;
    maintainers = [ "chris@oboe.email" ];
  };
}

