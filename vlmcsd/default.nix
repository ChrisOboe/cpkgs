{
  lib,
  fetchFromGitHub,
  stdenv,
  gnumake,
}:
stdenv.mkDerivation rec {
  pname = "vlmcsd";
  version = "1113";

  src = fetchFromGitHub {
    owner = "kkkgo";
    repo = "vlmcsd";
    rev = "${version}";
    sha256 = "J9SIw7JyXhNxPzdyf+gwf5IhaDiB9Ggn0Px4R+fVZSQ=";
  };

  nativeBuildInputs = [
    gnumake
  ];

  installPhase = ''
    mkdir -p $out/bin
    ls -alh bin
    ls -alh build
    cp ./bin/vlmcsd $out/bin
    cp ./bin/vlmcs $out/bin
  '';

  meta = with lib; {
    homepage = "https://github.com/kkkgo/vlmcsd";
    description = "Portable open-source KMS Emulator in C";
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
