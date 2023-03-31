{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl_1_1,
  pkg-config,
  libevdev,
}:
rustPlatform.buildRustPackage rec {
  pname = "rkvm";
  version = "20210117"; # the latest release is broken and doesn't build; use master

  src = fetchFromGitHub {
    owner = "htrefil";
    repo = pname;
    rev = "bf133665eb446d9f128d02e4440cc67bce50f666";
    hash = "sha256-naWoLo3pPETkYuW4HATkrfjGcEHSGAAXixgp1HOlIcg=";
  };
  cargoHash = "sha256-7h+/ombiVcBeX60toakFklKi8GalS3v/csn1wkXJJk4=";

  nativeBuildInputs = [pkg-config rustPlatform.bindgenHook];
  buildInputs = [libevdev openssl_1_1];

  doCheck = false; # tests are broken and don't build.

  postInstall = ''
    for i in $out/bin/*
    do
      NAME=`basename $i`
      mv "$i" "$out/bin/rkvm-$NAME"
    done
  '';

  meta = with lib; {
    description = "Virtual KVM switch for Linux machines";
    homepage = "https://github.com/htrefil/rkvm";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
