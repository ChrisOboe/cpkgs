{
  lib,
  buildPythonApplication,
  fetchPypi,
  mopidy,
  tidalapi,
  requests,
  pykka,
}:
buildPythonApplication rec {
  pname = "mopidy-tidal";
  version = "0.3.2";

  src = fetchPypi {
    inherit version;
    pname = "Mopidy-Tidal";
    sha256 = "sha256-ekqhzKyU2WqTOeRR1ZSZA9yW3UXsLBsC2Bk6FZrQgmc=";
  };

  propagatedBuildInputs = [mopidy tidalapi requests pykka];

  doCheck = false;

  meta = with lib; {
    description = "Mopidy extension for playing audio from tidal";
    homepage = "https://github.com/tehkillerbee/mopidy-tidal";
    license = "apache2";
    maintainers = ["chris@oboe.email"];
  };
}
