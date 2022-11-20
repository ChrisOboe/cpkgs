{
  lib,
  fetchFromGitHub,
  stdenv,
  autoreconfHook,
  openssl,
  jdk,
  flex,
  zlib,
}:
stdenv.mkDerivation rec {
  pname = "bulk_extractor";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "simsong";
    repo = "bulk_extractor";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-w09dEBoZ4nEdKgeDbEdwB2tBeblplxKWyHbKGcFsTtk=";
  };

  nativeBuildInputs = [
    autoreconfHook
    jdk
    flex
  ];

  buildInputs = [
    openssl
    zlib
  ];

  meta = with lib; {
    homepage = "https://github.com/simsong/bulk_extractor/";
    description = "extracting tool";
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
