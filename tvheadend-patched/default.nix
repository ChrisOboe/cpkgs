{
  avahi,
  bzip2,
  dbus,
  dtv-scan-tables,
  fetchFromGitHub,
  fetchpatch,
  ffmpeg,
  gettext,
  gnutar,
  gzip,
  lib,
  libdvbcsa-patched,
  libiconv,
  libopus,
  libva,
  libvpx,
  makeWrapper,
  openssl,
  pkg-config,
  python3,
  stdenv,
  uriparser,
  v4l-utils,
  which,
  x264,
  x265,
  zlib,
}: let
  version = "4.3.0";

  dtv-scan-tables = stdenv.mkDerivation {
    pname = "dtv-scan-tables";
    version = "2020-05-18";
    src = fetchFromGitHub {
      owner = "tvheadend";
      repo = "dtv-scan-tables";
      rev = "e3138a506a064f6dfd0639d69f383e8e576609da";
      sha256 = "19ac9ds3rfc2xrqcywsbd1iwcpv7vmql7gp01iikxkzcgm2g2b6w";
    };
    nativeBuildInputs = [v4l-utils];
    installFlags = ["DATADIR=$(out)"];
  };
in
  stdenv.mkDerivation {
    pname = "tvheadend";
    inherit version;

    src = fetchFromGitHub {
      owner = "tvheadend";
      repo = "tvheadend";
      rev = "d1366a0669c785141a128678a671c008abd1fb5a";
      sha256 = "sha256-jTrm5RxKAKvNTnMsWbHCUxOaNMWxjOzJqkyHR0JQWxQ=";
    };

    patches = [
      ./tvheadend43.patch
    ];

    buildInputs = [
      avahi
      bzip2
      dbus
      ffmpeg
      gettext
      gzip
      libdvbcsa-patched
      libiconv
      libopus
      libva
      libvpx
      openssl
      uriparser
      x264
      x265
      zlib
    ];

    nativeBuildInputs = [
      makeWrapper
      pkg-config
      python3
      which
    ];

    NIX_CFLAGS_COMPILE = ["-Wno-error=format-truncation" "-Wno-error=stringop-truncation"];

    # disable dvbscan, as having it enabled causes a network download which
    # cannot happen during build.  We now include the dtv-scan-tables ourselves
    configureFlags = [
      "--disable-dvbscan"
      "--disable-dvbcsa"
      "--disable-bintray_cache"
      "--disable-ffmpeg_static"
      "--disable-hdhomerun_client"
      "--disable-hdhomerun_static"
      "--disable-libx264_static"
      "--disable-libx265_static"
      "--disable-libvpx_static"
      "--disable-libtheora_static"
      "--disable-libvorbis_static"
      "--disable-libfdkaac_static"
      "--disable-libmfx_static"
      "--enable-vaapi"
    ];

    dontUseCmakeConfigure = true;

    preConfigure = ''
      patchShebangs ./configure

      substituteInPlace src/config.c \
        --replace /usr/bin/tar ${gnutar}/bin/tar

      substituteInPlace src/input/mpegts/scanfile.c \
        --replace /usr/share/dvb ${dtv-scan-tables}/dvbv5

      # the version detection script `support/version` reads this file if it
      # exists, so let's just use that
      echo ${version} > rpm/version
    '';

    postInstall = ''
      wrapProgram $out/bin/tvheadend \
        --prefix PATH : ${lib.makeBinPath [bzip2]}
    '';

    meta = with lib; {
      description = "TV streaming server";
      longDescription = ''
        Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android
        supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, SAT>IP and HDHomeRun as input sources.
        Tvheadend offers the HTTP (VLC, MPlayer), HTSP (Kodi, Movian) and SAT>IP streaming.'';
      homepage = "https://tvheadend.org";
      license = licenses.gpl3;
      platforms = platforms.unix;
      maintainers = with maintainers; [simonvandel];
    };
  }
