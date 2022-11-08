{
  mkDerivation,
  lib,
  fetchFromGitHub,
  qtbase,
  qtquickcontrols,
  qtscript,
  qtdeclarative,
  qtserialport,
  qtsvg,
  qtwebengine,
  cmake,
  ninja,
  llvmPackages_14,
  clang_14,
  python3,
  elfutils,
}:
mkDerivation rec {
  pname = "qt-creator";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "qt-creator";
    repo = "qt-creator";
    rev = "v${version}";
    sha256 = "sha256-qnuOe/mbmUg7InLNqO08I6KjhdwvSUhn4iG8o9dJLXk=";
  };

  buildInputs = [qtbase qtscript qtquickcontrols qtdeclarative qtserialport qtsvg qtwebengine elfutils.dev llvmPackages_14.libclang llvmPackages_14.llvm];

  nativeBuildInputs = [cmake ninja python3];

  doCheck = true;

  installFlags = ["INSTALL_ROOT=$(out)"];

  preConfigure = ''
    cmakeFlags="$cmakeFlags -DCMAKE_INSTALL_DATAROOTDIR=$out/share -DWITH_DOCS=ON -DWITH_ONLINE_DOCS=ON"
  '';

  preInstall = ''
    mkdir -p $out/share/qtcreator/QtProject/qtcreator
    ln -s /etc/qtcreator/qtversion.xml $out/share/qtcreator/QtProject/qtcreator/qtversion.xml
  '';

  meta = {
    description = "Cross-platform IDE tailored to the needs of Qt developers";
    longDescription = ''
      Qt Creator is a cross-platform IDE (integrated development environment)
      tailored to the needs of Qt developers. It includes features such as an
      advanced code editor, a visual debugger and a GUI designer.
    '';
    homepage = "https://wiki.qt.io/Category:Tools::QtCreator";
    license = "LGPL";
    maintainers = ["chris@oboe.email"];
    platforms = ["i686-linux" "x86_64-linux" "aarch64-linux" "armv7l-linux"];
  };
}
