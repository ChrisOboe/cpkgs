{
  lib,
  buildPythonPackage,
  fetchPypi,
  aigpy,
  requests,
  pycryptodome,
  pydub,
  prettytable,
  lyricsgenius,
}:
buildPythonPackage rec {
  pname = "tidal-dl";
  version = "2022.10.31.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-b2AAsiI3n2/v6HC37fMI/d8UcxZxsWM+fnWvdajHrOg=";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # aigpy (>=2021.9.10.3)
  # requests (>=2.22.0)
  propagatedBuildInputs = [aigpy requests pycryptodome pydub prettytable lyricsgenius];

  postConfigure = ''
    substituteInPlace tidal_dl/__init__.py --replace 'filename=getLogPath(),' ' '
  '';

  doCheck = false;

  meta = with lib; {
    description = "Tidal Music Downloader";
    homepage = "https://www.tidal.dl";
    license = licenses.asl20;
    maintainers = ["chris@oboe.email"];
  };
}
