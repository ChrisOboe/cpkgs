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
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "simsong";
    repo = "bulk_extractor";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-Jj/amXESFBu/ZaiIRlDKmtWTBVQ2TEvOM2jBYP3y1L8=";
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
    maintainers = ["chris@oboe.email"];
  };
}
