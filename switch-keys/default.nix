{
  lib,
  stdenv,
  fetchzip,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "nintendo-switch-keys";
  version = "17.0.0";

  src = fetchzip {
    url = "https://yuzuprodkeys.com/wp-content/uploads/2023/12/YuzuProdkKeys.com-V17.0.0.zip";
    hash = "sha256-n4S8Z6Gsk6dw7BAaHLxbXAN5BqlRpA8p2dyimMxDSiQ=";
  };

  installPhase = ''
    mkdir $out
    cp TheProdkKeys.com-V17.0.0/TheProdkKeys.com-V17.0.0/* $out/
  '';

  meta = with lib; {
    description = "Nintendo Switch Keys";
    license = licenses.unfree;
    maintainers = ["chris@oboe.email"];
  };
}
