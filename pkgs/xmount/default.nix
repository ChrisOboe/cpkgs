{
  lib,
  fetchgit,
  stdenv,
  libewf,
  cmake,
  fuse,
}:
stdenv.mkDerivation rec {
  pname = "xmount";
  version = "0.7.6";

  git = fetchgit {
    url = "https://code.pinguin.lu/diffusion/XMOUNT/xmount.git";
    rev = "v${version}";
    sha256 = "sha256-BooHOqtX+y7oWHobjiHEuWQANMM4BLcqnpG29BxF7PY=";
  };

  src = "${git}/trunk";

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    fuse
    libewf
  ];

  meta = with lib; {
    homepage = "https://www.pinguin.lu/xmount";
    description = "on-the-fly converstion between multiple input and output images";
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
