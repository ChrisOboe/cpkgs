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
  version = "2021.9.10.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8982df2277daf377a5932663c68cf0c2d667ac51ed12dc0b15553991e7dc79fc";
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
