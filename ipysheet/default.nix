{
  lib,
  buildPythonPackage,
  fetchPypi,
  python,
  ipython,
  ipykernel,
  ipywidgets,
  jupyterlab,
  jupyterlab-widgets,
  jupyter-packaging,
  notebook,
  widgetsnbextension,
}:
buildPythonPackage rec {
  pname = "ipysheet";
  version = "0.5.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "cUgEqebn5BPvjnT84CZYcjmoU8ORIGDC/PX43OC322w=";
  };

  buildInputs = [
    jupyter-packaging
    jupyterlab
    ipywidgets
  ];

  propagatedBuildInputs = [
    ipython
    ipykernel
    jupyterlab-widgets
    notebook
    widgetsnbextension
  ];

  doCheck = false;

  meta = {
    description = "Jupyter handsontable integration";
    homepage = "https://github.com/QuantStack/ipysheet";
    license = lib.licenses.mit;
    maintainers = ["chris@oboe.email"];
  };
}
