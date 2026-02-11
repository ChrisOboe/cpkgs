{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
  pkgs,
}:
buildGoModule rec {
  pname = "ha-mqtt-iot";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "W-Floyd";
    repo = "ha-mqtt-iot";
    rev = "${version}";
    sha256 = "sha256-XVUIVp3Is7FgqIyZ/fomade/IRCh1mfd3OYDkAPx8rQ=";
  };
  vendorHash = "sha256-IyksR5I7T2QBZwXt/zQt0wTXmkpcDFxgBRHvdv9xl/g=";

  meta = {
    description = " A simple configurable MQTT client that allows actions to be taken or values be reported from a PC ";
    homepage = "https://github.com/W-Floyd/ha-mqtt-iot";
    maintainers = ["chris@oboe.email"];
  };
}
