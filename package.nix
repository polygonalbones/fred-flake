{
  lib,
  stdenv,
  requireFile,
  autoPatchelfHook,
  copyDesktopItems,
  gcc,
  libGL,
  libx11,
  libxext,
  libxrandr,
  makeDesktopItem,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "fred";
  version = "0.29.0";

  src = requireFile {
    name = "fred-linux";
    url = "https://fred-dev.tech/";
    hash = "sha256-0ILLd02V0wBafRUsSqGWiSY31ftiHm2x6QxWvV9jEYc=";
  };

  dontUnpack = true;
  dontStrip = true;

  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
  ];

  buildInputs = [
    libGL
    libx11
    libxext
    libxrandr
    gcc.cc.lib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/fred
    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = finalAttrs.pname;
      exec = finalAttrs.pname;
      icon = ./fred.svg;
      desktopName = finalAttrs.pname;
      comment = "Fred text editor";
      categories = [ "Development" ];
      startupWMClass = finalAttrs.pname;
    })
  ];
})
