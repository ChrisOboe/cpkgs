{ lib
, buildPythonPackage
, fetchPypi
, flit
, requests
, websockets
}:

buildPythonPackage rec {
  pname = "mopidyapi";
  version = "1.1.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-n1BJGHFZvuGSSumEXWIjH/CiHs5w/8skhz7yfR7Jplw=";
  };

  buildInputs = [
    requests
    websockets
    flit
  ];

  meta = with lib; {
    description = "A Python 3.6+ Mopidy client library, that uses HTTP and Websockets to talk to its JSON RPC API.";
    homepage = "https://github.com/AsbjornOlling/mopidyapi";
    license = licenses.gpl3;
    maintainers = ["chris@oboe.email"];
  };

}
