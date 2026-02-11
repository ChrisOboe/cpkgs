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
  rich,
  click-help-colors,
  deezer-py,
  pytest-asyncio,
  pytest-mock,
  aiolimiter,
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
  version = "2.1.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "nathom";
    repo = "streamrip";
    rev = "v${version}";
    sha256 = "sha256-Klrkz0U36EIGO2sNxTnKPACvvqu1sslLFFrQRjFdxiE=";
  };

  patchPhase = ''
    substituteInPlace pyproject.toml \
      --replace-fail 'aiofiles = "^0.7"' 'aiofiles = "*"' \
      --replace-fail 'deezer-py = "1.3.6"' 'deezer-py = "*"' \
      --replace-fail 'm3u8 = "^0.9.0"' 'm3u8 = "*"' \
      --replace-fail 'pathvalidate = "^2.4.1"' 'pathvalidate = "*"' \
      --replace-fail 'pytest-asyncio = "^0.21.1"' 'pytest-asyncio= "*"' \
      --replace-fail 'tomlkit = "^0.7.2"' 'tomlkit = "*"'
  '';

  propagatedBuildInputs = [
    requests
    poetry-core
    mutagen
    click
    tqdm
    tomlkit
    pathvalidate
    rich
    simple-term-menu
    pick
    pillow
    deezer-py
    pycryptodomex
    cleo
    appdirs
    click-help-colors
    m3u8
    aiofiles
    aiolimiter
    aiohttp
    aiodns
    pytest-asyncio
    pytest-mock
  ];

  meta = with lib; {
    description = "A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer";
    homepage = "https://github.com/nathom/streamrip";
    license = licenses.gpl3;
    maintainers = ["chris@oboe.email"];
  };
}
