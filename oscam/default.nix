{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  openssl,
}:
stdenv.mkDerivation rec {
  pname = "oscam-patched";
  version = "220512";

  #src = fetchsvn {
  #  url = "https://svn.streamboard.tv/${pname}/trunk";
  #  rev = "${version}";
  #  sha256 = "sha256-a0j1xQdEBvKH3lyAPJeJrRGnFCyfdbqxFIrDMiuIOl0=";
  #};

  src = fetchFromGitHub {
    owner = "oscam-emu";
    repo = "oscam-patched";
    rev = "a137cbf6ebdfe6385cebbfe25679517609a7dd54";
    sha256 = "sha256-anJ/V5LoWcKwomHWJQ50palUOGWtu39lwHxhRG3EpY8=";
  };

  patches = [
    ./oscam_emu_icam_dvbapi_v4.patch
  ];

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    openssl
  ];

  preConfigure = ''
    ./config.sh --enable WITH_SSL MODULE_RADEGAST --disable WITH_DEBUG
  '';

  cmakeFlags = [
    "-DCS_CONFDIR=/var/lib/oscam"
  ];
}
