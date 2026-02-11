{
  lib,
  fetchFromGitHub,
  cmake,
  stdenv,
  ninja,
  pkg-config,
  qt6, # base serialport
  shared-mime-info,
  pipewire, # lib
  flatbuffers,
  mbedtls,
  alsa-lib,
}:
stdenv.mkDerivation rec {
  pname = "hyperhdr";
  version = "22.0.0.0beta1";

  src = fetchFromGitHub {
    owner = "awawa-dev";
    repo = "HyperHDR";
    rev = "v${version}";
    sha256 = "sha256-9GfQu+uSMcjLRx9oqzDZzoaATPgXiXqTaLCWPH74/cU=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtserialport
    qt6.qtwayland
    shared-mime-info
    mbedtls
    flatbuffers
    pipewire
    alsa-lib
  ];

  # hyperion calls FlatBuffers Flatbuffers (lowercased b), cmake then can't find it
  postPatch = ''
    # remove some wierd defaults
    sed -i 's/DEFAULT_BONJOUR  *ON/DEFAULT_BONJOUR OFF/g' CMakeLists.txt # needs a dependency that is not packaged
    sed -i 's/NOT ENABLE_BONJOUR/ASDF/g' CMakeLists.txt

    # mime type handling isn't working. don't know why.
    substituteInPlace sources/webserver/StaticFileServing.cpp \
      --replace 'reply->addHeader("Content-Type", mime.name().toLocal8Bit());' ""
  '';

  cmakeFlags = [
    "-DUSE_SYSTEM_MBEDTLS_LIBS=ON"
    "-DUSE_SYSTEM_FLATBUFFERS_LIBS=ON"
    "-DENABLE_LDGOLD=OFF"
    "-DENABLE_BONJOUR=OFF"
    "-DENABLE_MQTT=OFF"
    "-DENABLE_PROGRAMS=ON"
    "-DENABLE_PROFOBUF=OFF"
    "-DENABLE_SOUNDCAPLINUX=OFF"
    "-DENABLE_SPIDEV=OFF"
    "-DENABLE_V4L2=OFF"
    "-DUSE_SHARED_MBEDTLS_LIBRARY=ON"
  ];

  env.NIX_CFLAGS_COMPILE = "-std=c++17";

  qtWrapperArgs = [''--prefix XDG_DATA_DIRS : "${shared-mime-info}/share"''];

  # official install tries to install every dependency -.-
  # so we can't use that.
  installPhase = ''
    mkdir -p "$out/bin"
    mkdir "$out/lib"

    cp -r bin/* "$out/bin"
    cp -r lib/*.so* "$out/lib"
  '';

  meta = with lib; {
    homepage = "https://www.hyperhdr.eu";
    description = "An opensource ambient lightning implementation";
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
