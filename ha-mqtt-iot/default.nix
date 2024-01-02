{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  pkgs,
}:
buildGoModule rec {
  pname = "ha-mqtt-iot";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "W-Floyd";
    repo = "ha-mqtt-iot";
    rev = "${version}";
    sha256 = "sha256-s9fLf6HdPCpXaS31nRvqyCeH+oHFyKHaC6Z3brx0TnI=";
  };
  vendorHash = "sha256-fgHOsw3TCeEqm04ynI4R09xwo9QAjfoyYdwQU0AOCKk=";

  meta = {
    description = " A simple configurable MQTT client that allows actions to be taken or values be reported from a PC ";
    homepage = "https://github.com/W-Floyd/ha-mqtt-iot";
    maintainers = ["chris@oboe.email"];
  };
}
