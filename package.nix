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
  version = "unstable-2026-06-11";

  src = requireFile {
    name = "fred-linux";
    url = "https://fred-dev.tech/";
    sha256 = "0q1393jzp8dacpa5f4p58n335pb7nkx69kmzcr39b7yhrgd78pzg";
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
