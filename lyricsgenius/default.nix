{
  lib,
  buildPythonPackage,
  fetchPypi,
  beautifulsoup4,
  requests,
}:
buildPythonPackage rec {
  pname = "lyricsgenius";
  version = "3.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "83aef55ffca0b8ea69651c4b144693d1c012687a7da57f88d095b333f2e18928";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # beautifulsoup4 (>=4.6.0)
  # requests (>=2.20.0)
  # # Extra packages (may not be necessary)
  # tox (~=3.2) ; extra == 'checks'
  # doc8 ; extra == 'checks'
  # flake8 ; extra == 'checks'
  # flake8-bugbear ; extra == 'checks'
  # pygments ; extra == 'checks'
  # sphinx (~=3.3) ; extra == 'dev'
  # sphinx-rtd-theme ; extra == 'dev'
  # tox (~=3.2) ; extra == 'dev'
  # doc8 ; extra == 'dev'
  # flake8 ; extra == 'dev'
  # flake8-bugbear ; extra == 'dev'
  # pygments ; extra == 'dev'
  # sphinx (~=3.3) ; extra == 'docs'
  # sphinx-rtd-theme ; extra == 'docs'
  propagatedBuildInputs = [
    beautifulsoup4
    requests
  ];

  meta = with lib; {
    description = "Download lyrics and metadata from Genius.com";
    homepage = https://github.com/johnwmillr/lyricsgenius;
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
