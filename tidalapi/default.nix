{
  lib,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "tidalapi";
  version = "0.7.0";

  src = python3Packages.fetchPypi {
    inherit version;
    pname = "tidalapi";
    sha256 = "sha256-LdlTBkCOb7tXiupsNJ5lbk38syKXeADvi2IdGpW/dk8=";
  };

  propagatedBuildInputs = [python3Packages.requests python3Packages.python-dateutil];

  doCheck = false;

  meta = with lib; {
    description = "Unofficial Python API for TIDAL music streaming service";
    homepage = "https://github.com/tamland/python-tidal";
    license = "LGPL3";
    maintainers = ["chris@oboe.email"];
  };
}
