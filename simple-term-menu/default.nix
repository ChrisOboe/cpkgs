{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
}:
buildPythonPackage rec {
  pname = "simple-term-menu";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "IngoMeyer441";
    repo = "simple-term-menu";
    rev = "v${version}";
    sha256 = "sha256-SAC1hNCl2r7ijasCNJ5oaHBYdMG4aCDf828tFAsJ8lc=";
  };

  meta = with lib; {
    description = "A Python package which creates simple interactive menus on the command line.";
    homepage = "https://github.com/IngoMeyer441/simple-term-menu";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
