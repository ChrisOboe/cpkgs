{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
}:
buildPythonPackage rec {
  pname = "simple-term-menu";
  version = "1.6.6";

  src = fetchFromGitHub {
    owner = "IngoMeyer441";
    repo = "simple-term-menu";
    rev = "v${version}";
    sha256 = "sha256-nfMqtyUalt/d/wTyRUlu5x4Q349ARY8hDMi8Ui4cTI4=";
  };

  meta = with lib; {
    description = "A Python package which creates simple interactive menus on the command line.";
    homepage = "https://github.com/IngoMeyer441/simple-term-menu";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
