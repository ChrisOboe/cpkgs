{
  lib,
  fetchFromGitHub,
  rustPlatform,
  openssl,
  pkg-config,
  libevdev,
}:
rustPlatform.buildRustPackage rec {
  pname = "rkvm";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "htrefil";
    repo = pname;
    rev = version;
    hash = "sha256-pGCoNmGOeV7ND4kcRjlJZbEMnmKQhlCtyjMoWIwVZrM=";
  };
  cargoHash = "sha256-aq8Ky29jXY0cW5s0E4NDs29DY8RIA0Fvy2R72WPAYsk=";

  nativeBuildInputs = [pkg-config rustPlatform.bindgenHook];
  buildInputs = [libevdev openssl];

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
