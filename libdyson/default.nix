{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonPackages,
}:
buildPythonPackage rec {
  pname = "libdyson";
  version = "0.8.11";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-yvHzE6Qc46vinRdV5Xfg+A0AhWCh+yWOtDyrQ/xC2Xs=";
  };

  buildInputs = with pythonPackages; [
    pytest
  ];

  propagatedBuildInputs = with pythonPackages; [
    paho-mqtt
    cryptography
    requests
    zeroconf
    attrs
  ];

  meta = with lib; {
    description = "Python library for Dyson devices";
    homepage = "https://github.com/shenxn/libdyson";
    license = licenses.asl20;
    maintainers = with maintainers; ["chris@oboe.email"];
  };
}
