{
  lib,
  stdenv,
  autoreconfHook,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "libdvbcsa";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "glenvt18";
    repo = "${pname}";
    rev = "2a1e61e569a621c55c2426f235f42c2398b7f18f";
    sha256 = "sha256-jd/zjF7KEuc8e3+6rFrby7+JmKA0Ue+t8F/156/o7CY=";
  };

  patches = [
    ./libdvbcsa.patch
  ];

  nativeBuildInputs = [autoreconfHook];

  doCheck = true;

  meta = {
    description = "A free implementation of the DVB Common Scrambling Algorithm with encryption and decryption capabilities";
    homepage = "http://www.videolan.org/developers/libdvbcsa.html";
    platforms = lib.platforms.unix;
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [melias122];
  };
}
