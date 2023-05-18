{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  requests,
  mutagen,
  click,
  tqdm,
  tomlkit,
  poetry-core,
  pathvalidate,
  simple-term-menu,
  pick,
  pillow,
  deezer-py,
  pycryptodomex,
  cleo,
  appdirs,
  m3u8,
  aiofiles,
  aiohttp,
  aiodns,
}:
buildPythonPackage rec {
  pname = "streamrip";
  version = "1.9.7";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "nathom";
    repo = "streamrip";
    rev = "v${version}";
    sha256 = "sha256-R3b3eIcTzEqx8YPvwAF3GpLKqBBqtKnGx8U88LXJRk4=";
  };

  patchPhase = ''
    substituteInPlace pyproject.toml \
      --replace 'cleo = {version = "1.0.0a4", allow-prereleases = true}' 'cleo = "*"' \
      --replace 'deezer-py = "1.3.6"' 'deezer-py = "^1.3.6"' \
      --replace 'tomlkit = "^0.7.2"' 'tomlkit = "^0"' \
      --replace 'aiofiles = "^0.7.0"' 'aiofiles = "*"' \
      --replace 'm3u8 = "^0.9.0"' 'm3u8 = "*"'
  '';

  propagatedBuildInputs = [
    requests
    poetry-core
    mutagen
    click
    tqdm
    tomlkit
    pathvalidate
    simple-term-menu
    pick
    pillow
    deezer-py
    pycryptodomex
    cleo
    appdirs
    m3u8
    aiofiles
    aiohttp
    aiodns
  ];

  meta = with lib; {
    description = "A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer";
    homepage = "https://github.com/nathom/streamrip";
    license = licenses.gpl3;
    maintainers = ["chris@oboe.email"];
  };
}
