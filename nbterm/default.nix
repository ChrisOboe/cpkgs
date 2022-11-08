{
  lib,
  buildPythonPackage,
  fetchPypi,
  prompt-toolkit,
  typer,
  pygments,
  rich,
  kernel_driver,
}:
buildPythonPackage rec {
  pname = "nbterm";
  version = "0.0.12";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8982df2277daf377a5932663c68cf0c2d667ac51ed12dc0b15553991e7dc79fd";
  };

  # # Package conditions to handle
  # # might have to sed setup.py and egg.info in patchPhase
  # # sed -i "s/<package>.../<package>/"
  # aigpy (>=2021.9.10.3)
  # requests (>=2.22.0)
  propagatedBuildInputs = [
    prompt-toolkit
    typer
    pygments
    rich
    kernel_driver
  ];

  #postConfigure = ''
  #  substituteInPlace tidal_dl/__init__.py --replace 'filename=getLogPath(),' ' '
  #'';

  doCheck = false;

  meta = with lib; {
    description = "A tool for viewing, editing and executing Jupyter Notebooks in the terminal.";
    homepage = "https://github.com/davidbrochart/nbterm";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
