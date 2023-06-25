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
  pname = "bulk_extractor2";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "simsong";
    repo = "bulk_extractor";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "sha256-almTClEgbkIGCxP8tY0Rjqj9Skabk14v6zO8RwU5Qvg=";
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
