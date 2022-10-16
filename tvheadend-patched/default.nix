{
  avahi,
  bzip2,
  cmake,
  dbus,
  fetchFromGitHub,
  fetchpatch,
  ffmpeg_4,
  gettext,
  git,
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
  python2,
  stdenv,
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
      rev = "3edbd57246129c99b079cfd6269688430591e0d1";
      sha256 = "sha256-hr25kUKtLQRje4RJjkLY3GGXqO/4erA+wdy4RvpqbqQ=";
    };

    patches = [
      ./tvheadend43.patch
    ];

    buildInputs = [
      avahi
      bzip2
      dbus
      ffmpeg_4
      gettext
      git
      gnutar
      gzip
      libdvbcsa-patched
      libiconv
      libopus
      libva
      libvpx
      openssl
      python2
      which
      x264
      x265
      zlib
    ];

    nativeBuildInputs = [cmake makeWrapper pkg-config];

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
