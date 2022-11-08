{
  lib,
  fetchFromGitHub,
  mkDerivation,
  cmake,
  qtbase,
  qtserialport,
  qtsvg,
  qtx11extras,
  libusb1,
  python3,
  python3Packages,
  libcec,
  libxcb,
  libXrandr,
  avahi-compat,
  libjpeg,
  flatbuffers,
  protobuf,
  zlib,
  mbedtls,
}:
mkDerivation rec {
  pname = "hyperion.ng";
  version = "2.0.13";

  src = fetchFromGitHub {
    owner = "hyperion-project";
    repo = "hyperion.ng";
    rev = "${version}";
    sha256 = "sha256-TmswHwrRL7PyhDAzNW7gQ1/7YcRL1BA4s8p7xKmztmU=";
  };

  nativeBuildInputs = [
    cmake
    protobuf
  ];

  buildInputs =
    [
      qtbase
      qtserialport
      qtsvg
      qtx11extras
      libusb1
      python3
      libcec
      libxcb
      libXrandr
      avahi-compat
      libjpeg
      mbedtls
      zlib
      flatbuffers
    ]
    ++ (with python3Packages; []);

  # hyperion calls FlatBuffers Flatbuffers (lowercased b), cmake then can't find it
  patchPhase = ''
    substituteInPlace dependencies/CMakeLists.txt --replace 'find_package(Flatbuffers' 'find_package(FlatBuffers'
  '';

  cmakeFlags = [
    "-DUSE_SHARED_AVAHI_LIBS=ON"
    "-DUSE_SYSTEM_FLATBUFFERS_LIBS=ON"
    "-DUSE_SYSTEM_PROTO_LIBS=ON"
    "-DUSE_SYSTEM_MBEDTLS_LIBS=ON"
    "-DUSE_SYSTEM_QMDNS_LIBS=ON"
    "-DENABLE_DEPLOY_DEPENDENCIES=OFF" # lol no

    "-DENABLE_AMLOGIC=OFF"
    "-DENABLE_DISPMANX=OFF"
    "-DENABLE_OSX=OFF"
    "-DENABLE_QT=ON"
    "-DENABLE_X11=ON"
    "-DENABLE_XCB=ON"
    "-DENABLE_WS281XPWM=OFF" # doesn't build
    "-DENABLE_AVAHI=OFF"
    "-DENABLE_MDNS=OFF" # needs qmdnswhatever which isn't packaged in nixpkgs

    "-DENABLE_V4L2=OFF"
    "-DENABLE_SPIDEV=OFF"
    "-DENABLE_TINKERFORGE=OFF"
    "-DENABLE_FB=OFF"
    "-DENABLE_USB_HID=OFF"
    "-DENABLE_CEC=OFF"
  ];

  meta = with lib; {
    homepage = "https://github.com/hyperion-project/hyperion.ng";
    description = "An opensource Bias or Ambient Lightning implementation";
    platforms = platforms.linux;
    maintainers = ["chris@oboe.email"];
  };
}
