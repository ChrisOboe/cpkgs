{
  lib,
  buildPythonPackage,
  fetchPypi,
  requests,
  colorama,
  mutagen,
}:
buildPythonPackage rec {
  pname = "aigpy";
  version = "2021.9.10.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "838aaaf62efb2a48847f07948cce0dc1a209828807545b914065b25c4e50c38d";
  };

  propagatedBuildInputs = [
    requests
    colorama
    mutagen
  ];

  meta = with lib; {
    description = "Python Common Tool";
    homepage = "https://www.aigpy.de";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
