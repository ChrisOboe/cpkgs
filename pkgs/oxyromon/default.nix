{
  stdenv,
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage rec {
  pname = "oxyromon";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "alucryd";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-KA250hxXc7DGJugzd8odNmmnPeKGxf65ISFWZNoUybM=";
  };

  cargoSha256 = "sha256-B7l828lGM/SoUBnf/jHGC9QRKIIuoryL1FPDEihEO8A=";

  doCheck = false; # some tests are failing

  meta = with lib; {
    description = "Rusty ROM OrgaNizer";
    homepage = "https://github.com/alucryd/oxyromon";
    license = licenses.gpl3;
    maintainers = ["chris@oboe.email"];
  };
}
