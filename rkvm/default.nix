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
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "htrefil";
    repo = pname;
    rev = version;
    hash = "sha256-NJ9wvG3UN80OMKQqrOwcdhsypNdJlQB3SaI/wP0DcHM=";
  };
  cargoHash = "sha256-HvHGOcGKHCuyhd2S4BPketGwo3/Av1WRgbAqBHdP9kw=";

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
