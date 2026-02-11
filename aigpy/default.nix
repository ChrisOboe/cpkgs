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
  version = "2022.7.8.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-1kQced6YdC/wvegqFVhZfej4+4aemGXvKysKjejP13w=";
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
