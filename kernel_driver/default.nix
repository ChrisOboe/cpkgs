{
  lib,
  buildPythonPackage,
  fetchPypi,
}:
buildPythonPackage rec {
  pname = "kernel_driver";
  version = "0.0.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "8982df2277daf377a5932663c68cf0c2d667ac51ed12dc0b15553991e7dc79fh";
  };

  #postConfigure = ''
  #  substituteInPlace tidal_dl/__init__.py --replace 'filename=getLogPath(),' ' '
  #'';

  doCheck = false;

  meta = with lib; {
    description = "A library for executing code in a Jupyter kernel.";
    homepage = "https://github.com/davidbrochart/kernel_driver";
    license = licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
